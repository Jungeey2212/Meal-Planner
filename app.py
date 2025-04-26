from flask import Flask, render_template, request, flash, redirect, url_for, session, jsonify
import mysql.connector
from mysql.connector import Error
import os
from dotenv import load_dotenv
import logging
from datetime import datetime
import json
from functools import wraps

# Load environment variables
load_dotenv()

# Configure logging
logging.basicConfig(
    filename=f'app_logs_{datetime.now().strftime("%Y%m%d")}.log',
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

app = Flask(__name__)
app.secret_key = os.getenv('SECRET_KEY', 'dev_secret_key_replace_in_production')

# Database configuration from environment variables
DB_CONFIG = {
    "host": os.getenv('DB_HOST', 'localhost'),
    "user": os.getenv('DB_USER', 'root'),
    "password": os.getenv('DB_PASSWORD', 'ISBS304'),
    "database": os.getenv('DB_NAME', 'mealplans')
}

def get_db_connection():
    """Establish and return a database connection"""
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        return conn
    except Error as e:
        logging.error(f"Database connection error: {e}")
        return None

def db_connection_required(f):
    """Decorator to ensure database connection is available"""
    @wraps(f)
    def decorated_function(*args, **kwargs):
        conn = get_db_connection()
        if conn is None:
            flash("Unable to connect to the database. Please try again later.", "error")
            return redirect(url_for('form1'))
        return f(conn=conn, *args, **kwargs)
    return decorated_function

def validate_input(age, gender, weight, height, target):
    """Validate basic user profile input data"""
    errors = []
    
    # Check required fields
    if not all([age, gender, weight, height, target]):
        errors.append("All fields are required")
        return False, errors
    
    # Validate numeric inputs
    try:
        weight_float = float(weight)
        height_float = float(height)
        if weight_float <= 0 or height_float <= 0:
            errors.append("Weight and height must be positive numbers")
    except ValueError:
        errors.append("Weight and height must be valid numbers")
    
    # Validate age range format
    valid_age_ranges = ["12-18", "19-25", "26-32", "33-64", "65+"]
    if age not in valid_age_ranges:
        errors.append("Invalid age range selected")
    
    # Validate gender
    valid_genders = ["Male", "Female", "Other"]
    if gender not in valid_genders:
        errors.append("Invalid gender selected")
    
    # Validate fitness target
    valid_targets = ["Lose weight", "Gain muscle", "Improve stamina", "General fitness", "Bulking"]
    if target not in valid_targets:
        errors.append("Invalid fitness target selected")
    
    return len(errors) == 0, errors

def calculate_bmi(weight, height):
    """Calculate BMI from weight (kg) and height (cm)"""
    try:
        weight_float = float(weight)
        height_float = float(height) / 100  # Convert cm to m
        bmi = weight_float / (height_float ** 2)
        return bmi
    except (ValueError, ZeroDivisionError) as e:
        logging.error(f"BMI calculation error: {e}")
        return None

def get_bmi_category(bmi):
    """Get BMI category and description based on calculated BMI"""
    if bmi < 18.5:
        return "Underweight", "Consider consulting with a healthcare professional about a healthy weight gain plan."
    elif 18.5 <= bmi < 25:
        return "Normal", "You're at a healthy weight. Maintain a balanced diet and regular exercise."
    elif 25 <= bmi < 30:
        return "Overweight", "Consider moderate weight loss through improved diet and increased physical activity."
    else:
        return "Obese", "Consider talking to a healthcare provider about weight management strategies."

def filter_meals(conn, form_data):
    """Filter meals based on user input parameters from all forms"""
    try:
        cursor = conn.cursor(dictionary=True)
        
        # Extract basic profile data
        age = form_data.get('ageRange')
        gender = form_data.get('gender')
        weight = form_data.get('weight')
        height = form_data.get('height')
        target = form_data.get('fitnessTarget')
        
        # Lifestyle data
        activity_level = form_data.get('activity_level')
        diet_current = form_data.get('dietcurrent')
        cook_home = form_data.get('cook_home')
        dietaries = form_data.get('dietaries')
        disliked_ingredients = form_data.get('disliked_ingredients')
        
        # Meal preferences
        meal_preference = form_data.get('meal_preference')
        specific_nutrition = form_data.get('specific_nutrition', [])
        
        # Calculate BMI
        bmi = calculate_bmi(weight, height)
        if bmi is None:
            return []
        
        # Define the base query using the actual schema
        query = """
        SELECT m.NutritionID, m.MealName, m.Calories_cal, m.Protein_g, 
               m.Carbs_g, m.Fibers_g, m.Fat_g, m.Calcium_mg, m.Iron_mg,
               m.Ingredients, m.DietNotes, dc.CategoryName, m.IsHomeCooked, 
               m.IsMealorSnack
        FROM meals m
        JOIN diet_categories dc ON m.CategoryID = dc.CategoryID
        WHERE 1=1 AND m.IsMealorSnack = 'Meal'
        """
        
        params = {}
        
        # Apply filter based on diet type
        if diet_current:
            diet_category_map = {
                'vegan': 3,  # Vegan CategoryID
                'vegetarian': 2,  # Vegetarian CategoryID
                'mixed_mostlymeat': 5,  # Omnivore CategoryID
                'mixed_mostlyveggies': 5,  # Omnivore CategoryID
                'omnivore': 5  # Omnivore CategoryID
            }
            
            if diet_current in diet_category_map:
                query += " AND m.CategoryID = %(diet_category)s"
                params['diet_category'] = diet_category_map[diet_current]
        
        # Filter based on fitness target
        if target:
            target_filters = []
            
            if target == "Lose weight":
                target_filters.append("m.Calories_cal <= %(max_calories)s AND m.Protein_g >= %(min_protein)s")
                params["max_calories"] = 500
                params["min_protein"] = 25
            elif target in ["Gain muscle", "Bulking"]:
                target_filters.append("m.Protein_g >= %(high_protein)s")
                params["high_protein"] = 40
            elif target == "Improve stamina":
                target_filters.append("m.Carbs_g >= %(min_carbs)s")
                params["min_carbs"] = 30
            
            if target_filters:
                query += " AND (" + " OR ".join(target_filters) + ")"
        
        # Filter based on age
        if age:
            age_filters = []
            
            if age == "12-18":
                age_filters.append("m.Calories_cal >= %(youth_calories)s AND m.Protein_g >= %(youth_protein)s")
                params["youth_calories"] = 500
                params["youth_protein"] = 25
            elif age in ["19-25", "26-32"]:
                # Young adults - might need higher protein
                age_filters.append("m.Protein_g >= %(young_adult_protein)s")
                params["young_adult_protein"] = 30
            elif age == "33-64":
                age_filters.append("m.Calories_cal <= %(adult_calories)s AND m.Fibers_g >= %(adult_fiber)s")
                params["adult_calories"] = 600
                params["adult_fiber"] = 5
            elif age == "65+":
                age_filters.append("m.Calcium_mg >= %(senior_calcium)s AND m.Protein_g >= %(senior_protein)s")
                params["senior_calcium"] = 200
                params["senior_protein"] = 20
            
            if age_filters:
                query += " AND (" + " OR ".join(age_filters) + ")"
        
        # Filter based on gender
        if gender == "Female":
            query += " AND m.Iron_mg >= %(female_iron)s"
            params["female_iron"] = 2
        
        # Filter based on BMI
        if bmi is not None:
            bmi_filters = []
            
            if bmi < 18.5:
                bmi_filters.append("m.Calories_cal >= %(underweight_calories)s")
                params["underweight_calories"] = 600
            elif 25 <= bmi < 30:
                bmi_filters.append("m.Calories_cal <= %(overweight_calories)s AND m.Fat_g <= %(overweight_fat)s")
                params["overweight_calories"] = 600
                params["overweight_fat"] = 20
            elif bmi >= 30:
                bmi_filters.append("m.Calories_cal <= %(obese_calories)s AND m.Fat_g <= %(obese_fat)s AND m.Fibers_g >= %(obese_fiber)s")
                params["obese_calories"] = 500
                params["obese_fat"] = 15
                params["obese_fiber"] = 5
            
            if bmi_filters:
                query += " AND (" + " OR ".join(bmi_filters) + ")"
        
        # Filter based on dietary requirements/notes
        if dietaries and dietaries != "None":
            dietary_conditions = []
            
            if dietaries == "GF":
                dietary_conditions.append("m.DietNotes LIKE '%GF%'")
            elif dietaries == "DF":
                dietary_conditions.append("m.DietNotes LIKE '%DF%'")
            elif dietaries == "NF":
                dietary_conditions.append("m.DietNotes LIKE '%NF%'")
            elif dietaries in ["Halal", "NoPork"]:
                dietary_conditions.append("m.DietNotes LIKE '%No Pork%'")
            elif dietaries == "noSF":
                dietary_conditions.append("m.DietNotes LIKE '%No Fish%'")
            
            if dietary_conditions:
                query += " AND (" + " OR ".join(dietary_conditions) + ")"
        
        # Filter based on home-cooked preference
        if meal_preference:
            if meal_preference == "Home_cooked":
                query += " AND m.IsHomeCooked = TRUE"
            elif meal_preference == "Processed":
                query += " AND m.IsHomeCooked = FALSE"
        
        # Filter based on disliked ingredients
        if disliked_ingredients and isinstance(disliked_ingredients, list) and len(disliked_ingredients) > 0:
            ingredient_conditions = []
            for ingredient in disliked_ingredients:
                ingredient_conditions.append("m.Ingredients NOT LIKE %(disliked_" + ingredient + ")s")
                params["disliked_" + ingredient] = f"%{ingredient}%"
            
            if ingredient_conditions:
                query += " AND " + " AND ".join(ingredient_conditions)
        
        # Add sorting
        query += " ORDER BY "
        if target == "Lose weight":
            query += "m.Calories_cal ASC, m.Protein_g DESC"
        elif target in ["Gain muscle", "Bulking"]:
            query += "m.Protein_g DESC, m.Calories_cal DESC"
        elif target == "Improve stamina":
            query += "m.Carbs_g DESC, m.Calories_cal DESC"
        else:
            query += "m.MealName ASC"
        
        # Add limit
        query += " LIMIT %(limit)s"
        params["limit"] = int(os.getenv('MEALS_PER_PAGE', 20))
        
        # Log the query for debugging
        logging.info(f"Executing query: {query}")
        logging.info(f"With parameters: {params}")
        
        # Execute the query
        cursor.execute(query, params)
        meals = cursor.fetchall()
        cursor.close()
        return meals
        
    except Error as e:
        logging.error(f"Database error in filter_meals: {e}")
        return []

@app.route('/')
def form1():
    """Render the first form page"""
    return render_template('form1.html')

@app.route('/form2')
def form2():
    """Render the second form page"""
    # Store form1 data in session
    for key, value in request.args.items():
        session[key] = value
    
    return render_template('form2.html')

@app.route('/form3')
def form3():
    """Render the third form page"""
    # Store form2 data in session
    for key, value in request.args.items():
        session[key] = value
    
    # Handle multi-select fields that might come as lists
    if 'disliked_ingredients[]' in request.args:
        session['disliked_ingredients'] = request.args.getlist('disliked_ingredients[]')
    
    return render_template('form3.html')

@app.route('/submit', methods=['POST'])
@db_connection_required
def submit(conn):
    """Process the final form submission and generate meal plans"""
    # Combine all form data from session and current form
    form_data = dict(session)
    
    # Add form3 data
    for key, value in request.form.items():
        form_data[key] = value
    
    # Handle multi-select fields
    if 'specific_nutrition[]' in request.form:
        form_data['specific_nutrition'] = request.form.getlist('specific_nutrition[]')
    
    # Validate basic profile data
    is_valid, errors = validate_input(
        form_data.get('ageRange'), 
        form_data.get('gender'),
        form_data.get('weight'),
        form_data.get('height'),
        form_data.get('fitnessTarget')
    )
    
    if not is_valid:
        for error in errors:
            flash(error, "error")
        return redirect(url_for('form1'))
    
    # Get filtered meals
    meals = filter_meals(conn, form_data)
    
    # Log the query information
    logging.info(f"Query executed: Form data: {json.dumps(form_data, default=str)}, Results: {len(meals)}")
    
    if not meals:
        flash("No matching meal plans found. Try different criteria.", "info")
    
    # Calculate BMI for context
    bmi = calculate_bmi(form_data.get('weight'), form_data.get('height'))
    bmi_category, bmi_description = get_bmi_category(bmi) if bmi else ("Unknown", "")
    
    # Pass user info to template for context
    user_info = {
        'age': form_data.get('ageRange'),
        'gender': form_data.get('gender'),
        'weight': form_data.get('weight'),
        'height': form_data.get('height'),
        'target': form_data.get('fitnessTarget'),
        'bmi': bmi,
        'bmi_category': bmi_category,
        'bmi_description': bmi_description,
        'activity_level': form_data.get('activity_level'),
        'diet_current': form_data.get('dietcurrent'),
        'plan_duration': form_data.get('plan_duration')
    }
    
    # Clear the session after generating the meal plan
    session.clear()
    
    return render_template('meal_plan.html', meals=meals, user_info=user_info)

@app.route('/calculate-bmi')
def calculate_bmi_api():
    """API endpoint to calculate BMI"""
    weight = request.args.get('weight')
    height = request.args.get('height')
    
    try:
        bmi = calculate_bmi(weight, height)
        bmi_category, bmi_description = get_bmi_category(bmi)
        
        return jsonify({
            'bmi': round(bmi, 1),
            'category': bmi_category,
            'description': bmi_description
        })
    except:
        return jsonify({'error': 'Invalid input parameters'}), 400

@app.route('/sample-meal-plan')
@db_connection_required
def sample_meal_plan(conn):
    """Generate a sample meal plan using the stored procedure"""
    try:
        diet_category = request.args.get('diet', 'Omnivore')
        max_calories = request.args.get('calories', 2000)
        
        cursor = conn.cursor(dictionary=True)
        cursor.callproc('create_meal_plan', [diet_category, int(max_calories)])
        
        results = []
        for result in cursor.stored_results():
            results.extend(result.fetchall())
        
        cursor.close()
        
        # Organize by meal time
        meal_plan = {
            'Breakfast': [],
            'Lunch': [],
            'Dinner': [],
            'Snack': []
        }
        
        for meal in results:
            if meal['MealTime'] in meal_plan:
                meal_plan[meal['MealTime']].append(meal)
        
        return render_template('sample_meal_plan.html', meal_plan=meal_plan, diet=diet_category, calories=max_calories)
    except Error as e:
        logging.error(f"Error generating sample meal plan: {e}")
        flash("Unable to generate sample meal plan. Please try again later.", "error")
        return redirect(url_for('form1'))
def generate_meal_plan(conn, form_data, filtered_meals):
    """
    Generate a complete meal plan based on user preferences
    
    Args:
        conn: Database connection
        form_data: User form data
        filtered_meals: Pre-filtered meals that match user's criteria
        
    Returns:
        Dictionary with meal plan organized by week, day, and meal time
    """
    try:
        # Extract relevant user preferences
        plan_duration = int(form_data.get('plan_duration', 2))  # Default to 2 weeks if not specified
        meals_per_day = int(form_data.get('meals_per_day', 3))  # Default to 3 meals per day
        
        # If meals_per_day is more than 5, cap it at 5 for practicality
        if meals_per_day > 5:
            meals_per_day = 5
            
        # Convert filtered_meals list to a pool we can draw from
        meal_pool = list(filtered_meals)
        
        # If we don't have enough meals, query more with relaxed criteria
        if len(meal_pool) < (plan_duration * 7 * meals_per_day):
            # Query additional meals with relaxed criteria
            cursor = conn.cursor(dictionary=True)
            
            # Define a simplified query to get more meals
            query = """
            SELECT m.NutritionID, m.MealName, m.Calories_cal, m.Protein_g, 
                   m.Carbs_g, m.Fibers_g, m.Fat_g, m.Calcium_mg, m.Iron_mg,
                   m.Ingredients, m.DietNotes, dc.CategoryName, m.IsHomeCooked, 
                   m.IsMealorSnack
            FROM meals m
            JOIN diet_categories dc ON m.CategoryID = dc.CategoryID
            WHERE m.IsMealorSnack = 'Meal'
                  AND m.NutritionID NOT IN ({})
            ORDER BY RAND()
            LIMIT {}
            """
            
            # Create a list of meal IDs that we already have
            existing_ids = ",".join([str(meal['NutritionID']) for meal in meal_pool]) if meal_pool else "0"
            
            # Calculate how many more meals we need
            additional_meals_needed = (plan_duration * 7 * meals_per_day) - len(meal_pool)
            
            # Execute the query to get more meals
            formatted_query = query.format(existing_ids, additional_meals_needed)
            cursor.execute(formatted_query)
            additional_meals = cursor.fetchall()
            cursor.close()
            
            # Add the additional meals to our pool
            meal_pool.extend(additional_meals)
        
        # Shuffle the meal pool for variety
        import random
        random.shuffle(meal_pool)
        
        # Create structured meal plan
        meal_plan = {}
        
        # Define meal times based on meals_per_day
        meal_times = []
        if meals_per_day >= 1:
            meal_times.append("Breakfast")
        if meals_per_day >= 2:
            meal_times.append("Lunch")
        if meals_per_day >= 3:
            meal_times.append("Dinner")
        if meals_per_day >= 4:
            meal_times.append("Morning Snack")
        if meals_per_day >= 5:
            meal_times.append("Afternoon Snack")
        
        # Days of the week
        days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        
        # Distribute meals across the meal plan
        meal_index = 0
        for week in range(1, plan_duration + 1):
            meal_plan[f"Week {week}"] = {}
            
            for day in days:
                meal_plan[f"Week {week}"][day] = {}
                
                for meal_time in meal_times:
                    # If we've used all meals, loop back to the beginning of the pool
                    if meal_index >= len(meal_pool):
                        meal_index = 0
                        random.shuffle(meal_pool)  # Re-shuffle for variety
                    
                    meal_plan[f"Week {week}"][day][meal_time] = meal_pool[meal_index]
                    meal_index += 1
        
        return meal_plan
        
    except Exception as e:
        import logging
        logging.error(f"Error generating meal plan: {e}")
        return {}    

@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404

@app.errorhandler(500)
def server_error(e):
    logging.error(f"Server error: {e}")
    return render_template('500.html'), 500

if __name__ == '__main__':
    # Check if database connection works
    test_conn = get_db_connection()
    if test_conn:
        test_conn.close()
        print("Database connection successful")
    else:
        print("WARNING: Could not connect to database. Please check your configuration.")
    
    # Run the application
    app.run(debug=os.getenv('FLASK_DEBUG', 'False').lower() == 'true')