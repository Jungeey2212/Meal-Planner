-- Database creation
CREATE DATABASE IF NOT EXISTS f45_meal_planner;
USE f45_meal_planner;

-- System Administrators table
CREATE TABLE administrators (
    admin_id INT(6) AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);



-- Nutritionists/Dieticians table
CREATE TABLE nutritionists (
    nutritionist_id INT(4) AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Gym Coaches/Trainers table
CREATE TABLE coaches (
    coach_id INT(5) AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Fitness Goals table
CREATE TABLE fitness_goals (
    goal_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT(10) NOT NULL,
    goal_type VARCHAR(100) NOT NULL, -- weight loss, muscle gain, endurance
    target_weight DECIMAL(5,2),
    target_date DATE,
    daily_calorie_target INT,
    protein_target INT,
    carb_target INT,
    fat_target INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
);

-- Dietary Preferences table
CREATE TABLE dietary_preferences (
    preference_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT(10) NOT NULL,
    diet_type VARCHAR(50) NOT NULL, -- vegan, vegetarian, keto, etc.
    allergies TEXT,
    intolerances TEXT,
    preferred_cuisines TEXT,
    disliked_ingredients TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
);

-- Recipes table
CREATE TABLE recipes (
    recipe_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    ingredients TEXT NOT NULL,
    instructions TEXT NOT NULL,
    preparation_time INT, -- in minutes
    cooking_time INT, -- in minutes
    servings INT,
    calories_per_serving INT,
    protein_per_serving DECIMAL(5,2),
    carbs_per_serving DECIMAL(5,2),
    fat_per_serving DECIMAL(5,2),
    dietary_tags VARCHAR(255), -- comma-separated tags like vegan, gluten-free
    image_url VARCHAR(255),
    created_by INT, -- can be admin, nutritionist, or NULL for system
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Meal Plans table
CREATE TABLE meal_plans (
    plan_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT(10) NOT NULL,
    nutritionist_id INT(4),
    coach_id INT(5),
    plan_name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status ENUM('active', 'completed', 'paused') DEFAULT 'active',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    FOREIGN KEY (nutritionist_id) REFERENCES nutritionists(nutritionist_id) ON DELETE SET NULL,
    FOREIGN KEY (coach_id) REFERENCES coaches(coach_id) ON DELETE SET NULL
);

-- Plan Meals table (days of the week)
CREATE TABLE plan_meals (
    meal_id INT AUTO_INCREMENT PRIMARY KEY,
    plan_id INT NOT NULL,
    day_number INT NOT NULL, -- 1-7 for Monday-Sunday
    meal_type ENUM('breakfast', 'lunch', 'dinner', 'snack') NOT NULL,
    recipe_id INT,
    custom_meal_name VARCHAR(100),
    custom_meal_description TEXT,
    notes TEXT,
    FOREIGN KEY (plan_id) REFERENCES meal_plans(plan_id) ON DELETE CASCADE,
    FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id) ON DELETE SET NULL
);

-- Member Progress Tracking
CREATE TABLE member_progress (
    progress_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT(10) NOT NULL,
    entry_date DATE NOT NULL,
    weight DECIMAL(5,2),
    body_fat_percentage DECIMAL(5,2),
    muscle_mass DECIMAL(5,2),
    energy_level INT, -- 1-10 scale
    sleep_quality INT, -- 1-10 scale
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
);

-- Member Feedback on Meals
CREATE TABLE meal_feedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    meal_id INT NOT NULL,
    member_id INT(10) NOT NULL,
    rating INT NOT NULL, -- 1-5 stars
    comments TEXT,
    prepared_as_directed BOOLEAN,
    modifications TEXT,
    feedback_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (meal_id) REFERENCES plan_meals(meal_id) ON DELETE CASCADE,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
);

-- System Logs
CREATE TABLE system_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_type ENUM('admin', 'member', 'nutritionist', 'coach') NOT NULL,
    user_id INT NOT NULL,
    action VARCHAR(255) NOT NULL,
    ip_address VARCHAR(45) NOT NULL,
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample admin
INSERT INTO administrators (first_name, last_name, email, password) 
VALUES ('System', 'Admin', 'admin@f45.com', '$2y$10$Hj5BzO3X9z6Q7f8JkLmNQe9r1s2t3u4v5w6x7y8z9a0b1c2d3e4f5g6h');
