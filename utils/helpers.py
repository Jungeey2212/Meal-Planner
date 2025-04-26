"""
Utils module for the meal planner application
Contains helper functions for various tasks
"""

import logging
import functools
import time
import json
from typing import Dict, List, Any, Optional, Union, Tuple
import os

# Define BMI categories
BMI_CATEGORIES = {
    "underweight": {"max": 18.5, "color": "#ffeaa7", "description": "Consider consulting with a healthcare professional about a healthy weight gain plan."},
    "normal": {"min": 18.5, "max": 25, "color": "#55efc4", "description": "You're at a healthy weight. Maintain a balanced diet and regular exercise."},
    "overweight": {"min": 25, "max": 30, "color": "#fab1a0", "description": "Consider moderate weight loss through improved diet and increased physical activity."},
    "obese": {"min": 30, "color": "#ff7675", "description": "Consider talking to a healthcare provider about weight management strategies."}
}

def timer(func):
    """Decorator to time function execution"""
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        start_time = time.time()
        result = func(*args, **kwargs)
        end_time = time.time()
        logging.info(f"Function {func.__name__} took {end_time - start_time:.2f} seconds to run")
        return result
    return wrapper

def calculate_bmi(weight: Union[str, float], height: Union[str, float]) -> Optional[float]:
    """
    Calculate BMI from weight (kg) and height (cm)
    
    Args:
        weight: Weight in kilograms
        height: Height in centimeters
        
    Returns:
        BMI value or None if calculation fails
    """
    try:
        weight_float = float(weight)
        height_float = float(height) / 100  # Convert cm to m
        
        if weight_float <= 0 or height_float <= 0:
            return None
            
        bmi = weight_float / (height_float ** 2)
        return bmi
    except (ValueError, ZeroDivisionError) as e:
        logging.error(f"BMI calculation error: {e}")
        return None

def get_bmi_category(bmi: float) -> Dict[str, str]:
    """
    Get the BMI category and related information
    
    Args:
        bmi: The BMI value
        
    Returns:
        Dictionary with category, description, and CSS class
    """
    if bmi < BMI_CATEGORIES["underweight"]["max"]:
        return {
            "category": "Underweight",
            "description": BMI_CATEGORIES["underweight"]["description"],
            "css_class": "underweight"
        }
    elif bmi < BMI_CATEGORIES["normal"]["max"]:
        return {
            "category": "Normal",
            "description": BMI_CATEGORIES["normal"]["description"],
            "css_class": "normal"
        }
    elif bmi < BMI_CATEGORIES["overweight"]["max"]:
        return {
            "category": "Overweight",
            "description": BMI_CATEGORIES["overweight"]["description"],
            "css_class": "overweight"
        }
    else:
        return {
            "category": "Obese",
            "description": BMI_CATEGORIES["obese"]["description"],
            "css_class": "obese"
        }

def calculate_daily_calories(
    weight: float, 
    height: float, 
    age: str, 
    gender: str, 
    activity_level: str
) -> int:
    """
    Calculate daily calorie needs based on user information
    
    Args:
        weight: Weight in kg
        height: Height in cm
        age: Age range string
        gender: Gender string
        activity_level: Activity level string
        
    Returns:
        Estimated daily calorie needs
    """
    # Extract numeric age (use average of age range)
    age_num = 0
    if age == "12-18":
        age_num = 15
    elif age == "19-25":
        age_num = 22
    elif age == "26-32":
        age_num = 29
    elif age == "33-64":
        age_num = 48
    elif age == "65+":
        age_num = 70
    
    # Base metabolic rate (BMR) calculation using Mifflin-St Jeor Equation
    if gender == "Male":
        bmr = 10 * weight + 6.25 * height - 5 * age_num + 5
    else:  # Female or Other
        bmr = 10 * weight + 6.25 * height - 5 * age_num - 161
    
    # Activity multiplier
    activity_multipliers = {
        "Sedentary": 1.2,
        "Lightly_active": 1.375,
        "Moderately_active": 1.55,
        "Very_active": 1.725,
        "Extremely_active": 1.9
    }
    
    # Get multiplier with default fallback
    multiplier = activity_multipliers.get(activity_level, 1.375)
    
    # Total daily energy expenditure (TDEE)
    daily_calories = int(bmr * multiplier)
    
    return daily_calories

def format_dietary_preferences(diet_current: str) -> str:
    """
    Format dietary preference for display
    
    Args:
        diet_current: Raw diet type from form
        
    Returns:
        Formatted diet string
    """
    # Dictionary for pretty formatting
    diet_formats = {
        "vegan": "Vegan",
        "vegetarian": "Vegetarian",
        "omnivore": "Omnivore",
        "mixed_mostlymeat": "Mixed (Mostly Meat)",
        "mixed_mostlyveggies": "Mixed (Mostly Vegetables)",
        "other_diet": "Other"
    }
    
    return diet_formats.get(diet_current, diet_current)

def get_meal_category_id(conn, category_name: str) -> Optional[int]:
    """
    Get meal category ID from name
    
    Args:
        conn: Database connection
        category_name: Name of the category
        
    Returns:
        Category ID or None if not found
    """
    try:
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT category_id FROM meal_categories WHERE name = %s", (category_name,))
        result = cursor.fetchone()
        cursor.close()
        
        if result:
            return result['category_id']
        return None
    except Exception as e:
        logging.error(f"Error getting meal category ID: {e}")
        return None

def jsonify_form_data(form_data: Dict) -> str:
    """
    Convert form data to JSON string, handling lists and special types
    
    Args:
        form_data: Dictionary of form data
        
    Returns:
        JSON string representation
    """
    # Create a safe copy that can be serialized
    safe_data = {}
    
    for key, value in form_data.items():
        # Skip session keys that start with underscore
        if key.startswith('_'):
            continue
            
        # Handle lists like disliked_ingredients
        if isinstance(value, list):
            safe_data[key] = value
        else:
            safe_data[key] = str(value)
    
    return json.dumps(safe_data)

def log_form_submission(form_data: Dict) -> None:
    """
    Log form submission data for analytics
    
    Args:
        form_data: Dictionary of form data
    """
    try:
        # Create logs directory if it doesn't exist
        log_dir = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'logs')
        os.makedirs(log_dir, exist_ok=True)
        
        # Log file path
        log_file = os.path.join(log_dir, f'form_submissions_{time.strftime("%Y%m%d")}.log')
        
        # Add timestamp
        log_data = {
            'timestamp': time.strftime('%Y-%m-%d %H:%M:%S'),
            'data': form_data
        }
        
        # Append to log file
        with open(log_file, 'a') as f:
            f.write(json.dumps(log_data) + '\n')
    except Exception as e:
        logging.error(f"Error logging form submission: {e}")