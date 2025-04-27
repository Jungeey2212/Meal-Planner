-- Database creation with proper charset defined at DB level
CREATE DATABASE IF NOT EXISTS mealplans
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE mealplans;
-- Create a normalized diet categories table
CREATE TABLE diet_categories (
  CategoryID      INT             AUTO_INCREMENT PRIMARY KEY,
  CategoryName    VARCHAR(100)    NOT NULL UNIQUE
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Insert diet categories
INSERT INTO diet_categories (CategoryName) VALUES 
  ('Carnivore'),
  ('Vegetarian'), 
  ('Vegan'), 
  ('Pescatarian'),
  ('Omnivore');

-- Optimized meals table with appropriate data types and constraints
CREATE TABLE meals (
  NutritionID     INT             AUTO_INCREMENT PRIMARY KEY,
  MealName        VARCHAR(255)    NOT NULL,
  Calories_cal    SMALLINT        UNSIGNED NULL,
  Protein_g       DECIMAl(5,2)    NOT NULL,
  Carbs_g         DECIMAL(5,2)    NOT NULL,
  Sugars_g        DECIMAL(5,2)    NULL,
  Fibers_g        DECIMAL(5,2)    NULL,
  Fat_g           DECIMAL(5,2)    NULL,
  SatFat_g        DECIMAL(5,2)    NULL,
  UnsatFat_g      DECIMAL(5,2)    NULL,
  Cholesterol_mg  SMALLINT        UNSIGNED NULL,
  Sodium_mg       SMALLINT        UNSIGNED NULL,
  Calcium_mg      SMALLINT        UNSIGNED NULL,
  Iron_mg         DECIMAL(4,2)    NULL,
  Ingredients     TEXT            NULL,
  CategoryID      INT             NOT NULL,
  DietNotes       VARCHAR(255)    NULL,
  IsHomeCooked    BOOLEAN         NOT NULL DEFAULT FALSE,
  IsMealorSnack   ENUM('Meal','Snack') NOT NULL,
  
  -- Add foreign key constraint
  CONSTRAINT fk_diet_category FOREIGN KEY (CategoryID) 
    REFERENCES diet_categories(CategoryID),
    
  -- Add indexes for common search columns
  INDEX idx_meal_name (MealName),
  INDEX idx_meal_type (IsMealorSnack),
  INDEX idx_calories (Calories_cal),
  INDEX idx_homemade (IsHomeCooked)
) 
ENGINE=InnoDB
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;
-- Insert all original meals with appropriate CategoryIDs based on DietCategory
-- First batch: Omnivore/Carnivore meals
INSERT INTO meals (
  MealName, Calories_cal, Protein_g, Carbs_g, Sugars_g, Fibers_g,
  Fat_g, SatFat_g, UnsatFat_g, Cholesterol_mg, Sodium_mg, Calcium_mg, Iron_mg,
  Ingredients, CategoryID, DietNotes, IsHomeCooked, IsMealorSnack
)
VALUES
-- Carnivore meals (CategoryID = 1)
-- Carnivore meals (CategoryID = 1)
('Crispy Chilli Turkey Noodles', 520, 35, 40, 6, 2, 25, 5, 18, 75, 950, 70, 2.1, 'Turkey mince, udon noodles, garlic, chili flakes, soy sauce, honey, spring onions, sesame oil', 1, 'Contains soy and gluten', TRUE, 'Meal'),
('Spicy Lamb & Feta Meatballs', 620, 38, 12, 5, 2, 45, 18, 20, 110, 700, 220, 3.0, 'Lamb mince, feta cheese, onion, garlic, chili flakes, parsley, egg, breadcrumbs, olive oil, tomato sauce', 1, 'Contains dairy and gluten', TRUE, 'Meal'),
('Turkey, Spinach & Feta Burgers', 520, 40, 20, 3, 2, 30, 9, 18, 95, 600, 180, 2.5, 'Turkey mince, spinach, feta, egg, garlic, breadcrumbs, olive oil, burger buns', 1, 'Contains gluten, dairy, and egg', TRUE, 'Meal'),
('Spinach & Feta Burgers', 520, 40, 20, 3, 2, 30, 9, 18, 95, 600, 180, 2.5, 'Turkey mince, spinach, feta, egg, garlic, breadcrumbs, olive oil, burger buns', 1, 'Contains gluten, dairy, and egg', TRUE, 'Meal'),
('Grilled Ribeye Steak', 650, 55, 0, 0, 0, 50, 20, 30, 140, 90, 20, 3.5, 'ribeye steak, salt, pepper', 1, 'GF, NF, No Fish', TRUE, 'Meal'),
('Baked Chicken Thighs', 400, 38, 0, 0, 0, 25, 7, 18, 120, 85, 15, 1.5, 'chicken thighs, olive oil, garlic powder', 1, 'GF, NF, No Fish', TRUE, 'Meal'),
('Pork Belly Slices', 600, 30, 0, 0, 0, 55, 20, 35, 110, 70, 10, 1.8, 'pork belly, salt, paprika', 1, 'GF, NF', TRUE, 'Meal'),
('Lamb Chops', 550, 40, 0, 0, 0, 45, 18, 27, 115, 95, 25, 3.2, 'lamb chops, rosemary, salt, pepper', 1, 'GF, NF, No Fish', TRUE, 'Meal'),
('Beef Liver Fry', 320, 42, 3, 1, 0, 12, 4, 8, 400, 90, 30, 6.0, 'beef liver, butter, salt, onion powder', 1, 'GF, NF, No Fish', TRUE, 'Meal'),
('Grilled Turkey Breast', 280, 48, 0, 0, 0, 6, 2, 4, 90, 75, 15, 1.0, 'turkey breast, olive oil, black pepper', 1, 'GF, NF, No Fish', TRUE, 'Meal'),  
('Duck Breast with Skin', 500, 35, 0, 0, 0, 40, 15, 25, 115, 100, 20, 2.5, 'duck breast, thyme, salt', 1, 'GF, NF, No Fish', TRUE, 'Meal'),
('Meatballs (Beef Only)', 470, 38, 2, 0.5, 0, 32, 12, 20, 100, 85, 22, 2.8, 'ground beef, egg, salt, pepper', 1, 'GF, NF, No Fish', TRUE, 'Meal'),
('Roasted Quail', 330, 30, 0, 0, 0, 22, 8, 14, 90, 60, 15, 2.2, 'quail, butter, rosemary, pepper', 1, 'GF, NF, No Fish', TRUE, 'Meal'),
('Venison Steak', 400, 50, 0, 0, 0, 18, 5, 13, 95, 65, 20, 4.0, 'venison steak, garlic powder, salt', 1, 'GF, NF, No Fish', TRUE, 'Meal'),
('Beef Short Ribs', 700, 45, 0, 0, 0, 60, 22, 38, 130, 120, 25, 3.0, 'beef short ribs, salt, pepper', 1, 'GF, NF, No Fish', TRUE, 'Meal'),
('Grilled Chicken Wings', 450, 35, 0, 0, 0, 30, 10, 20, 110, 140, 18, 1.6, 'chicken wings, paprika, salt', 1, 'GF, NF, No Fish', TRUE, 'Snack'),
('Roasted Duck Legs', 600, 38, 0, 0, 0, 50, 18, 32, 125, 105, 22, 2.7, 'duck legs, garlic, thyme, olive oil', 1, 'GF, NF, No Fish', TRUE, 'Meal'),
('Pork Chops', 520, 40, 0, 0, 0, 40, 15, 25, 115, 90, 18, 2.0, 'pork chops, sage, salt', 1, 'GF, NF', TRUE, 'Meal'),
('Grilled Kangaroo Fillet', 360, 48, 0, 0, 0, 15, 5, 10, 90, 80, 20, 4.5, 'kangaroo fillet, pepper, salt', 1, 'GF, NF, No Fish', TRUE, 'Meal'),
('Roast Goose', 700, 42, 0, 0, 0, 60, 22, 38, 130, 120, 30, 2.8, 'goose, olive oil, rosemary', 1, 'GF, NF, No Fish', TRUE, 'Meal'),
('Crispy Chilli Turkey Noodles', 520, 35, 40, 6, 2, 25, 5, 18, 75, 950, 70, 2.1, 'Turkey mince, udon noodles, garlic, chili flakes, soy sauce, honey, spring onions, sesame oil', 1, 'Contains soy and gluten', TRUE, 'Meal'),
('Spicy Lamb & Feta Meatballs', 620, 38, 12, 5, 2, 45, 18, 20, 110, 700, 220, 3.0, 'Lamb mince, feta cheese, onion, garlic, chili flakes, parsley, egg, breadcrumbs, olive oil, tomato sauce', 1, 'Contains dairy and gluten', TRUE, 'Meal'),
('Grilled Ribeye Steak', 750, 60, 2, 0, 0, 55, 25, 30, 150, 500, 40, 4.2, 'Ribeye steak, salt, pepper, butter', 1, 'Gluten-free', TRUE, 'Meal'),
('BBQ Pulled Pork', 680, 48, 10, 7, 1, 45, 15, 25, 130, 1100, 60, 2.7, 'Pork shoulder, BBQ sauce, onion powder, garlic powder', 1, 'Contains sugar', TRUE, 'Meal'),
('Garlic Butter Chicken Thighs', 550, 40, 5, 1, 0, 35, 12, 20, 95, 600, 50, 2.5, 'Chicken thighs, garlic, butter, thyme, parsley', 1, 'Gluten-free', TRUE, 'Meal'),
('Beef and Bacon Skewers', 620, 45, 4, 2, 0, 48, 18, 25, 140, 950, 45, 3.5, 'Beef cubes, bacon strips, black pepper, olive oil', 1, 'Gluten-free', TRUE, 'Meal'),
('Sausage and Egg Bake', 480, 32, 6, 2, 0, 30, 10, 18, 95, 800, 110, 2.2, 'Pork sausages, eggs, cheddar cheese, spinach', 1, 'Contains dairy', TRUE, 'Meal'),
('Butter-Seared Lamb Chops', 700, 50, 2, 0, 0, 55, 20, 28, 150, 700, 40, 4.1, 'Lamb chops, butter, rosemary, salt', 1, 'Gluten-free', TRUE, 'Meal'),
('Cheddar Stuffed Burgers', 710, 50, 8, 2, 0, 50, 20, 30, 135, 900, 150, 3.8, 'Beef mince, cheddar cheese, garlic, onion powder', 1, 'Contains dairy', TRUE, 'Meal'),
('Honey Glazed Chicken Wings', 620, 38, 15, 8, 0, 40, 12, 25, 110, 800, 60, 2.6, 'Chicken wings, honey, soy sauce, ginger, garlic', 1, 'Contains soy', TRUE, 'Meal'),
('Classic Beef Meatballs', 580, 42, 5, 1, 1, 40, 15, 22, 125, 600, 80, 3.5, 'Beef mince, parmesan, egg, garlic, parsley', 1, 'Contains dairy', TRUE, 'Meal'),
('Pork Belly Bites', 760, 42, 5, 2, 0, 65, 25, 35, 170, 950, 35, 2.5, 'Pork belly, black pepper, sea salt', 1, 'Gluten-free', TRUE, 'Snack'),
('Smoked Beef Brisket', 680, 55, 3, 1, 0, 45, 18, 25, 140, 750, 45, 4.0, 'Beef brisket, paprika, garlic powder, salt, pepper', 1, 'Gluten-free', TRUE, 'Meal'),
('Lamb Liver Fry', 430, 35, 5, 2, 1, 28, 9, 15, 320, 400, 45, 8.1, 'Lamb liver, onions, garlic, turmeric, cumin', 1, 'Gluten-free', TRUE, 'Meal'),
('Chicken Bacon Wraps', 600, 42, 8, 4, 0, 40, 15, 22, 120, 850, 75, 2.8, 'Chicken breast, bacon, cream cheese, chives', 1, 'Contains dairy', TRUE, 'Meal'),
('Duck Breast with Orange Glaze', 650, 45, 10, 6, 1, 45, 18, 25, 155, 700, 40, 3.6, 'Duck breast, orange zest, honey, butter', 1, 'Contains sugar', TRUE, 'Meal'),
('Spicy Beef Jerky', 300, 25, 4, 2, 0, 18, 7, 10, 85, 1200, 20, 3.2, 'Beef strips, soy sauce, chili flakes, garlic powder', 1, 'Contains soy', TRUE, 'Snack'),
('Crispy Chicken Skin Bites', 450, 30, 2, 0, 0, 35, 15, 18, 105, 900, 35, 2.4, 'Chicken skin, paprika, salt, pepper', 1, 'Gluten-free', TRUE, 'Snack'),
('Herb Roasted Turkey Breast', 520, 40, 5, 2, 0, 30, 10, 18, 90, 700, 50, 2.8, 'Turkey breast, rosemary, thyme, olive oil', 1, 'Gluten-free', TRUE, 'Meal'),
('Venison Steak', 550, 48, 3, 0, 0, 30, 12, 16, 95, 500, 45, 5.0, 'Venison steak, salt, pepper, garlic', 1, 'Gluten-free', TRUE, 'Meal'),
('Beef Heart Stew', 610, 50, 6, 3, 1, 40, 14, 22, 210, 600, 55, 8.5, 'Beef heart, onions, carrots, beef broth, pepper', 1, 'Gluten-free', TRUE, 'Meal'),
('Ham and Egg Muffins', 480, 30, 4, 1, 0, 35, 12, 18, 105, 850, 70, 2.9, 'Ham slices, eggs, cheddar cheese, spinach', 1, 'Contains dairy', TRUE, 'Meal'),
('Bacon Wrapped Meatloaf', 730, 50, 8, 3, 0, 55, 20, 30, 140, 1000, 90, 3.8, 'Beef mince, bacon, onion, garlic, tomato paste', 1, 'Contains gluten', TRUE, 'Meal'),
('Crispy Duck Legs', 660, 48, 5, 1, 0, 50, 20, 25, 160, 650, 45, 3.4, 'Duck legs, salt, black pepper, thyme', 1, 'Gluten-free', TRUE, 'Meal'),
('Beef and Egg Breakfast Bowl', 580, 40, 6, 2, 0, 40, 12, 25, 115, 750, 80, 3.0, 'Ground beef, eggs, spinach, butter', 1, 'Contains dairy', TRUE, 'Meal'),
('Lamb Kebabs', 600, 45, 5, 2, 1, 40, 16, 22, 140, 650, 40, 4.2, 'Lamb mince, cumin, paprika, onions, garlic', 1, 'Gluten-free', TRUE, 'Meal'),
('Creamy Chicken Alfredo', 680, 40, 12, 5, 1, 50, 18, 28, 120, 850, 130, 2.9, 'Chicken breast, heavy cream, parmesan cheese, butter, garlic', 1, 'Contains dairy', TRUE, 'Meal'),
('Pepperoni Stuffed Chicken', 580, 42, 4, 2, 0, 40, 15, 20, 115, 900, 60, 3.2, 'Chicken breast, pepperoni, mozzarella cheese, spinach', 1, 'Contains dairy', TRUE, 'Meal'),
('Turkey Meatloaf', 550, 38, 8, 3, 1, 30, 10, 18, 90, 700, 75, 2.6, 'Ground turkey, eggs, onion, garlic, tomato paste', 1, 'Contains gluten', TRUE, 'Meal'),
('Carnivore Pizza', 780, 50, 8, 3, 0, 60, 22, 35, 140, 950, 160, 4.1, 'Beef mince, bacon, ham, mozzarella cheese, pepperoni', 1, 'Contains dairy', TRUE, 'Meal'),
('Sizzling Beef Fajitas', 640, 45, 10, 4, 1, 40, 15, 22, 130, 750, 90, 3.5, 'Beef strips, bell peppers, onions, olive oil', 1, 'Contains soy', TRUE, 'Meal'),
('Grilled Sausage Platter', 720, 50, 5, 2, 0, 55, 20, 30, 150, 1000, 80, 3.6, 'Pork sausages, mustard, pickles', 1, 'Gluten-free', TRUE, 'Meal'),
('Baked Chicken Drumsticks', 580, 42, 4, 1, 0, 38, 14, 20, 120, 800, 70, 3.0, 'Chicken drumsticks, paprika, garlic powder, olive oil', 1, 'Gluten-free', TRUE, 'Meal'),
('Bacon Wrapped Scallops', 440, 30, 3, 0, 0, 30, 12, 18, 90, 600, 45, 2.5, 'Scallops, bacon, lemon zest, butter', 1, 'Contains seafood', TRUE, 'Meal'),
('Grilled Lamb Ribs', 740, 55, 6, 2, 0, 55, 20, 30, 160, 850, 55, 4.5, 'Lamb ribs, rosemary, thyme, garlic', 1, 'Gluten-free', TRUE, 'Meal'),
('Steak and Egg Plate', 680, 50, 2, 1, 0, 48, 18, 28, 135, 700, 90, 3.5, 'Sirloin steak, eggs, butter, salt', 1, 'Gluten-free', TRUE, 'Meal'),
('Rosemary Garlic Lamb Roast', 720, 55, 3, 1, 0, 50, 20, 28, 160, 850, 60, 4.5, 'Lamb leg, garlic cloves, rosemary, olive oil', 1, 'Gluten-free', TRUE, 'Meal'),
('Chorizo Scrambled Eggs', 580, 40, 5, 2, 0, 40, 16, 22, 110, 750, 90, 2.8, 'Chorizo sausage, eggs, cheddar cheese', 1, 'Contains dairy', TRUE, 'Meal'),
('Pork Schnitzel', 670, 45, 8, 3, 1, 45, 18, 25, 140, 800, 70, 3.1, 'Pork cutlet, breadcrumbs, egg, parmesan, olive oil', 1, 'Contains gluten and dairy', TRUE, 'Meal'),
('BBQ Chicken Drumettes', 620, 42, 6, 4, 0, 40, 15, 22, 110, 800, 55, 2.5, 'Chicken drumettes, BBQ sauce, garlic powder', 1, 'Contains sugar', TRUE, 'Meal'),
('Beef Short Ribs', 750, 58, 4, 1, 0, 50, 22, 28, 155, 900, 65, 4.8, 'Beef short ribs, salt, black pepper, garlic', 1, 'Gluten-free', TRUE, 'Meal'),
('Cream Cheese Chicken Roll-Ups', 630, 45, 6, 3, 0, 42, 16, 26, 120, 850, 90, 2.9, 'Chicken breast, cream cheese, spinach, paprika', 1, 'Contains dairy', TRUE, 'Meal'),
('Seared Tuna Steaks', 550, 46, 2, 0, 0, 30, 10, 18, 90, 450, 50, 3.5, 'Tuna steak, sesame oil, black pepper', 1, 'Contains seafood', TRUE, 'Meal'),
('Breakfast Sausage Patties', 510, 35, 3, 1, 0, 38, 15, 20, 105, 750, 70, 2.4, 'Ground pork, sage, thyme, black pepper', 1, 'Gluten-free', TRUE, 'Meal'),
('Stuffed Pork Tenderloin', 690, 50, 7, 2, 1, 48, 20, 28, 140, 850, 65, 3.7, 'Pork tenderloin, mozzarella, spinach, basil', 1, 'Contains dairy', TRUE, 'Meal'),
('Duck Confit', 740, 55, 3, 1, 0, 60, 25, 30, 170, 900, 55, 4.4, 'Duck legs, duck fat, thyme, garlic', 1, 'Gluten-free', TRUE, 'Meal'),
('Turkey Bacon Breakfast Cups', 470, 30, 4, 2, 0, 32, 10, 20, 100, 750, 70, 2.6, 'Turkey bacon, eggs, spinach, cheddar cheese', 1, 'Contains dairy', TRUE, 'Meal'),
('Balsamic Grilled Pork Chops', 600, 45, 5, 3, 1, 40, 16, 22, 130, 800, 60, 3.2, 'Pork chops, balsamic vinegar, garlic, olive oil', 1, 'Gluten-free', TRUE, 'Meal'),
('Lamb and Mint Burgers', 620, 48, 6, 2, 0, 45, 18, 25, 150, 750, 55, 4.2, 'Ground lamb, mint leaves, garlic, onion', 1, 'Gluten-free', TRUE, 'Meal'),
('Parmesan Crusted Chicken', 680, 42, 8, 3, 1, 45, 18, 25, 120, 800, 95, 2.7, 'Chicken breast, parmesan cheese, almond flour', 1, 'Contains dairy and nuts', TRUE, 'Meal'),
('Grilled Salmon Fillets', 590, 45, 3, 1, 0, 35, 12, 20, 100, 550, 60, 3.9, 'Salmon fillet, dill, lemon, olive oil', 1, 'Contains seafood', TRUE, 'Meal'),
('Chili Rubbed Steak', 710, 58, 4, 2, 0, 50, 20, 28, 140, 850, 65, 4.0, 'Sirloin steak, chili powder, cumin, garlic powder', 1, 'Gluten-free', TRUE, 'Meal'),
('Liver and Onions', 490, 40, 6, 3, 1, 30, 10, 18, 300, 450, 45, 7.5, 'Beef liver, onions, butter, black pepper', 1, 'Gluten-free', TRUE, 'Meal'),
('Pastrami and Egg Scramble', 540, 38, 4, 2, 0, 36, 14, 22, 120, 800, 65, 2.7, 'Pastrami slices, eggs, cheddar cheese', 1, 'Contains dairy', TRUE, 'Meal'),
('Duck and Egg Breakfast Bowl', 620, 45, 5, 2, 0, 42, 16, 26, 130, 750, 75, 3.1, 'Duck breast, eggs, spinach, butter', 1, 'Contains dairy', TRUE, 'Meal'),
('Buffalo Chicken Thighs', 640, 42, 6, 3, 0, 45, 18, 28, 140, 850, 55, 2.8, 'Chicken thighs, buffalo sauce, butter, garlic powder', 1, 'Contains dairy', TRUE, 'Meal'),
('Seared Duck Breast', 690, 52, 3, 1, 0, 50, 20, 30, 160, 700, 60, 4.5, 'Duck breast, olive oil, rosemary, black pepper', 1, 'Gluten-free', TRUE, 'Meal'),
('Grilled Turkey Burgers', 580, 42, 5, 2, 1, 35, 12, 20, 95, 750, 65, 2.9, 'Ground turkey, garlic, onion, olive oil', 1, 'Gluten-free', TRUE, 'Meal'),
('Chicken Parmesan Bites', 620, 40, 6, 3, 1, 40, 18, 22, 120, 850, 90, 2.8, 'Chicken breast, parmesan cheese, egg, almond flour', 1, 'Contains dairy and nuts', TRUE, 'Meal'),
('Pork Ribeye Chops', 710, 58, 4, 2, 0, 50, 22, 28, 150, 900, 70, 4.3, 'Pork ribeye chops, garlic, thyme, butter', 1, 'Gluten-free', TRUE, 'Meal'),
('Lemon Butter Salmon', 620, 48, 2, 0, 0, 40, 15, 22, 110, 600, 70, 3.7, 'Salmon fillet, butter, lemon juice, garlic', 1, 'Contains seafood', TRUE, 'Meal'),
('Bacon Cheeseburger Casserole', 740, 50, 8, 3, 0, 55, 22, 30, 140, 900, 80, 4.0, 'Ground beef, bacon, cheddar cheese, eggs', 1, 'Contains dairy', TRUE, 'Meal'),
('Italian Sausage Bake', 660, 45, 7, 3, 0, 45, 18, 25, 130, 850, 75, 3.2, 'Italian sausage, mozzarella, tomato sauce, basil', 1, 'Contains dairy', TRUE, 'Meal'),
('Roast Pork Shoulder', 780, 60, 4, 2, 0, 55, 20, 30, 155, 1000, 60, 4.5, 'Pork shoulder, olive oil, garlic, rosemary', 1, 'Gluten-free', TRUE, 'Meal'),
('Crab Stuffed Mushrooms', 490, 35, 6, 2, 1, 30, 12, 20, 95, 600, 70, 3.0, 'Crab meat, cream cheese, mushrooms, chives', 1, 'Contains seafood and dairy', TRUE, 'Meal'),
('Lamb Shank Stew', 720, 58, 5, 2, 1, 45, 18, 27, 160, 800, 80, 5.2, 'Lamb shank, beef broth, garlic, onions', 1, 'Gluten-free', TRUE, 'Meal'),
('Cheesy Bacon Chicken Skillet', 690, 48, 7, 3, 0, 50, 20, 28, 135, 850, 95, 3.1, 'Chicken breast, bacon, cheddar cheese, cream', 1, 'Contains dairy', TRUE, 'Meal'),
('Seared Swordfish Steaks', 600, 50, 3, 0, 0, 30, 10, 20, 90, 550, 65, 3.8, 'Swordfish steak, lemon, olive oil, pepper', 1, 'Contains seafood', TRUE, 'Meal'),
('Steak and Spinach Omelette', 580, 42, 4, 1, 0, 38, 15, 22, 125, 800, 80, 2.9, 'Steak slices, spinach, eggs, butter', 1, 'Contains dairy', TRUE, 'Meal'),
('Pork Belly Skillet', 770, 55, 5, 2, 0, 60, 25, 30, 170, 950, 55, 3.6, 'Pork belly, garlic, onions, olive oil', 1, 'Gluten-free', TRUE, 'Meal'),
('Buffalo Shrimp', 510, 40, 4, 1, 0, 30, 12, 18, 105, 700, 60, 2.8, 'Shrimp, buffalo sauce, butter', 1, 'Contains seafood', TRUE, 'Meal'),
('Smoked Turkey Legs', 650, 52, 5, 2, 1, 40, 18, 25, 140, 750, 80, 3.7, 'Turkey legs, paprika, garlic, olive oil', 1, 'Gluten-free', TRUE, 'Meal'),
('Chicken Cordon Bleu Bites', 630, 45, 6, 2, 0, 42, 16, 26, 120, 850, 90, 3.0, 'Chicken breast, ham, swiss cheese, almond flour', 1, 'Contains dairy and nuts', TRUE, 'Meal'),
('Pork Chop Skillet Dinner', 680, 48, 6, 2, 0, 45, 18, 27, 135, 800, 75, 3.3, 'Pork chops, garlic, mushrooms, butter', 1, 'Gluten-free', TRUE, 'Meal'),
('Herb Roasted Chicken Legs', 620, 45, 4, 1, 0, 40, 15, 22, 115, 750, 70, 2.7, 'Chicken legs, rosemary, thyme, olive oil', 1, 'Gluten-free', TRUE, 'Meal'),
('Salmon Patties', 580, 40, 5, 2, 1, 35, 14, 20, 95, 700, 65, 2.9, 'Salmon, eggs, almond flour, parsley', 1, 'Contains seafood and nuts', TRUE, 'Meal'),
('Beef Stroganoff', 690, 50, 9, 4, 1, 48, 20, 28, 140, 850, 90, 3.5,
 'Beef strips, sour cream, mushrooms, butter', 1, 'Contains dairy', TRUE, 'Meal'),
('Chicken and Bacon Alfredo', 720, 50, 8, 4, 1, 50, 20, 30, 140, 850, 95, 3.4,'Chicken breast, bacon, heavy cream, parmesan cheese', 1, 'Contains dairy', TRUE, 'Meal'),
('Tuna Stuffed Avocado', 480, 38, 5, 1, 3, 28, 10, 16, 90, 600, 70, 3.2,'Tuna, avocado, mayonnaise, lemon juice', 1, 'Contains seafood', TRUE, 'Meal'),
('Chorizo Egg Muffins', 510, 35, 4, 2, 0, 36, 14, 22, 120, 800, 70, 2.8,'Chorizo sausage, eggs, cheddar cheese', 1, 'Contains dairy', TRUE, 'Meal'),
('Grilled Pork Tenderloin', 650, 50, 4, 1, 0, 40, 16, 24, 130, 850, 75, 3.5,'Pork tenderloin, thyme, garlic, olive oil', 1, 'Gluten-free', TRUE, 'Meal'),
('Duck Fat Fried Chicken', 720, 50, 6, 2, 0, 55, 22, 30, 150, 900, 80, 4.2,'Chicken thighs, duck fat, paprika, garlic', 1, 'Gluten-free', TRUE, 'Meal'),
('Steak with Garlic Butter', 700, 55, 3, 1, 0, 50, 20, 28, 145, 850, 75, 4.0,'Steak, butter, garlic, parsley', 1, 'Contains dairy', TRUE, 'Meal'),
('Stuffed Chicken Breasts', 680, 50, 7, 3, 0, 45, 18, 26, 135, 850, 90, 3.3,'Chicken breast, cream cheese, spinach, bacon', 1, 'Contains dairy', TRUE, 'Meal'), 
('Grilled Ribeye Steak', 750, 60, 2, 0, 0, 55, 25, 30, 150, 500, 40, 4.2, 'Ribeye steak, salt, pepper, butter', 1, 'Contains dairy and gluten', TRUE, 'Meal'),
('BBQ Pulled Pork', 680, 48, 10, 7, 1, 45, 15, 25, 130, 1100, 60, 2.7, 'Pork shoulder, BBQ sauce, onion powder, garlic powder', 1, 'Contains dairy and gluten', TRUE, 'Meal'),
('Garlic Butter Chicken Thighs', 550, 40, 5, 1, 0, 35, 12, 20, 95, 600, 50, 2.5, 'Chicken thighs, garlic, butter, thyme, parsley', 1, 'Contains dairy and gluten', TRUE, 'Meal'),
('Beef and Bacon Skewers', 620, 45, 4, 2, 0, 48, 18, 25, 140, 950, 45, 3.5, 'Beef cubes, bacon strips, black pepper, olive oil', 1, 'Contains dairy and gluten', TRUE, 'Meal'),
('Spicy Lamb Chops', 700, 50, 2, 0, 0, 55, 20, 28, 150, 700, 40, 4.1, 'Lamb chops, chili flakes, rosemary, salt', 1, 'Contains dairy and gluten', TRUE, 'Meal'),
('Classic Beef Meatballs', 580, 42, 5, 1, 1, 40, 15, 22, 125, 600, 80, 3.5, 'Beef mince, parmesan, egg, garlic, parsley', 1, 'Contains dairy and gluten', TRUE, 'Meal'),
('Smoked Beef Brisket', 680, 55, 3, 1, 0, 45, 18, 25, 140, 750, 45, 4.0, 'Beef brisket, paprika, garlic powder, salt, pepper', 1, 'Contains dairy and gluten', TRUE, 'Meal'),
('Chicken Bacon Wraps', 600, 42, 8, 4, 0, 40, 15, 22, 120, 850, 75, 2.8, 'Chicken breast, bacon, cream cheese, chives', 1, 'Contains dairy and gluten', TRUE, 'Meal'),
('Honey Glazed Chicken Wings', 620, 38, 15, 8, 0, 40, 12, 25, 110, 800, 60, 2.6, 'Chicken wings, honey, soy sauce, ginger, garlic', 1, 'Contains dairy and gluten', TRUE, 'Meal'),
('Spicy Beef Jerky', 300, 25, 4, 2, 0, 18, 7, 10, 85, 1200, 20, 3.2, 'Beef strips, soy sauce, chili flakes, garlic powder', 1, 'Contains dairy and gluten', TRUE, 'Meal'),
('Crispy Chilli Turkey Noodles', 520, 35, 40, 6, 2, 25, 5, 18, 75, 950, 70, 2.1,
 'Turkey mince, udon noodles, garlic, chili flakes, soy sauce, honey, spring onions, sesame oil',
 1, 'Contains soy and gluten', TRUE, 'Meal'),

('Classic Beef Burger', 650, 40, 30, 5, 2, 42, 18, 20, 115, 850, 150, 4.2,
 'Ground beef, burger bun, lettuce, tomato, onion, cheddar cheese, ketchup, mayonnaise, mustard, pickle',
 1, 'Contains dairy and gluten', TRUE, 'Meal'),

('Ribeye Steak with Garlic Butter', 680, 48, 2, 0, 0, 52, 22, 25, 130, 520, 45, 4.5,
 'Ribeye steak, butter, garlic, rosemary, thyme, salt, black pepper',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('BBQ Pulled Pork Sandwich', 580, 35, 45, 12, 2, 28, 10, 16, 95, 980, 100, 3.0,
 'Pork shoulder, BBQ sauce, hamburger bun, coleslaw, pickle',
 1, 'Contains gluten', TRUE, 'Meal'),

('Honey Garlic Chicken Thighs', 490, 38, 25, 20, 1, 26, 8, 16, 120, 650, 40, 2.2,
 'Chicken thighs, honey, garlic, soy sauce, butter, thyme, rice',
 1, 'Contains soy and gluten', TRUE, 'Meal'),

('Beef Stroganoff', 580, 35, 40, 5, 3, 32, 18, 12, 110, 780, 180, 3.5,
 'Beef sirloin, mushrooms, onion, garlic, sour cream, beef broth, butter, flour, egg noodles, parsley',
 1, 'Contains dairy and gluten', TRUE, 'Meal'),

('Bacon Wrapped Chicken Breast', 450, 50, 2, 1, 0, 28, 10, 16, 130, 680, 30, 1.8,
 'Chicken breast, bacon, garlic powder, paprika, black pepper, olive oil',
 1, 'Gluten-free', TRUE, 'Meal'),

('Lamb Chops with Mint Sauce', 520, 42, 8, 6, 1, 35, 15, 18, 110, 480, 60, 3.8,
 'Lamb chops, mint, sugar, vinegar, olive oil, garlic, rosemary, salt, pepper',
 1, 'Gluten-free', TRUE, 'Meal'),

('Beef Chili', 580, 40, 35, 8, 10, 30, 12, 16, 100, 850, 120, 6.0,
 'Ground beef, kidney beans, tomatoes, onion, bell pepper, garlic, chili powder, cumin, oregano, beef broth',
 1, 'Gluten-free', TRUE, 'Meal'),

('Chicken Parmesan', 650, 45, 40, 6, 3, 35, 15, 18, 120, 980, 400, 3.0,
 'Chicken breast, breadcrumbs, parmesan cheese, mozzarella, eggs, marinara sauce, spaghetti, basil',
 1, 'Contains dairy, gluten, and egg', TRUE, 'Meal'),

('Pork Tenderloin with Apple Glaze', 420, 45, 18, 15, 2, 16, 5, 10, 95, 580, 40, 2.0,
 'Pork tenderloin, apples, apple cider, brown sugar, dijon mustard, cinnamon, cloves, butter',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Beef Tacos', 510, 30, 35, 4, 8, 28, 12, 14, 85, 750, 200, 3.5,
 'Ground beef, corn tortillas, lettuce, tomato, onion, cheese, sour cream, salsa, cumin, chili powder',
 1, 'Contains dairy', TRUE, 'Meal'),

('Butter Chicken', 580, 40, 20, 8, 2, 38, 18, 18, 130, 720, 150, 3.0,
 'Chicken thighs, yogurt, tomato sauce, heavy cream, butter, onion, garlic, ginger, garam masala, rice',
 1, 'Contains dairy', TRUE, 'Meal'),

('Beef Stir Fry', 480, 35, 30, 8, 5, 24, 8, 14, 90, 950, 80, 4.0,
 'Beef sirloin, broccoli, bell pepper, carrot, onion, garlic, ginger, soy sauce, sesame oil, rice',
 1, 'Contains soy', TRUE, 'Meal'),

('Italian Meatballs with Pasta', 620, 38, 55, 6, 4, 28, 12, 14, 95, 780, 150, 3.5,
 'Ground beef, ground pork, breadcrumbs, parmesan, eggs, garlic, spaghetti, marinara sauce, basil, oregano',
 1, 'Contains dairy, gluten, and egg', TRUE, 'Meal'),

('Buffalo Chicken Wings', 580, 45, 5, 2, 0, 42, 15, 25, 180, 1250, 60, 1.8,
 'Chicken wings, hot sauce, butter, garlic powder, paprika, celery, blue cheese dressing',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Steak Fajitas', 550, 38, 40, 6, 5, 28, 10, 16, 95, 850, 120, 4.0,
 'Beef flank steak, bell peppers, onion, flour tortillas, sour cream, cheese, lime, cumin, chili powder',
 1, 'Contains dairy and gluten', TRUE, 'Meal'),

('Braised Short Ribs', 680, 45, 15, 6, 2, 48, 22, 22, 120, 780, 80, 5.0,
 'Beef short ribs, red wine, onion, carrot, celery, garlic, tomato paste, beef broth, thyme, bay leaves',
 1, 'Gluten-free', TRUE, 'Meal'),

('Chicken Alfredo Pasta', 720, 40, 55, 3, 2, 40, 22, 15, 120, 820, 350, 2.0,
 'Chicken breast, fettuccine, heavy cream, parmesan cheese, butter, garlic, parsley',
 1, 'Contains dairy and gluten', TRUE, 'Meal'),

('Pork Chops with Mushroom Gravy', 480, 40, 15, 2, 3, 28, 10, 16, 100, 720, 60, 2.5,
 'Pork chops, mushrooms, onion, garlic, beef broth, heavy cream, butter, flour, thyme',
 1, 'Contains dairy and gluten', TRUE, 'Meal'),

('Beef Bourguignon', 620, 40, 15, 5, 4, 40, 16, 20, 110, 780, 60, 5.0,
 'Beef chuck, bacon, red wine, pearl onions, mushrooms, carrots, garlic, thyme, bay leaves, butter, flour',
 1, 'Contains gluten', TRUE, 'Meal'),

('Honey Mustard Glazed Ham', 480, 35, 20, 18, 0, 30, 10, 18, 95, 1200, 40, 2.0,
 'Ham, honey, dijon mustard, brown sugar, apple cider vinegar, cloves, cinnamon',
 1, 'Gluten-free', TRUE, 'Meal'),

('Beef and Broccoli', 450, 35, 25, 6, 5, 22, 8, 12, 85, 980, 80, 3.5,
 'Beef sirloin, broccoli, garlic, ginger, soy sauce, brown sugar, sesame oil, rice',
 1, 'Contains soy', TRUE, 'Meal'),

('Chicken Enchiladas', 580, 38, 50, 6, 5, 26, 12, 12, 95, 950, 300, 3.0,
 'Chicken breast, corn tortillas, enchilada sauce, cheese, onion, bell pepper, sour cream, cilantro',
 1, 'Contains dairy', TRUE, 'Meal'),

('Salisbury Steak', 520, 35, 25, 4, 2, 32, 14, 16, 100, 780, 80, 4.0,
 'Ground beef, onion, mushrooms, beef broth, Worcestershire sauce, ketchup, flour, mashed potatoes',
 1, 'Contains gluten', TRUE, 'Meal'),

('BBQ Ribs', 650, 45, 25, 18, 1, 40, 16, 20, 130, 850, 60, 2.5,
 'Pork ribs, BBQ sauce, brown sugar, paprika, garlic powder, onion powder, cayenne pepper',
 1, 'Gluten-free', TRUE, 'Meal'),

('Chicken Cordon Bleu', 580, 48, 20, 2, 1, 35, 15, 18, 130, 980, 250, 2.0,
 'Chicken breast, ham, Swiss cheese, breadcrumbs, eggs, flour, dijon mustard, butter',
 1, 'Contains dairy, gluten, and egg', TRUE, 'Meal'),

('Beef Kabobs', 480, 40, 15, 5, 3, 28, 10, 16, 95, 620, 60, 4.0,
 'Beef sirloin, bell peppers, onion, mushrooms, olive oil, garlic, oregano, lemon juice, salt, pepper',
 1, 'Gluten-free', TRUE, 'Meal'),

('Swedish Meatballs', 550, 35, 30, 5, 2, 35, 18, 15, 110, 780, 120, 3.0,
 'Ground beef, ground pork, breadcrumbs, egg, onion, allspice, nutmeg, beef broth, heavy cream, flour, egg noodles',
 1, 'Contains dairy, gluten, and egg', TRUE, 'Meal'),

('Bacon Cheeseburger', 680, 40, 35, 6, 2, 45, 20, 22, 120, 980, 200, 4.5,
 'Ground beef, bacon, cheddar cheese, burger bun, lettuce, tomato, onion, pickle, ketchup, mayonnaise',
 1, 'Contains dairy and gluten', TRUE, 'Meal'),

('Garlic Butter Steak Bites', 520, 40, 2, 0, 0, 40, 20, 18, 110, 650, 40, 3.5,
 'Beef sirloin, butter, garlic, parsley, olive oil, salt, black pepper',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Chicken and Dumplings', 580, 35, 55, 4, 3, 25, 8, 15, 90, 850, 80, 3.0,
 'Chicken thighs, carrots, celery, onion, garlic, flour, butter, chicken broth, thyme, bay leaves, biscuit dough',
 1, 'Contains dairy and gluten', TRUE, 'Meal'),

('Meatloaf with Mashed Potatoes', 620, 38, 45, 6, 3, 32, 14, 16, 100, 820, 100, 4.0,
 'Ground beef, onion, bell pepper, egg, breadcrumbs, ketchup, Worcestershire sauce, potatoes, butter, milk',
 1, 'Contains dairy, gluten, and egg', TRUE, 'Meal'),

('Teriyaki Chicken', 480, 40, 35, 25, 1, 18, 5, 12, 95, 1100, 40, 2.0,
 'Chicken thighs, soy sauce, brown sugar, honey, garlic, ginger, rice vinegar, sesame oil, rice',
 1, 'Contains soy', TRUE, 'Meal'),

('Lamb Curry', 580, 40, 25, 6, 5, 38, 18, 18, 110, 780, 120, 5.0,
 'Lamb shoulder, onion, garlic, ginger, tomatoes, yogurt, heavy cream, curry powder, turmeric, cumin, rice',
 1, 'Contains dairy', TRUE, 'Meal'),

('Beef Enchiladas', 620, 35, 55, 6, 4, 30, 14, 14, 95, 950, 350, 4.0,
 'Ground beef, corn tortillas, enchilada sauce, cheese, onion, garlic, cumin, chili powder, sour cream',
 1, 'Contains dairy', TRUE, 'Meal'),

('Honey Baked Ham', 450, 35, 18, 16, 0, 28, 10, 16, 90, 1150, 30, 1.8,
 'Ham, honey, brown sugar, dijon mustard, cinnamon, cloves',
 1, 'Gluten-free', TRUE, 'Meal'),

('Korean BBQ Beef', 520, 35, 25, 15, 2, 32, 12, 18, 90, 980, 60, 4.5,
 'Beef short ribs, soy sauce, brown sugar, garlic, ginger, sesame oil, green onions, rice',
 1, 'Contains soy', TRUE, 'Meal'),

('Chicken Marsala', 450, 35, 15, 3, 2, 28, 10, 16, 95, 680, 40, 2.5,
 'Chicken breast, mushrooms, marsala wine, chicken broth, shallots, garlic, butter, flour, parsley',
 1, 'Contains dairy and gluten', TRUE, 'Meal'),

('Philly Cheesesteak Sandwich', 580, 35, 45, 5, 2, 30, 12, 16, 90, 980, 250, 4.0,
 'Beef sirloin, hoagie roll, provolone cheese, onion, bell pepper, mushrooms, mayonnaise',
 1, 'Contains dairy and gluten', TRUE, 'Meal'),

('Bacon Wrapped Pork Tenderloin', 480, 40, 5, 2, 0, 32, 12, 18, 100, 720, 30, 2.5,
 'Pork tenderloin, bacon, garlic, rosemary, thyme, brown sugar, olive oil',
 1, 'Gluten-free', TRUE, 'Meal'),

('Chicken Pot Pie', 580, 30, 50, 5, 4, 30, 15, 13, 85, 850, 100, 3.0,
 'Chicken breast, carrots, peas, celery, onion, butter, flour, chicken broth, heavy cream, pie crust',
 1, 'Contains dairy and gluten', TRUE, 'Meal'),

('Spaghetti and Meatballs', 650, 38, 65, 10, 5, 28, 12, 14, 90, 820, 150, 4.5,
 'Ground beef, ground pork, breadcrumbs, parmesan, egg, garlic, spaghetti, marinara sauce, onion, basil',
 1, 'Contains dairy, gluten, and egg', TRUE, 'Meal'),

('Tandoori Chicken', 450, 45, 10, 3, 2, 22, 6, 14, 110, 680, 80, 3.0,
 'Chicken thighs, yogurt, lemon juice, garlic, ginger, paprika, turmeric, cumin, coriander, garam masala',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('T-Bone Steak', 650, 50, 0, 0, 0, 48, 20, 24, 130, 520, 40, 4.8,
 'T-bone steak, butter, garlic, rosemary, thyme, salt, black pepper',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Shepherds Pie', 580, 35, 45, 6, 8, 28, 14, 12, 95, 780, 100, 4.0,
 'Ground lamb, onion, carrots, peas, corn, tomato paste, Worcestershire sauce, beef broth, potatoes, butter, milk',
 1, 'Contains dairy', TRUE, 'Meal'),

('Orange Chicken', 550, 35, 50, 25, 1, 22, 5, 15, 90, 950, 40, 2.0,
 'Chicken breast, orange juice, orange zest, soy sauce, honey, garlic, ginger, cornstarch, egg, flour, rice',
 1, 'Contains soy, gluten, and egg', TRUE, 'Meal'),

('Beef Wellington', 720, 40, 40, 3, 2, 45, 20, 22, 120, 680, 60, 5.0,
 'Beef tenderloin, mushrooms, shallots, garlic, thyme, prosciutto, puff pastry, dijon mustard, egg',
 1, 'Contains gluten and egg', TRUE, 'Meal'),

('Chicken Fajitas', 520, 38, 40, 5, 5, 22, 7, 13, 95, 780, 120, 3.5,
 'Chicken breast, bell peppers, onion, flour tortillas, sour cream, cheese, lime, cumin, chili powder',
 1, 'Contains dairy and gluten', TRUE, 'Meal'),

('Beef Lasagna', 650, 35, 55, 8, 4, 35, 18, 15, 100, 880, 400, 4.0,
 'Ground beef, lasagna noodles, ricotta cheese, mozzarella, parmesan, eggs, tomato sauce, onion, garlic, basil',
 1, 'Contains dairy, gluten, and egg', TRUE, 'Meal'),

('Pork Tenderloin with Maple Glaze', 420, 40, 20, 18, 1, 18, 5, 12, 95, 520, 30, 2.5,
 'Pork tenderloin, maple syrup, dijon mustard, garlic, rosemary, thyme, olive oil',
 1, 'Gluten-free', TRUE, 'Meal'),

('Beef and Mushroom Stew', 520, 35, 30, 5, 6, 28, 12, 14, 90, 780, 60, 5.0,
 'Beef chuck, mushrooms, onion, carrots, celery, garlic, red wine, beef broth, tomato paste, thyme, bay leaves',
 1, 'Gluten-free', TRUE, 'Meal')

('Slow Cooked Beef Brisket', 580, 45, 10, 5, 1, 38, 15, 20, 120, 750, 50, 4.5,
 'Beef brisket, onion, garlic, beef broth, tomato paste, Worcestershire sauce, paprika, brown sugar',
 1, 'Gluten-free', TRUE, 'Meal'),

('Honey Mustard Glazed Pork Loin', 480, 40, 15, 12, 1, 28, 10, 16, 100, 650, 40, 2.0,
 'Pork loin, honey, dijon mustard, garlic, rosemary, olive oil, black pepper, salt',
 1, 'Gluten-free', TRUE, 'Meal'),

('Chicken Piccata', 450, 35, 10, 1, 1, 30, 8, 20, 95, 750, 50, 2.5,
 'Chicken breast, flour, butter, white wine, lemon juice, capers, chicken broth, parsley',
 1, 'Contains gluten', TRUE, 'Meal'),

('Bacon Wrapped Filet Mignon', 550, 45, 2, 0, 0, 40, 18, 20, 130, 520, 30, 4.0,
 'Beef tenderloin, bacon, butter, garlic, rosemary, thyme, black pepper, salt',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('BBQ Baby Back Ribs', 680, 50, 25, 20, 0, 42, 16, 24, 140, 950, 80, 3.0,
 'Pork ribs, bbq sauce, brown sugar, paprika, garlic powder, onion powder, cayenne pepper',
 1, 'Gluten-free', TRUE, 'Meal'),

('Jerk Chicken', 520, 45, 8, 5, 2, 32, 8, 22, 120, 680, 50, 3.0,
 'Chicken thighs, scotch bonnet pepper, allspice, thyme, garlic, ginger, soy sauce, brown sugar',
 1, 'Contains soy', TRUE, 'Meal'),

('Classic Meatloaf', 580, 40, 30, 6, 2, 34, 14, 18, 120, 850, 100, 4.5,
 'Ground beef, ground pork, onion, breadcrumbs, egg, ketchup, Worcestershire sauce, bell pepper',
 1, 'Contains gluten and egg', TRUE, 'Meal'),

('Lamb Kofta Kebabs', 520, 38, 10, 3, 2, 36, 16, 18, 110, 680, 80, 4.0,
 'Ground lamb, onion, garlic, parsley, mint, cumin, coriander, cinnamon, egg',
 1, 'Contains egg, gluten-free', TRUE, 'Meal'),

('Chicken Cordon Bleu', 580, 50, 20, 2, 1, 34, 16, 16, 120, 850, 250, 2.5,
 'Chicken breast, ham, Swiss cheese, breadcrumbs, eggs, flour, dijon mustard, butter',
 1, 'Contains dairy, gluten, and egg', TRUE, 'Meal'),

('Balsamic Glazed Pork Tenderloin', 460, 42, 18, 12, 1, 26, 8, 16, 105, 620, 45, 2.8,
 'Pork tenderloin, balsamic vinegar, honey, rosemary, garlic, olive oil, dijon mustard',
 1, 'Gluten-free', TRUE, 'Meal'),

('Skirt Steak Fajitas', 560, 40, 35, 5, 3, 30, 12, 16, 105, 780, 100, 4.2,
 'Skirt steak, bell peppers, onions, lime juice, cumin, chili powder, flour tortillas, avocado',
 1, 'Contains gluten', TRUE, 'Meal'),

('Chicken Liver Pâté', 380, 25, 8, 3, 0, 28, 10, 16, 320, 520, 30, 8.5,
 'Chicken livers, butter, shallots, garlic, brandy, thyme, cream, baguette',
 1, 'Contains dairy and gluten', TRUE, 'Meal'),

('Ribeye with Garlic Herb Butter', 650, 48, 3, 1, 0, 50, 22, 26, 140, 560, 40, 4.5,
 'Ribeye steak, butter, garlic, rosemary, thyme, parsley, salt, black pepper',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Turkey Roulade', 480, 45, 10, 3, 1, 28, 10, 16, 120, 620, 60, 3.0,
 'Turkey breast, prosciutto, spinach, provolone cheese, garlic, herbs, olive oil',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Bourbon Glazed Pork Chops', 520, 40, 18, 12, 0, 32, 12, 18, 110, 680, 50, 2.5,
 'Pork chops, bourbon, brown sugar, soy sauce, garlic, ginger, black pepper',
 1, 'Contains soy', TRUE, 'Meal'),

('Beef Short Rib Ragu', 620, 42, 35, 8, 4, 38, 16, 20, 120, 750, 100, 5.0,
 'Beef short ribs, tomatoes, carrots, celery, onion, red wine, garlic, pappardelle pasta',
 1, 'Contains gluten', TRUE, 'Meal'),

('Chicken Schnitzel', 540, 38, 30, 2, 2, 30, 10, 18, 110, 780, 60, 2.5,
 'Chicken breast, flour, eggs, breadcrumbs, lemon, parsley, butter',
 1, 'Contains gluten, dairy, and egg', TRUE, 'Meal'),

('Lamb Shoulder Roast', 580, 45, 8, 3, 0, 40, 18, 20, 130, 680, 70, 4.8,
 'Lamb shoulder, garlic, rosemary, thyme, olive oil, salt, black pepper, red wine',
 1, 'Gluten-free', TRUE, 'Meal'),

('Coffee Rubbed Sirloin Steak', 520, 45, 5, 2, 0, 32, 14, 16, 110, 620, 40, 4.0,
 'Sirloin steak, coffee grounds, brown sugar, paprika, garlic powder, salt, black pepper',
 1, 'Gluten-free', TRUE, 'Meal'),

('Duck Breast with Cherry Sauce', 580, 40, 25, 18, 1, 35, 12, 20, 120, 680, 45, 3.5,
 'Duck breast, cherries, red wine, shallots, balsamic vinegar, butter, honey, thyme',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Herb Crusted Rack of Lamb', 620, 45, 8, 2, 1, 45, 20, 23, 130, 650, 80, 4.5,
 'Rack of lamb, breadcrumbs, garlic, rosemary, thyme, dijon mustard, olive oil',
 1, 'Contains gluten', TRUE, 'Meal'),

('Chicken Kiev', 580, 40, 25, 2, 1, 38, 16, 20, 120, 720, 60, 2.5,
 'Chicken breast, butter, garlic, parsley, dill, flour, breadcrumbs, eggs',
 1, 'Contains dairy, gluten, and egg', TRUE, 'Meal'),

('Beef and Bacon Meatballs', 550, 38, 12, 3, 1, 40, 18, 20, 120, 780, 80, 3.5,
 'Ground beef, bacon, onion, garlic, breadcrumbs, egg, parmesan cheese, parsley',
 1, 'Contains dairy, gluten, and egg', TRUE, 'Meal'),

('Citrus Herb Roasted Chicken', 480, 45, 8, 5, 1, 28, 8, 18, 110, 620, 50, 2.5,
 'Whole chicken, lemon, orange, garlic, rosemary, thyme, olive oil, black pepper',
 1, 'Gluten-free', TRUE, 'Meal'),

('Beef Tenderloin with Red Wine Sauce', 580, 45, 10, 4, 0, 38, 16, 20, 120, 680, 45, 4.5,
 'Beef tenderloin, red wine, shallots, beef broth, butter, thyme, garlic',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Spicy Italian Sausage Pasta', 620, 35, 60, 5, 3, 30, 12, 16, 90, 980, 100, 3.5,
 'Italian sausage, penne pasta, bell peppers, onion, garlic, crushed red pepper, marinara sauce',
 1, 'Contains gluten', TRUE, 'Meal'),

('Herb Butter Roasted Turkey', 520, 60, 5, 1, 0, 28, 12, 14, 150, 720, 40, 3.0,
 'Turkey breast, butter, sage, thyme, rosemary, garlic, lemon zest, salt, pepper',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Pork Belly with Apple Cider Glaze', 680, 35, 20, 16, 0, 55, 22, 30, 110, 750, 30, 2.0,
 'Pork belly, apple cider, brown sugar, thyme, garlic, cinnamon, star anise',
 1, 'Gluten-free', TRUE, 'Meal'),

('Moroccan Spiced Lamb Stew', 580, 40, 25, 8, 5, 38, 16, 20, 120, 720, 100, 5.0,
 'Lamb shoulder, chickpeas, apricots, onion, garlic, ginger, cumin, coriander, cinnamon, turmeric',
 1, 'Gluten-free', TRUE, 'Meal'),

('Lemon Garlic Roast Chicken', 480, 45, 8, 2, 1, 28, 8, 18, 110, 650, 50, 2.5,
 'Whole chicken, lemon, garlic, thyme, olive oil, butter, salt, black pepper',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Rosemary Garlic Lamb Chops', 520, 40, 5, 1, 0, 38, 16, 20, 110, 580, 80, 3.5,
 'Lamb chops, garlic, rosemary, olive oil, lemon zest, salt, black pepper',
 1, 'Gluten-free', TRUE, 'Meal'),

('Beef Wellington Individual', 680, 40, 35, 5, 2, 45, 20, 23, 120, 750, 60, 5.0,
 'Beef tenderloin, puff pastry, mushrooms, shallots, prosciutto, thyme, dijon mustard, egg',
 1, 'Contains gluten and egg', TRUE, 'Meal'),

('Garlic Butter Shrimp Scampi', 420, 35, 12, 2, 1, 28, 14, 12, 220, 780, 100, 2.0,
 'Shrimp, butter, garlic, white wine, lemon juice, parsley, red pepper flakes',
 1, 'Contains shellfish and dairy, gluten-free', TRUE, 'Meal'),

('Braised Oxtail', 620, 45, 18, 5, 3, 42, 18, 22, 140, 780, 90, 6.0,
 'Oxtail, red wine, carrots, celery, onion, garlic, tomato paste, beef broth, thyme, bay leaves',
 1, 'Gluten-free', TRUE, 'Meal'),

('Chicken Saltimbocca', 480, 42, 8, 1, 0, 30, 12, 16, 110, 850, 80, 2.5,
 'Chicken breast, prosciutto, sage, white wine, butter, flour, olive oil',
 1, 'Contains gluten and dairy', TRUE, 'Meal'),

('Beef Stroganoff with Egg Noodles', 580, 35, 45, 5, 2, 32, 16, 14, 120, 780, 100, 4.0,
 'Beef sirloin, mushrooms, onion, sour cream, beef broth, Worcestershire sauce, egg noodles, parsley',
 1, 'Contains dairy, gluten, and egg', TRUE, 'Meal'),

('Bacon Wrapped Stuffed Pork Tenderloin', 550, 40, 10, 3, 1, 38, 14, 22, 120, 780, 60, 3.0,
 'Pork tenderloin, bacon, spinach, feta cheese, garlic, sun-dried tomatoes, olive oil',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Beef and Vegetable Kebabs', 480, 35, 15, 6, 4, 32, 12, 18, 100, 620, 60, 4.0,
 'Beef sirloin, bell peppers, onion, zucchini, mushrooms, olive oil, garlic, oregano, lemon juice',
 1, 'Gluten-free', TRUE, 'Meal'),

('Chicken and Sausage Jambalaya', 580, 40, 50, 5, 3, 28, 10, 16, 120, 980, 80, 4.5,
 'Chicken thighs, andouille sausage, rice, bell peppers, onion, celery, tomatoes, cajun seasoning',
 1, 'Gluten-free', TRUE, 'Meal'),

('Pork and Apple Skillet', 520, 35, 30, 20, 3, 32, 12, 18, 100, 680, 60, 2.5,
 'Pork chops, apples, onion, sage, thyme, apple cider, dijon mustard, butter',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Mustard Crusted Prime Rib', 650, 48, 5, 1, 0, 50, 22, 26, 130, 720, 80, 4.5,
 'Prime rib roast, dijon mustard, horseradish, garlic, rosemary, thyme, black pepper',
 1, 'Gluten-free', TRUE, 'Meal'),

('Garlic Parmesan Chicken Wings', 580, 40, 8, 1, 1, 42, 16, 24, 120, 850, 150, 2.0,
 'Chicken wings, garlic, parmesan cheese, butter, olive oil, parsley, salt, black pepper',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Beef Barbacoa', 520, 42, 10, 3, 2, 36, 14, 20, 110, 780, 60, 5.0,
 'Beef chuck roast, chipotles in adobo, lime juice, cumin, oregano, garlic, beef broth, bay leaves',
 1, 'Gluten-free', TRUE, 'Meal'),

('Balsamic Braised Short Ribs', 620, 45, 20, 10, 2, 40, 18, 20, 120, 750, 80, 5.5,
 'Beef short ribs, balsamic vinegar, red wine, onion, carrots, garlic, beef broth, rosemary, thyme',
 1, 'Gluten-free', TRUE, 'Meal'),

('Chicken Florentine', 480, 40, 10, 2, 2, 32, 14, 16, 110, 720, 250, 3.0,
 'Chicken breast, spinach, cream, white wine, garlic, parmesan cheese, flour, butter',
 1, 'Contains dairy and gluten', TRUE, 'Meal'),

('Pork Carnitas', 550, 40, 12, 3, 2, 38, 14, 22, 110, 750, 60, 3.0,
 'Pork shoulder, orange juice, lime juice, cumin, oregano, garlic, cinnamon, bay leaves',
 1, 'Gluten-free', TRUE, 'Meal'),

('Duck Confit', 620, 35, 5, 1, 0, 50, 18, 30, 120, 780, 40, 4.0,
 'Duck legs, duck fat, garlic, thyme, bay leaves, salt, black pepper',
 1, 'Gluten-free', TRUE, 'Meal'),

('Beef and Guinness Pie', 650, 38, 45, 6, 3, 38, 18, 18, 110, 850, 80, 5.0,
 'Beef chuck, Guinness stout, onion, carrots, celery, garlic, thyme, bay leaves, puff pastry',
 1, 'Contains gluten', TRUE, 'Meal'),

('Chicken and Mushroom Risotto', 580, 35, 60, 2, 3, 25, 12, 11, 90, 720, 120, 2.5,
 'Chicken breast, arborio rice, mushrooms, onion, garlic, white wine, chicken broth, parmesan cheese',
 1, 'Contains dairy', TRUE, 'Meal'),

('Lamb Rogan Josh', 580, 40, 15, 5, 3, 42, 18, 22, 110, 750, 80, 5.0,
 'Lamb shoulder, yogurt, tomatoes, onion, garlic, ginger, garam masala, red chili powder, coriander',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Beef Bulgogi', 520, 38, 20, 10, 2, 32, 12, 18, 100, 980, 60, 4.0,
 'Beef sirloin, soy sauce, brown sugar, sesame oil, garlic, ginger, pear, green onions, sesame seeds',
 1, 'Contains soy', TRUE, 'Meal'),

('Bacon Wrapped Stuffed Chicken Breast', 520, 45, 8, 3, 1, 32, 12, 18, 120, 750, 80, 2.5,
 'Chicken breast, bacon, cream cheese, spinach, sun-dried tomatoes, garlic, thyme',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Smoked Pork Ribs', 680, 48, 15, 12, 0, 48, 18, 28, 140, 950, 60, 3.0,
 'Pork ribs, bbq rub, apple juice, bbq sauce, honey, apple cider vinegar',
 1, 'Gluten-free', TRUE, 'Meal'),

('Garlic Rosemary Lamb Rack', 620, 45, 5, 1, 0, 48, 20, 26, 120, 680, 80, 4.5,
 'Rack of lamb, garlic, rosemary, olive oil, dijon mustard, salt, black pepper',
 1, 'Gluten-free', TRUE, 'Meal'),

('Blackened Cajun Chicken', 480, 45, 8, 2, 1, 28, 8, 18, 110, 780, 60, 3.0,
 'Chicken breast, cajun seasoning, paprika, thyme, oregano, garlic powder, onion powder, butter',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Osso Buco', 580, 42, 15, 5, 2, 38, 16, 20, 120, 720, 80, 5.0,
 'Veal shanks, white wine, onion, carrots, celery, tomatoes, garlic, thyme, bay leaves, gremolata',
 1, 'Gluten-free', TRUE, 'Meal'),

('Honey Garlic Chicken Thighs', 520, 38, 25, 20, 1, 30, 10, 18, 120, 780, 60, 2.5,
 'Chicken thighs, honey, garlic, soy sauce, sriracha, rice vinegar, sesame oil, green onions',
 1, 'Contains soy', TRUE, 'Meal'),

('Carne Asada', 520, 40, 8, 2, 1, 35, 14, 19, 100, 720, 60, 4.0,
 'Flank steak, lime juice, orange juice, garlic, jalapeño, cilantro, cumin, oregano',
 1, 'Gluten-free', TRUE, 'Meal'),

('Pork Schnitzel', 580, 38, 35, 2, 2, 32, 12, 18, 100, 750, 60, 2.5,
 'Pork loin, flour, eggs, breadcrumbs, lemon, parsley, butter',
 1, 'Contains gluten, dairy, and egg', TRUE, 'Meal'),

('Beef and Broccoli', 480, 35, 25, 8, 5, 28, 10, 16, 90, 980, 100, 4.0,
 'Beef sirloin, broccoli, ginger, garlic, soy sauce, sesame oil, brown sugar, cornstarch',
 1, 'Contains soy', TRUE, 'Meal'),

('Lemon Herb Roasted Chicken', 480, 45, 8, 2, 1, 28, 8, 18, 110, 620, 50, 2.5,
 'Whole chicken, lemon, garlic, thyme, rosemary, olive oil, butter, salt, black pepper',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Butter Chicken', 580, 40, 20, 8, 2, 38, 18, 18, 120, 750, 120, 3.0,
 'Chicken thighs, yogurt, tomato sauce, cream, butter, onion, garlic, ginger, garam masala, tandoori spice',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Maple Glazed Ham', 520, 40, 30, 25, 0, 28, 10, 16, 100, 1800, 50, 2.0,
 'Ham, maple syrup, dijon mustard, brown sugar, cinnamon, cloves, apple cider vinegar',
 1, 'Gluten-free', TRUE, 'Meal'),

('Beef Bourguignon', 620, 40, 15, 5, 3, 42, 18, 22, 120, 750, 60, 5.0,
 'Beef chuck, bacon, red wine, pearl onions, mushrooms, carrots, garlic, thyme, bay leaves',
 1, 'Gluten-free', TRUE, 'Meal'),

('Chicken Tikka Masala', 580, 40, 20, 8, 2, 38, 18, 18, 110, 780, 150, 3.0,
 'Chicken breast, yogurt, tomato sauce, cream, garam masala, turmeric, paprika, ginger, garlic, cumin',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Stuffed Flank Steak', 550, 45, 10, 3, 2, 35, 14, 19, 110, 680, 80, 4.5,
 'Flank steak, spinach, provolone cheese, red bell pepper, garlic, breadcrumbs, olive oil',
 1, 'Contains dairy and gluten', TRUE, 'Meal'),

('Chicken and Andouille Gumbo', 520, 35, 30, 5, 3, 32, 12, 18, 110, 980, 80, 4.0,
 'Chicken thighs, andouille sausage, okra, bell peppers, celery, onion, tomatoes, cajun seasoning, file powder',
 1, 'Gluten-free', TRUE, 'Meal'),

('Korean BBQ Short Ribs (Galbi)', 620, 40, 25, 18, 1, 42, 18, 22, 120, 980, 60, 4.5,
 'Beef short ribs, soy sauce, brown sugar, asian pear, garlic, ginger, sesame oil, green onions',
 1, 'Contains soy', TRUE, 'Meal'),

('Beef and Lamb Moussaka', 580, 35, 25, 8, 5, 40, 18, 20, 120, 720, 200, 4.0,
 'Ground beef, ground lamb, eggplant, potatoes, onion, tomato sauce, béchamel sauce, cinnamon, nutmeg',
 1, 'Contains dairy and gluten', TRUE, 'Meal'),

('Chicken Coq au Vin', 520, 40, 15, 5, 2, 32, 12, 18, 120, 780, 60, 3.5,
 'Chicken thighs, bacon, red wine, pearl onions, mushrooms, carrots, garlic, thyme, bay leaves',
 1, 'Gluten-free', TRUE, 'Meal'),

('Grilled Pork Souvlaki', 480, 38, 15, 3, 2, 32, 10, 20, 100, 750, 60, 3.0,
 'Pork shoulder, lemon juice, olive oil, garlic, oregano, red onion, bell peppers, yogurt sauce',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Beef and Mushroom Skillet', 520, 40, 10, 3, 2, 38, 16, 20, 110, 680, 60, 4.5,
 'Beef sirloin, mushrooms, onion, garlic, thyme, red wine, beef broth, butter, parsley',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Crispy Duck Legs with Cherry Sauce', 650, 35, 20, 15, 1, 50, 18, 30, 120, 650, 60, 4.0,
 'Duck legs, cherries, port wine, shallots, balsamic vinegar, chicken broth, thyme, butter',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Chicken and Sun-Dried Tomato Pasta', 580, 35, 60, 5, 3, 25, 10, 13, 90, 780, 120, 3.0,
 'Chicken breast, sun-dried tomatoes, spinach, garlic, penne pasta, cream, parmesan cheese, basil',
 1, 'Contains dairy and gluten', TRUE, 'Meal'),

('Grilled Lamb Kebabs', 520, 40, 10, 3, 2, 38, 16, 20, 110, 680, 80, 4.0,
 'Lamb shoulder, red onion, bell peppers, olive oil, lemon juice, garlic, oregano, cumin, paprika',
 1, 'Gluten-free', TRUE, 'Meal'),

('Pan-Seared Duck Breast', 580, 35, 10, 5, 0, 45, 15, 28, 120, 620, 40, 5.0,
 'Duck breast, orange zest, honey, balsamic vinegar, thyme, garlic, butter',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Beef and Guinness Stew', 580, 40, 25, 5, 4, 35, 15, 18, 110, 780, 80, 5.0,
 'Beef chuck, Guinness stout, onion, carrots, celery, potatoes, garlic, thyme, bay leaves',
 1, 'Gluten-free', TRUE, 'Meal'),

('Chicken Piccata with Capers', 480, 40, 10, 1, 1, 32, 10, 20, 100, 780, 60, 2.5,
 'Chicken breast, flour, butter, white wine, lemon juice, capers, chicken broth, parsley',
 1, 'Contains gluten and dairy', TRUE, 'Meal'),
  
('Spicy Sausage and Peppers', 520, 35, 20, 8, 3, 35, 12, 21, 90, 950, 60, 3.0,
 'Italian sausage, bell peppers, onions, garlic, crushed red pepper, tomato sauce, olive oil, oregano',
 1, 'Gluten-free', TRUE, 'Meal'),

('Stuffed Pork Loin', 550, 42, 15, 5, 2, 36, 14, 20, 110, 680, 60, 3.0,
 'Pork loin, spinach, feta cheese, sun-dried tomatoes, garlic, herbs, olive oil',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Beef Tenderloin with Mushroom Sauce', 620, 45, 12, 3, 2, 42, 18, 22, 120, 750, 60, 4.5,
 'Beef tenderloin, mushrooms, shallots, garlic, beef broth, heavy cream, butter, thyme',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Five Spice Duck Breast', 580, 35, 15, 8, 0, 42, 14, 26, 110, 680, 40, 4.0,
 'Duck breast, five spice powder, honey, soy sauce, ginger, orange zest, green onions',
 1, 'Contains soy', TRUE, 'Meal'),

('Smoked Brisket', 620, 48, 8, 5, 0, 42, 18, 22, 120, 780, 50, 5.0,
 'Beef brisket, paprika, garlic powder, onion powder, brown sugar, black pepper, mustard powder, cayenne',
 1, 'Gluten-free', TRUE, 'Meal'),

('Dijon Herb Crusted Rack of Lamb', 620, 42, 10, 2, 1, 45, 20, 23, 120, 680, 80, 4.5,
 'Rack of lamb, dijon mustard, breadcrumbs, garlic, rosemary, thyme, parsley, olive oil',
 1, 'Contains gluten', TRUE, 'Meal'),

('Chicken Marsala', 520, 40, 15, 5, 1, 32, 10, 20, 100, 680, 50, 2.5,
 'Chicken breast, mushrooms, Marsala wine, chicken broth, butter, garlic, flour, thyme',
 1, 'Contains gluten and dairy', TRUE, 'Meal'),

('Braised Pork Shoulder with Apple Cider', 580, 40, 20, 15, 2, 38, 15, 21, 110, 720, 60, 3.5,
 'Pork shoulder, apple cider, onions, garlic, bay leaves, thyme, chicken broth, Dijon mustard',
 1, 'Gluten-free', TRUE, 'Meal'),

('Cajun Blackened Steak', 550, 45, 5, 1, 0, 38, 15, 21, 100, 780, 60, 4.5,
 'Ribeye steak, cajun seasoning, paprika, thyme, oregano, garlic powder, onion powder, butter',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Chicken Cacciatore', 520, 40, 15, 8, 3, 30, 8, 20, 100, 750, 80, 3.0,
 'Chicken thighs, tomatoes, bell peppers, onions, mushrooms, garlic, red wine, olives, capers, herbs',
 1, 'Gluten-free', TRUE, 'Meal'),

('Garlic Butter Lobster Tails', 420, 30, 5, 1, 0, 30, 15, 13, 200, 650, 100, 1.5,
 'Lobster tails, butter, garlic, lemon juice, parsley, paprika, salt, black pepper',
 1, 'Contains shellfish and dairy, gluten-free', TRUE, 'Meal'),

('Roasted Rack of Venison', 520, 45, 8, 2, 0, 32, 12, 18, 95, 580, 60, 6.0,
 'Venison rack, juniper berries, garlic, thyme, rosemary, red wine, butter, olive oil',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Chicken and Chorizo Paella', 580, 40, 50, 5, 4, 25, 8, 15, 110, 880, 60, 4.0,
 'Chicken thighs, chorizo, bomba rice, bell peppers, peas, tomatoes, onion, garlic, saffron, paprika',
 1, 'Gluten-free', TRUE, 'Meal'),

('Beef Tenderloin Carpaccio', 320, 25, 5, 1, 0, 22, 8, 12, 70, 480, 40, 3.0,
 'Beef tenderloin, arugula, capers, lemon juice, olive oil, parmesan cheese, black pepper',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Pork Vindaloo', 580, 40, 20, 5, 4, 38, 14, 22, 110, 780, 60, 4.5,
 'Pork shoulder, vinegar, garlic, ginger, onions, tomatoes, potatoes, chili powder, cumin, coriander, turmeric',
 1, 'Gluten-free', TRUE, 'Meal'),

('Grilled T-Bone Steak', 650, 50, 2, 0, 0, 48, 20, 26, 120, 580, 40, 5.0,
 'T-bone steak, garlic, rosemary, thyme, butter, salt, black pepper, olive oil',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Maple Bourbon Glazed Turkey Breast', 520, 48, 20, 15, 0, 28, 8, 18, 120, 680, 50, 3.0,
 'Turkey breast, maple syrup, bourbon, soy sauce, garlic, dijon mustard, black pepper',
 1, 'Contains soy', TRUE, 'Meal'),

('Chinese Five Spice Pork Belly', 680, 35, 15, 10, 1, 55, 22, 30, 110, 780, 40, 2.5,
 'Pork belly, five spice powder, honey, soy sauce, garlic, ginger, rice wine, star anise',
 1, 'Contains soy', TRUE, 'Meal'),

('Classic Beef Stroganoff', 580, 40, 30, 5, 2, 38, 18, 18, 110, 750, 100, 4.5,
 'Beef sirloin, mushrooms, onion, garlic, beef broth, sour cream, Dijon mustard, egg noodles, parsley',
 1, 'Contains dairy, gluten, and egg', TRUE, 'Meal'),

('Sun-Dried Tomato Stuffed Chicken', 520, 42, 12, 5, 2, 32, 10, 20, 100, 720, 150, 3.0,
 'Chicken breast, sun-dried tomatoes, feta cheese, spinach, garlic, Italian herbs, olive oil',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Harissa Lamb Shanks', 580, 40, 15, 5, 3, 40, 18, 20, 120, 720, 80, 5.0,
 'Lamb shanks, harissa paste, tomatoes, onions, garlic, cinnamon, cumin, coriander, chicken broth',
 1, 'Gluten-free', TRUE, 'Meal'),

('Seared Scallops with Bacon', 420, 30, 8, 2, 0, 28, 10, 16, 80, 780, 40, 1.2,
 'Sea scallops, bacon, butter, garlic, lemon juice, white wine, parsley, black pepper',
 1, 'Contains shellfish and dairy, gluten-free', TRUE, 'Meal'),

('Pulled Pork with BBQ Sauce', 580, 40, 25, 20, 1, 38, 14, 22, 110, 850, 60, 3.0,
 'Pork shoulder, BBQ sauce, apple cider vinegar, brown sugar, paprika, garlic powder, onion powder',
 1, 'Gluten-free', TRUE, 'Meal'),

('Herb Crusted Pork Rib Roast', 620, 45, 10, 2, 1, 42, 16, 24, 120, 680, 80, 3.5,
 'Pork rib roast, garlic, rosemary, thyme, sage, dijon mustard, olive oil, salt, pepper',
 1, 'Gluten-free', TRUE, 'Meal'),

('Chicken Parmesan', 650, 45, 35, 8, 3, 35, 15, 18, 110, 980, 380, 3.0,
 'Chicken breast, breadcrumbs, parmesan cheese, mozzarella cheese, marinara sauce, basil, garlic',
 1, 'Contains dairy and gluten', TRUE, 'Meal'),

('Beef Tri-Tip Roast', 580, 48, 5, 1, 0, 38, 15, 21, 110, 680, 50, 4.5,
 'Beef tri-tip, garlic, rosemary, thyme, olive oil, salt, black pepper, beef broth',
 1, 'Gluten-free', TRUE, 'Meal'),

('Bacon Wrapped Pork Tenderloin', 550, 45, 8, 3, 0, 35, 12, 21, 120, 850, 50, 3.0,
 'Pork tenderloin, bacon, garlic, rosemary, thyme, dijon mustard, maple syrup, olive oil',
 1, 'Gluten-free', TRUE, 'Meal'),

('Chicken Cordon Bleu Casserole', 620, 45, 20, 3, 1, 40, 18, 20, 120, 880, 350, 2.5,
 'Chicken breast, ham, Swiss cheese, breadcrumbs, butter, milk, flour, dijon mustard, thyme',
 1, 'Contains dairy and gluten', TRUE, 'Meal'),

('Coconut Curry Chicken', 580, 40, 25, 12, 4, 38, 22, 14, 100, 780, 80, 3.5,
 'Chicken thighs, coconut milk, curry powder, tomatoes, onion, garlic, ginger, cilantro, lime',
 1, 'Gluten-free', TRUE, 'Meal'),

('Beef Tenderloin with Port Wine Sauce', 620, 45, 15, 8, 0, 40, 16, 22, 110, 680, 60, 4.5,
 'Beef tenderloin, port wine, shallots, beef broth, butter, thyme, black pepper, salt',
 1, 'Contains dairy, gluten-free', TRUE, 'Meal');


-- Vegetarian meals (CategoryID = 2)
INSERT INTO meals (
  MealName, Calories_cal, Protein_g, Carbs_g, Sugars_g, Fibers_g,
  Fat_g, SatFat_g, UnsatFat_g, Cholesterol_mg, Sodium_mg, Calcium_mg, Iron_mg,
  Ingredients, CategoryID, DietNotes, IsHomeCooked, IsMealorSnack
)
VALUES
('Grilled Halloumi Salad', 407, 33.6, 52.8, 6.0, 7.4, 1.8, 15.2, 40, 421, 249, 249, 3.2,
  'milk, black beans, garlic, yogurt, herbs, cauliflower, cheese, lemon juice, sour cream',
  2, 'GF', TRUE, 'Meal'),

('Sweet Potato & Black Bean Tacos', 464, 23.2, 32.6, 4.7, 8.1, 7.3, 12.4, 20, 0, 656, 179, 3.7,
    'bell pepper, chickpeas, mushrooms, almonds, ginger, olive oil, tomatoes, soy sauce, paneer, multigrain bread, garlic, carrot',
    2, 'Contains Dairy', TRUE, 'Meal'),

('Eggplant Parmesan', 526, 26.3, 58.6, 9.3, 7.6, 5.4, 8.6, 30, 0, 797, 186, 2.4,
 'cheese, quinoa, basil, mushrooms, onion, spinach, sunflower seeds, lemon juice',
 2, 'Contains Dairy', TRUE, 'Meal'),

('Vegetarian Burrito Bowl', 309, 29.7, 58.0, 4.7, 5.7, 1.7, 13.8, 0, 0, 320, 136, 2.2,
 'eggplant, sour cream, oats, cucumber, spices, tofu, broccoli, multigrain bread, olive oil, onion',
 2, 'Contains Gluten', TRUE, 'Meal'),

('Paneer Butter Masala', 388, 12.8, 38.5, 2.3, 4.0, 2.0, 9.7, 0, 50, 358, 54, 1.8,
 'pumpkin seeds, pasta, lentils, broccoli, paneer, chickpeas, almonds, bell pepper, whole wheat tortillas',
 2, 'Contains Gluten', TRUE, 'Meal'),

('Vegetarian Chili', 366, 28.0, 49.5, 3.6, 5.9, 4.5, 9.2, 0, 30, 649, 116, 3.0,
 'coconut milk, sesame oil, black beans, mushrooms, cheese, lentils, parsley, cucumber, chickpeas, olive oil, pasta, milk, paneer, kale',
 2, 'Contains Gluten', TRUE, 'Meal'),

('Tofu Scramble Breakfast Bowl', 528, 11.1, 52.4, 3.1, 5.7, 5.4, 9.6, 0, 20, 439, 117, 1.9,
 'avocado, basil, carrot, coriander, lemon juice, soy sauce, paneer, garlic, broccoli, pumpkin seeds, quinoa, cheese',
 2, 'Egg-Free', TRUE, 'Meal'),

('Vegetable Biryani', 352, 24.3, 51.1, 3.0, 3.6, 4.1, 14.4, 0, 0, 561, 130, 2.7,
 'sunflower seeds, kale, cottage cheese, multigrain bread, avocado, whole wheat tortillas, tempeh, cheese, cauliflower, basil',
 2, 'Contains Gluten', TRUE, 'Meal'),

('Chickpea & Spinach Stew', 303, 19.6, 47.7, 5.3, 8.6, 1.4, 19.9, 0, 40, 300, 142, 3.1,
 'cauliflower, milk, sesame oil, tomatoes, eggs, lentils, tempeh, tofu, olive oil, sour cream, cheese, whole wheat tortillas',
 2, 'NF', TRUE, 'Meal'),

('Miso Ramen with Tofu', 303, 12.6, 36.7, 8.4, 5.8, 5.5, 8.5, 0, 0, 433, 199, 1.9,
 'spices, soy sauce, sesame oil, yogurt, quinoa, zucchini, lentils, basil, cottage cheese, spinach, lemon juice',
 2, 'Egg-Free', TRUE, 'Meal'),

('Veggie Tikka Masala', 519, 24.0, 48.2, 8.1, 9.9, 1.2, 8.8, 0, 60, 337, 188, 3.3,
 'broccoli, chickpeas, cashews, garlic, sesame oil, cottage cheese, avocado, sour cream, mushrooms, eggs, coriander, almonds, kale, whole wheat tortillas',
 2, 'GF', TRUE, 'Meal'),

('Peanut Butter Banana Oatmeal', 445, 11.8, 49.1, 7.0, 4.8, 4.2, 14.3, 0, 50, 378, 167, 2.3,
 'almonds, garlic, black beans, lentils, soy sauce, brown rice, lemon juice, oats, multigrain bread, cottage cheese, broccoli',
 2, 'Egg-Free', TRUE, 'Meal'),

('Mushroom Tacos', 408, 18.5, 46.2, 6.3, 7.8, 1.4, 5.9, 0, 30, 706, 168, 1.6,
 'mushrooms, onion, zucchini, coriander, soy sauce, vegetables, yogurt, tomatoes, lentils, peanuts, pumpkin seeds',
 2, 'GF', TRUE, 'Meal'),

('Vegetarian Sushi Rolls', 392, 14.6, 59.2, 8.3, 5.1, 4.2, 0, 8.2, 30, 753, 70, 3.2,
'cottage cheese, avocado, coconut milk, sour cream, oats, garlic, sesame oil, quinoa, coriander, milk, multigrain bread, spices, olive oil',
 2, 'GF', TRUE, 'Meal'),

('Vegetable Gyoza', 585, 16.1, 59.7, 7.9, 3.7, 5.2, 17.9, 0, 40, 330, 54, 1.6,
 'tofu, sunflower seeds, pumpkin seeds, parsley, cashews, whole wheat tortillas, oats, almonds, milk, avocado',
 2, 'NF', TRUE, 'Meal'),

('Curried Pumpkin Soup', 306, 33.0, 35.4, 3.0, 5.9, 6.5, 0, 16.3, 50, 349, 150, 1.3,
 'onion, carrot, sunflower seeds, broccoli, spinach, cheese, lentils, sweet potato, ginger',
 2, 'Egg-Free', TRUE, 'Meal'),

('Three Bean Salad', 491, 13.5, 39.2, 5.4, 7.2, 4.3, 7.8, 0, 40, 369, 217, 1.6,
 'carrot, pumpkin seeds, avocado, cashews, bell pepper, cauliflower, lentils, sesame oil, ginger, coconut milk, eggplant, zucchini',
 2, 'NF', TRUE, 'Meal'),

('Herbed Couscous with Vegetables', 362, 17.9, 40.7, 9.7, 8.5, 4.2, 7.5, 0, 50, 549, 205, 2.9,
 'mushrooms, lemon juice, peanuts, quinoa, garlic, almonds, whole wheat tortillas, cottage cheese, pumpkin seeds, sunflower seeds, sesame oil, basil, spices, tempeh',
 2, 'NF', TRUE, 'Meal'),
  
('Spicy Honey Garlic Tofu Noodles', 520, 35, 40, 6, 2, 25, 5, 18, 75, 950, 70, 2.1,
 'Tofu, udon noodles, garlic, chili flakes, soy sauce, honey, spring onions, sesame oil',
 2, 'Contains soy and gluten', TRUE, 'Meal'),
 
('Mediterranean Tofu Feta Bake', 620, 38, 12, 5, 2, 45, 18, 20, 110, 700, 220, 3.0,
 'Tofu, feta cheese, onion, garlic, chili flakes, parsley, egg, breadcrumbs, olive oil, tomato sauce',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),
 
('Plant Protein Sweetcorn Fritters', 400, 30, 20, 3, 2, 22, 4, 15, 70, 500, 60, 1.8,
 'Plant-based protein, sweetcorn, egg, breadcrumbs, spring onions, lemon zest, olive oil, salt, pepper',
 2, 'Contains gluten and egg', TRUE, 'Meal'),
 
('Harissa Spiced Tofu with Couscous', 480, 35, 30, 2, 2, 22, 3, 15, 120, 500, 100, 1.9,
 'Tofu, couscous, harissa paste, lemon juice, coriander, olive oil, garlic',
 2, 'Contains gluten and soy', TRUE, 'Meal'),
 
('Lemon Herb Tofu Cutlets', 410, 36, 10, 1, 1, 25, 4, 18, 70, 450, 80, 1.2,
 'Tofu fillet, parsley, dill, lemon zest, breadcrumbs, olive oil, garlic',
 2, 'Contains gluten', TRUE, 'Meal'),
  
('Spinach & Ricotta Stuffed Shells', 520, 24, 60, 8, 6, 22, 12, 8, 60, 680, 450, 3.2,
 'Pasta shells, ricotta cheese, spinach, egg, parmesan, mozzarella, marinara sauce, garlic, basil',
 2, 'Contains dairy, gluten, and egg', TRUE, 'Meal'),

('Black Bean & Sweet Potato Enchiladas', 480, 18, 70, 15, 12, 15, 7, 7, 20, 720, 220, 4.0,
 'Black beans, sweet potatoes, tortillas, enchilada sauce, cheese, onion, garlic, cumin, oregano',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Shakshuka', 350, 16, 20, 10, 5, 22, 6, 14, 372, 620, 180, 5.2,
 'Eggs, tomatoes, bell peppers, onion, garlic, cumin, paprika, feta cheese, parsley, olive oil',
 2, 'Contains dairy and eggs, gluten-free', TRUE, 'Meal'),

('Caprese Stuffed Portobello Mushrooms', 320, 18, 10, 5, 3, 24, 10, 12, 45, 480, 350, 2.0,
 'Portobello mushrooms, mozzarella, tomatoes, basil, balsamic glaze, olive oil, garlic',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Vegetable Lasagna', 490, 22, 55, 12, 8, 20, 10, 8, 50, 650, 400, 3.5,
 'Lasagna noodles, ricotta, mozzarella, parmesan, zucchini, spinach, mushrooms, marinara sauce, garlic',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Feta & Spinach Quiche', 420, 16, 30, 4, 3, 28, 14, 12, 180, 550, 300, 3.8,
 'Pie crust, eggs, feta cheese, spinach, onion, milk, cream, nutmeg, olive oil',
 2, 'Contains dairy, gluten, and eggs', TRUE, 'Meal'),

('Halloumi & Roasted Vegetable Wrap', 480, 18, 50, 8, 6, 24, 12, 10, 40, 720, 350, 2.8,
 'Halloumi cheese, zucchini, bell peppers, eggplant, onion, whole wheat wrap, hummus, spinach',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Mushroom Risotto with Parmesan', 520, 15, 70, 4, 4, 20, 10, 8, 25, 780, 220, 2.5,
 'Arborio rice, mushrooms, vegetable broth, white wine, parmesan, onion, garlic, butter, thyme',
 2, 'Contains dairy', TRUE, 'Meal'),

('Spinach & Feta Pie', 450, 18, 40, 5, 4, 26, 14, 10, 110, 680, 380, 4.2,
 'Phyllo dough, spinach, feta cheese, eggs, onion, dill, parsley, olive oil',
 2, 'Contains dairy, gluten, and eggs', TRUE, 'Meal'),

('Eggplant Parmesan', 480, 20, 45, 12, 8, 25, 12, 11, 45, 750, 380, 2.5,
 'Eggplant, breadcrumbs, parmesan, mozzarella, eggs, marinara sauce, basil, garlic, olive oil',
 2, 'Contains dairy, gluten, and eggs', TRUE, 'Meal'),

('Vegetarian Chili', 380, 16, 60, 12, 15, 10, 2, 7, 0, 820, 120, 5.5,
 'Kidney beans, black beans, tomatoes, bell pepper, onion, garlic, chili powder, cumin, oregano, vegetable broth',
 2, 'Gluten-free, vegan-adaptable', TRUE, 'Meal'),

('Margherita Pizza', 650, 25, 80, 8, 5, 24, 12, 10, 50, 950, 400, 3.0,
 'Pizza dough, tomatoes, fresh mozzarella, basil, olive oil, garlic',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Lentil Shepherds Pie', 420, 18, 65, 10, 14, 10, 2, 7, 0, 580, 80, 6.0,
 'Lentils, carrots, peas, corn, onion, garlic, tomato paste, vegetable broth, potatoes, butter, milk',
 2, 'Contains dairy', TRUE, 'Meal'),

('Mediterranean Quinoa Bowl', 450, 15, 60, 8, 10, 18, 3, 13, 10, 580, 150, 4.2,
 'Quinoa, cucumber, tomatoes, red onion, kalamata olives, feta cheese, chickpeas, parsley, lemon juice, olive oil',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Bean & Cheese Enchiladas', 550, 20, 70, 8, 10, 20, 10, 8, 40, 880, 350, 3.5,
 'Pinto beans, black beans, corn tortillas, enchilada sauce, cheddar cheese, onion, garlic, sour cream, cilantro',
 2, 'Contains dairy', TRUE, 'Meal'),

('Stuffed Bell Peppers', 380, 15, 50, 10, 8, 12, 5, 6, 20, 650, 150, 3.0,
 'Bell peppers, quinoa, black beans, corn, tomatoes, onion, garlic, cumin, chili powder, cheese',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Three Cheese Macaroni', 650, 25, 70, 5, 3, 30, 18, 10, 80, 950, 450, 2.0,
 'Macaroni, cheddar cheese, gruyere, parmesan, milk, butter, flour, breadcrumbs, mustard powder',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Falafel Pita', 520, 18, 75, 5, 10, 18, 3, 13, 0, 720, 150, 4.0,
 'Chickpeas, parsley, cilantro, garlic, cumin, pita bread, tahini sauce, lettuce, tomato, cucumber, red onion',
 2, 'Contains gluten', TRUE, 'Meal'),

('Sweet Potato & Black Bean Tacos', 420, 14, 65, 10, 12, 15, 3, 10, 10, 580, 150, 3.5,
 'Sweet potatoes, black beans, corn tortillas, avocado, lime, cilantro, cumin, chili powder, sour cream',
 2, 'Contains dairy', TRUE, 'Meal'),

('Caprese Pasta Salad', 450, 16, 55, 6, 4, 20, 8, 10, 30, 580, 300, 2.5,
 'Pasta, cherry tomatoes, fresh mozzarella, basil, balsamic vinegar, olive oil, garlic, black pepper',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Vegetable Pad Thai', 480, 15, 70, 15, 5, 18, 3, 13, 0, 950, 100, 3.0,
 'Rice noodles, tofu, bean sprouts, carrots, green onions, peanuts, eggs, tamarind paste, soy sauce, lime',
 2, 'Contains soy, nuts, and eggs', TRUE, 'Meal'),

('Mushroom & Lentil Bolognese', 420, 18, 65, 8, 12, 10, 2, 7, 0, 650, 80, 5.0,
 'Lentils, mushrooms, carrots, celery, onion, garlic, tomatoes, red wine, spaghetti, nutritional yeast',
 2, 'Contains gluten, vegan-adaptable', TRUE, 'Meal'),

('Greek Stuffed Tomatoes', 350, 12, 40, 10, 6, 18, 5, 11, 20, 580, 150, 3.0,
 'Tomatoes, rice, feta cheese, spinach, onion, garlic, oregano, mint, olive oil, lemon juice',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Butternut Squash Risotto', 480, 12, 75, 8, 6, 15, 8, 6, 30, 680, 150, 2.5,
 'Arborio rice, butternut squash, vegetable broth, white wine, parmesan, onion, garlic, sage, butter',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Spanakopita', 480, 15, 45, 3, 4, 28, 10, 16, 80, 680, 350, 3.5,
 'Phyllo dough, spinach, feta cheese, eggs, onion, dill, parsley, olive oil, black pepper',
 2, 'Contains dairy, gluten, and eggs', TRUE, 'Meal'),

('Vegetable Curry', 420, 10, 65, 10, 12, 15, 10, 4, 0, 650, 100, 4.0,
 'Cauliflower, chickpeas, carrots, peas, onion, garlic, ginger, coconut milk, curry powder, turmeric, rice',
 2, 'Gluten-free, vegan-adaptable', TRUE, 'Meal'),

('Baked Ziti', 580, 25, 70, 10, 4, 22, 12, 8, 50, 750, 400, 3.0,
 'Ziti pasta, ricotta cheese, mozzarella, parmesan, marinara sauce, garlic, basil, oregano',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Stuffed Acorn Squash', 380, 12, 55, 15, 8, 16, 3, 11, 10, 480, 120, 3.5,
 'Acorn squash, quinoa, cranberries, pecans, spinach, onion, garlic, maple syrup, feta cheese',
 2, 'Contains dairy and nuts, gluten-free', TRUE, 'Meal'),

('Pesto Pasta with Roasted Vegetables', 520, 15, 65, 8, 6, 22, 5, 15, 10, 580, 150, 3.0,
 'Pasta, zucchini, bell peppers, cherry tomatoes, basil, garlic, pine nuts, parmesan, olive oil',
 2, 'Contains dairy, nuts, and gluten', TRUE, 'Meal'),

('Avocado Quinoa Power Bowl', 480, 15, 60, 5, 12, 22, 3, 17, 0, 580, 100, 4.5,
 'Quinoa, avocado, black beans, corn, cherry tomatoes, red onion, cilantro, lime juice, olive oil',
 2, 'Gluten-free, vegan-adaptable', TRUE, 'Meal'),

('Mushroom Wellington', 580, 12, 50, 5, 4, 35, 12, 20, 30, 650, 80, 3.5,
 'Portobello mushrooms, puff pastry, spinach, walnuts, onion, garlic, thyme, dijon mustard, egg',
 2, 'Contains gluten, nuts, and egg', TRUE, 'Meal'),

('Thai Red Curry with Tofu', 450, 15, 40, 8, 6, 25, 18, 5, 0, 780, 150, 3.5,
 'Tofu, red curry paste, coconut milk, bell peppers, bamboo shoots, carrots, basil, lime, brown rice',
 2, 'Contains soy, gluten-free', TRUE, 'Meal'),

('Goat Cheese & Beetroot Salad', 320, 12, 25, 15, 5, 22, 8, 12, 30, 480, 150, 2.5,
 'Mixed greens, roasted beetroot, goat cheese, walnuts, balsamic vinegar, honey, olive oil, thyme',
 2, 'Contains dairy and nuts, gluten-free', TRUE, 'Meal'),

('Zucchini Boats', 350, 18, 20, 8, 5, 22, 10, 10, 45, 580, 300, 2.0,
 'Zucchini, quinoa, bell peppers, onion, garlic, tomatoes, feta cheese, mozzarella, olive oil, oregano',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Vegetable Paella', 420, 10, 75, 6, 8, 10, 1, 8, 0, 580, 60, 3.0,
 'Arborio rice, artichokes, bell peppers, peas, tomatoes, onion, garlic, saffron, paprika, vegetable broth',
 2, 'Gluten-free, vegan-adaptable', TRUE, 'Meal'),

('Three Bean Casserole', 380, 18, 60, 8, 14, 8, 2, 5, 0, 650, 120, 5.0,
 'Kidney beans, black beans, cannellini beans, tomatoes, bell peppers, onion, garlic, cumin, paprika, cheese',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Tomato Basil Gnocchi', 450, 12, 70, 6, 4, 15, 8, 6, 20, 680, 150, 2.5,
 'Potato gnocchi, cherry tomatoes, basil, garlic, parmesan, olive oil, butter, black pepper',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Vegetarian Moussaka', 480, 15, 35, 12, 8, 30, 10, 18, 30, 650, 200, 3.0,
 'Eggplant, potatoes, lentils, tomatoes, onion, garlic, cinnamon, allspice, bechamel sauce, parmesan',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Cauliflower Buffalo Wings', 350, 10, 40, 5, 6, 18, 3, 13, 0, 750, 80, 2.0,
 'Cauliflower, flour, milk, garlic powder, hot sauce, butter, celery, blue cheese dressing',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Spinach Artichoke Pasta', 520, 20, 65, 4, 5, 22, 10, 10, 40, 780, 300, 3.0,
 'Pasta, spinach, artichoke hearts, cream cheese, parmesan, mozzarella, garlic, olive oil',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Greek Quinoa Salad', 380, 12, 45, 5, 8, 20, 4, 14, 15, 580, 150, 3.5,
 'Quinoa, cucumber, tomatoes, red onion, kalamata olives, feta cheese, parsley, lemon juice, olive oil',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Vegetarian Jambalaya', 420, 14, 75, 8, 10, 8, 1, 6, 0, 780, 80, 4.0,
 'Brown rice, kidney beans, bell peppers, celery, onion, garlic, tomatoes, cajun seasoning, hot sauce',
 2, 'Gluten-free, vegan-adaptable', TRUE, 'Meal'),

('Tofu Stir Fry', 380, 18, 35, 8, 6, 18, 3, 13, 0, 680, 200, 4.0,
 'Tofu, broccoli, bell peppers, carrots, snow peas, garlic, ginger, soy sauce, sesame oil, rice',
 2, 'Contains soy', TRUE, 'Meal'),

('Miso Ramen with Tofu', 450, 18, 65, 5, 4, 12, 2, 9, 0, 850, 150, 3.5,
 'Ramen noodles, tofu, miso paste, mushrooms, spinach, green onions, carrots, sesame oil, soy sauce',
 2, 'Contains soy and gluten', TRUE, 'Meal'),

('Vegetarian Pot Pie', 520, 12, 60, 8, 6, 24, 12, 10, 30, 680, 100, 3.0,
 'Carrots, peas, potatoes, celery, onion, butter, flour, vegetable broth, milk, pie crust',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Farro Salad with Roasted Vegetables', 420, 14, 70, 10, 12, 12, 2, 9, 0, 480, 80, 4.0,
 'Farro, zucchini, bell peppers, cherry tomatoes, red onion, feta cheese, arugula, balsamic vinegar, olive oil',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Vegetable Biryani', 450, 10, 80, 5, 8, 10, 2, 7, 0, 580, 80, 3.5,
 'Basmati rice, mixed vegetables, onion, garlic, ginger, yogurt, turmeric, cumin, coriander, cardamom',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Mushroom & Truffle Risotto', 580, 12, 75, 4, 3, 25, 12, 11, 30, 650, 180, 2.5,
 'Arborio rice, mushrooms, truffle oil, vegetable broth, white wine, parmesan, onion, garlic, butter',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Chickpea & Spinach Curry', 380, 15, 50, 8, 12, 14, 8, 5, 0, 580, 150, 4.5,
 'Chickpeas, spinach, tomatoes, onion, garlic, ginger, coconut milk, curry powder, turmeric, cumin, rice',
 2, 'Gluten-free, vegan-adaptable', TRUE, 'Meal'),

('Broccoli Cheddar Soup', 450, 18, 25, 5, 6, 30, 15, 13, 50, 750, 350, 2.0,
 'Broccoli, carrots, onion, garlic, cheddar cheese, milk, cream, flour, butter, vegetable broth',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Stuffed Cabbage Rolls', 420, 15, 55, 10, 8, 14, 4, 9, 30, 580, 120, 3.5,
 'Cabbage, rice, lentils, onion, garlic, vegetable broth, tomato sauce, parsley, dill, paprika',
 2, 'Gluten-free, vegan-adaptable', TRUE, 'Meal'),

('Red Lentil Dal', 350, 18, 50, 6, 12, 8, 1, 6, 0, 520, 80, 5.0,
 'Red lentils, tomatoes, onion, garlic, ginger, curry powder, turmeric, cumin, coconut milk, cilantro',
 2, 'Gluten-free, vegan-adaptable', TRUE, 'Meal'),
  
('Mediterranean Stuffed Peppers', 380, 15, 45, 10, 8, 16, 5, 10, 20, 520, 150, 3.0,
 'Bell peppers, quinoa, feta cheese, olives, sun-dried tomatoes, spinach, garlic, olive oil, lemon zest',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Eggplant Lasagna', 450, 20, 40, 12, 8, 25, 12, 11, 60, 680, 350, 3.0,
 'Eggplant, ricotta cheese, mozzarella, parmesan, marinara sauce, basil, garlic, olive oil',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Spinach and Ricotta Cannelloni', 520, 22, 55, 8, 5, 25, 14, 9, 50, 720, 400, 3.0,
 'Cannelloni pasta, ricotta cheese, spinach, parmesan, mozzarella, marinara sauce, garlic, nutmeg',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Mushroom Wellington', 580, 15, 55, 5, 8, 32, 10, 20, 20, 680, 80, 4.0,
 'Portobello mushrooms, puff pastry, spinach, chestnuts, thyme, garlic, dijon mustard, egg',
 2, 'Contains gluten, nuts, and egg', TRUE, 'Meal'),

('Greek Moussaka', 520, 18, 35, 12, 8, 32, 15, 15, 80, 720, 250, 3.0,
 'Eggplant, potatoes, onion, tomatoes, lentils, béchamel sauce, cinnamon, nutmeg, parmesan',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Spanish Tortilla', 450, 16, 30, 3, 3, 28, 8, 18, 370, 580, 150, 2.5,
 'Potatoes, eggs, onion, bell pepper, olive oil, paprika, parsley',
 2, 'Contains eggs, gluten-free', TRUE, 'Meal'),

('Roasted Vegetable Tart', 480, 14, 40, 6, 5, 30, 15, 13, 50, 620, 200, 2.5,
 'Puff pastry, zucchini, bell peppers, mushrooms, onion, goat cheese, thyme, balsamic glaze',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Butternut Squash Risotto', 520, 12, 75, 8, 6, 18, 9, 7, 25, 680, 150, 2.0,
 'Arborio rice, butternut squash, vegetable broth, white wine, onion, parmesan cheese, sage, butter',
 2, 'Contains dairy', TRUE, 'Meal'),

('Spinach and Feta Spanakopita', 480, 15, 40, 3, 5, 28, 12, 14, 80, 650, 300, 3.5,
 'Phyllo pastry, spinach, feta cheese, ricotta cheese, eggs, dill, green onions, nutmeg',
 2, 'Contains dairy, gluten, and eggs', TRUE, 'Meal'),

('Caprese Stuffed Portobello Mushrooms', 350, 16, 12, 5, 3, 25, 10, 13, 40, 450, 320, 2.0,
 'Portobello mushrooms, mozzarella cheese, tomatoes, basil, balsamic glaze, garlic, olive oil',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Vegetable Paella', 420, 12, 70, 8, 8, 10, 1, 8, 0, 550, 80, 3.5,
 'Arborio rice, bell peppers, peas, tomatoes, artichoke hearts, olives, saffron, paprika',
 2, 'Vegan-adaptable, gluten-free', TRUE, 'Meal'),

('Sweet Potato and Black Bean Enchiladas', 480, 15, 70, 12, 13, 16, 6, 8, 20, 720, 200, 4.0,
 'Sweet potatoes, black beans, corn tortillas, enchilada sauce, cheese, cilantro, lime, cumin',
 2, 'Contains dairy', TRUE, 'Meal'),

('Cheese and Spinach Stuffed Shells', 540, 25, 55, 8, 5, 25, 14, 9, 60, 750, 450, 3.0,
 'Jumbo pasta shells, ricotta cheese, spinach, mozzarella, parmesan, marinara sauce, basil',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Vegetable Biryani', 450, 12, 75, 8, 10, 12, 2, 9, 0, 580, 80, 3.0,
 'Basmati rice, mixed vegetables, yogurt, biryani spice mix, cashews, raisins, mint, cilantro',
 2, 'Contains dairy and nuts', TRUE, 'Meal'),

('Broccoli and Cheddar Quiche', 520, 18, 35, 3, 4, 35, 18, 15, 220, 680, 350, 2.5,
 'Pie crust, eggs, broccoli, cheddar cheese, milk, cream, onion, garlic, nutmeg',
 2, 'Contains dairy, gluten, and eggs', TRUE, 'Meal'),

('Mushroom and Leek Risotto', 480, 12, 70, 4, 4, 18, 8, 8, 25, 650, 120, 2.0,
 'Arborio rice, mushrooms, leeks, vegetable broth, white wine, parmesan cheese, butter, thyme',
 2, 'Contains dairy', TRUE, 'Meal'),

('Falafel Plate with Tzatziki', 520, 18, 60, 6, 12, 22, 4, 16, 10, 680, 150, 4.5,
 'Chickpeas, herbs, spices, yogurt, cucumber, garlic, pita bread, tahini, lemon juice',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Spinach and Ricotta Calzone', 580, 24, 65, 5, 4, 26, 12, 12, 50, 750, 380, 3.5,
 'Pizza dough, ricotta cheese, spinach, mozzarella, parmesan, garlic, oregano, marinara sauce',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Ratatouille with Polenta', 420, 10, 55, 12, 10, 18, 4, 12, 10, 580, 100, 3.0,
 'Eggplant, zucchini, bell peppers, tomatoes, onion, garlic, herbs, polenta, parmesan',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Vegetable Pot Pie', 520, 14, 55, 8, 6, 28, 12, 14, 40, 680, 120, 3.0,
 'Carrots, peas, potatoes, mushrooms, onion, vegetable broth, butter, flour, milk, pie crust',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Mediterranean Stuffed Zucchini', 380, 16, 30, 8, 5, 22, 8, 12, 30, 580, 200, 2.5,
 'Zucchini, quinoa, tomatoes, feta cheese, olives, pine nuts, mint, lemon juice, olive oil',
 2, 'Contains dairy and nuts, gluten-free', TRUE, 'Meal'),

('Cheese Souffle', 420, 18, 20, 2, 1, 30, 16, 12, 250, 620, 300, 1.5,
 'Eggs, gruyere cheese, parmesan cheese, butter, flour, milk, nutmeg, cream of tartar',
 2, 'Contains dairy, gluten, and eggs', TRUE, 'Meal'),

('Vegetable Lasagna Roll-Ups', 520, 24, 50, 8, 5, 25, 12, 11, 50, 720, 400, 3.0,
 'Lasagna noodles, ricotta cheese, spinach, zucchini, mushrooms, mozzarella, marinara sauce',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Shakshuka', 380, 16, 25, 10, 5, 24, 8, 14, 370, 580, 150, 4.0,
 'Eggs, tomatoes, bell peppers, onion, garlic, cumin, paprika, feta cheese, cilantro',
 2, 'Contains dairy and eggs, gluten-free', TRUE, 'Meal'),

('Stuffed Delicata Squash', 420, 14, 60, 15, 10, 16, 5, 9, 20, 450, 120, 3.5,
 'Delicata squash, wild rice, cranberries, pecans, feta cheese, sage, maple syrup',
 2, 'Contains dairy and nuts, gluten-free', TRUE, 'Meal'),

('Vegetable Korma', 480, 14, 40, 10, 8, 28, 18, 8, 30, 620, 150, 3.0,
 'Mixed vegetables, yogurt, coconut milk, cashews, tomatoes, onion, ginger, garlic, spices',
 2, 'Contains dairy and nuts, gluten-free', TRUE, 'Meal'),

('Zucchini Parmesan', 450, 20, 30, 8, 5, 28, 12, 14, 40, 650, 350, 2.5,
 'Zucchini, breadcrumbs, parmesan cheese, mozzarella, eggs, marinara sauce, basil, garlic',
 2, 'Contains dairy, gluten, and eggs', TRUE, 'Meal'),

('Vegetable Wellington', 580, 16, 60, 6, 8, 30, 12, 16, 20, 680, 100, 4.0,
 'Puff pastry, mushrooms, spinach, carrots, beets, chestnuts, thyme, dijon mustard',
 2, 'Contains gluten and nuts', TRUE, 'Meal'),

('Cauliflower and Chickpea Curry', 420, 14, 45, 10, 12, 20, 12, 6, 10, 580, 150, 4.0,
 'Cauliflower, chickpeas, coconut milk, tomatoes, onion, garlic, ginger, curry spices',
 2, 'Vegan-adaptable, gluten-free', TRUE, 'Meal'),

('Roasted Beet and Goat Cheese Tart', 480, 14, 40, 10, 5, 28, 14, 12, 40, 550, 150, 2.5,
 'Puff pastry, beets, goat cheese, walnuts, honey, thyme, balsamic glaze, arugula',
 2, 'Contains dairy, gluten, and nuts', TRUE, 'Meal'),

('Spinach and Artichoke Stuffed Portobello Mushrooms', 380, 18, 15, 3, 6, 28, 12, 14, 40, 620, 250, 2.5,
 'Portobello mushrooms, spinach, artichoke hearts, cream cheese, parmesan, mozzarella, garlic',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Lentil and Mushroom Shepherd\'s Pie', 420, 18, 60, 10, 14, 12, 4, 6, 10, 680, 80, 5.0,
 'Lentils, mushrooms, carrots, peas, onion, vegetable broth, tomato paste, potatoes, butter',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Butternut Squash Mac and Cheese', 550, 20, 65, 8, 6, 25, 14, 9, 60, 750, 350, 2.5,
 'Pasta, butternut squash, cheddar cheese, milk, butter, nutmeg, breadcrumbs, sage',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Vegetable and Cheese Frittata', 420, 20, 15, 3, 3, 30, 12, 16, 380, 580, 300, 2.0,
 'Eggs, bell peppers, spinach, onion, zucchini, feta cheese, parmesan, herbs',
 2, 'Contains dairy and eggs, gluten-free', TRUE, 'Meal'),

('Stuffed Eggplant Parmesan', 450, 18, 35, 10, 8, 26, 12, 12, 40, 650, 300, 2.5,
 'Eggplant, ricotta cheese, spinach, mozzarella, parmesan, marinara sauce, basil, garlic',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Quinoa Stuffed Acorn Squash', 380, 14, 60, 12, 10, 12, 3, 8, 10, 420, 100, 4.0,
 'Acorn squash, quinoa, cranberries, pecans, feta cheese, kale, olive oil, maple syrup',
 2, 'Contains dairy and nuts, gluten-free', TRUE, 'Meal'),

('Mushroom and Swiss Chard Galette', 520, 16, 45, 5, 4, 32, 16, 14, 50, 680, 250, 3.0,
 'Pastry dough, mushrooms, Swiss chard, gruyere cheese, ricotta, thyme, garlic, egg',
 2, 'Contains dairy, gluten, and egg', TRUE, 'Meal'),

('Vegetable Tikka Masala', 450, 14, 40, 10, 8, 26, 14, 10, 30, 620, 150, 3.5,
 'Mixed vegetables, yogurt, tomatoes, cream, onion, garlic, ginger, garam masala, coriander',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Three Cheese Stuffed Shells', 580, 25, 60, 6, 4, 28, 16, 10, 60, 750, 500, 2.5,
 'Jumbo pasta shells, ricotta cheese, mozzarella, parmesan, marinara sauce, basil, garlic',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Vegetable and Halloumi Skewers', 380, 18, 20, 8, 5, 26, 12, 12, 50, 620, 300, 2.0,
 'Halloumi cheese, bell peppers, zucchini, cherry tomatoes, red onion, olive oil, herbs',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Spinach and Feta Stuffed Mushrooms', 320, 15, 12, 3, 3, 24, 10, 12, 40, 580, 250, 2.0,
 'Portobello mushrooms, spinach, feta cheese, cream cheese, breadcrumbs, garlic, herbs',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Walnut and Lentil Bolognese', 450, 18, 55, 8, 12, 18, 3, 13, 0, 680, 100, 5.0,
 'Lentils, walnuts, carrots, celery, onion, garlic, tomatoes, red wine, pasta, herbs',
 2, 'Contains nuts and gluten', TRUE, 'Meal'),

('Broccoli and Cheddar Stuffed Potatoes', 420, 16, 45, 4, 6, 20, 10, 8, 40, 580, 300, 2.5,
 'Potatoes, broccoli, cheddar cheese, sour cream, butter, chives, garlic',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Zucchini Noodles with Pesto', 350, 12, 15, 6, 4, 28, 6, 20, 20, 420, 150, 2.0,
 'Zucchini, basil, pine nuts, parmesan cheese, garlic, olive oil, cherry tomatoes, lemon zest',
 2, 'Contains dairy and nuts, gluten-free', TRUE, 'Meal'),

('Creamy Mushroom Pasta', 520, 16, 65, 4, 5, 24, 12, 10, 50, 620, 180, 3.0,
 'Pasta, mushrooms, cream, parmesan cheese, garlic, thyme, white wine, butter, parsley',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Vegetable Moussaka', 480, 16, 35, 10, 9, 30, 14, 14, 80, 680, 220, 3.0,
 'Eggplant, potatoes, zucchini, lentils, tomatoes, onion, béchamel sauce, cinnamon, nutmeg',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Caprese Stuffed Avocados', 350, 12, 15, 3, 8, 28, 8, 18, 30, 420, 200, 2.0,
 'Avocados, cherry tomatoes, mozzarella balls, basil, balsamic glaze, olive oil, salt',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Mediterranean Flatbread', 480, 18, 50, 5, 3, 22, 8, 12, 40, 680, 250, 2.5,
 'Flatbread, hummus, feta cheese, olives, cherry tomatoes, cucumber, red onion, herbs',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Pumpkin and Sage Risotto', 520, 12, 75, 6, 5, 18, 10, 6, 30, 720, 150, 2.5,
 'Arborio rice, pumpkin, sage, vegetable broth, white wine, parmesan cheese, butter, onion',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Black Bean and Corn Quesadillas', 480, 18, 55, 5, 10, 20, 10, 8, 40, 680, 300, 3.0,
 'Flour tortillas, black beans, corn, bell peppers, onion, cheddar cheese, avocado, salsa',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Eggplant and Ricotta Involtini', 420, 18, 25, 10, 6, 28, 12, 14, 50, 580, 300, 2.5,
 'Eggplant, ricotta cheese, mozzarella, marinara sauce, basil, garlic, olive oil, parmesan',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Spinach and Cheese Stuffed Portobello Mushrooms', 380, 18, 15, 3, 5, 26, 12, 12, 45, 550, 280, 2.0,
 'Portobello mushrooms, spinach, ricotta cheese, mozzarella, parmesan, garlic, herbs',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Asparagus and Gruyere Tart', 480, 16, 35, 4, 4, 32, 16, 14, 50, 620, 250, 2.5,
 'Puff pastry, asparagus, gruyere cheese, eggs, cream, thyme, lemon zest',
 2, 'Contains dairy, gluten, and eggs', TRUE, 'Meal'),

('Vegetable and Feta Fritters', 380, 14, 30, 5, 4, 24, 10, 12, 80, 580, 220, 2.0,
 'Zucchini, carrots, feta cheese, flour, eggs, dill, mint, yogurt sauce',
 2, 'Contains dairy, gluten, and eggs', TRUE, 'Meal'),

('Stuffed Butternut Squash', 420, 15, 60, 15, 10, 14, 5, 8, 20, 480, 150, 4.0,
 'Butternut squash, quinoa, cranberries, pecans, blue cheese, kale, maple syrup',
 2, 'Contains dairy and nuts, gluten-free', TRUE, 'Meal'),

('Three Bean Chili with Cornbread', 520, 20, 70, 12, 18, 16, 5, 9, 40, 680, 150, 6.0,
 'Kidney beans, black beans, pinto beans, tomatoes, bell peppers, corn, onion, cornmeal, milk, eggs',
 2, 'Contains dairy, gluten, and eggs', TRUE, 'Meal'),

('Crispy Eggplant Parmesan', 520, 20, 40, 8, 6, 30, 12, 16, 50, 720, 350, 3.0,
 'Eggplant, breadcrumbs, parmesan cheese, mozzarella, eggs, marinara sauce, basil, garlic',
 2, 'Contains dairy, gluten, and eggs', TRUE, 'Meal'),

('Stuffed Bell Peppers with Quinoa', 380, 15, 50, 8, 8, 16, 6, 8, 20, 520, 120, 4.0,
 'Bell peppers, quinoa, black beans, corn, tomatoes, feta cheese, cilantro, cumin',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Wild Mushroom Risotto', 520, 12, 70, 3, 4, 22, 10, 10, 25, 680, 120, 2.5,
 'Arborio rice, wild mushrooms, vegetable broth, white wine, parmesan cheese, thyme, butter',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Goat Cheese and Caramelized Onion Tart', 520, 14, 40, 8, 3, 32, 16, 14, 50, 620, 180, 2.5,
 'Pie crust, goat cheese, caramelized onions, eggs, cream, thyme, honey, balsamic glaze',
 2, 'Contains dairy, gluten, and eggs', TRUE, 'Meal'),

('Stuffed Cabbage Rolls', 420, 16, 45, 10, 8, 18, 6, 10, 30, 580, 150, 3.5,
 'Cabbage, rice, lentils, mushrooms, onion, carrots, tomato sauce, dill, paprika',
 2, 'Vegan-adaptable, gluten-free', TRUE, 'Meal'),

('Cherry Tomato and Goat Cheese Clafoutis', 450, 18, 25, 6, 3, 30, 16, 12, 250, 580, 200, 2.0,
 'Cherry tomatoes, goat cheese, eggs, milk, cream, flour, basil, thyme',
 2, 'Contains dairy, gluten, and eggs', TRUE, 'Meal'),

('Spinach and Artichoke Stuffed Shells', 580, 24, 60, 6, 5, 28, 14, 12, 60, 750, 400, 3.0,
 'Jumbo pasta shells, spinach, artichoke hearts, ricotta cheese, mozzarella, parmesan, garlic',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Feta and Spinach Borek', 480, 16, 45, 3, 3, 26, 12, 12, 80, 650, 300, 3.0,
 'Phyllo pastry, spinach, feta cheese, eggs, dill, green onions, olive oil',
 2, 'Contains dairy, gluten, and eggs', TRUE, 'Meal'),

('Mushroom and Leek Pie', 520, 14, 45, 5, 4, 32, 16, 14, 50, 680, 150, 3.0,
 'Pie crust, mushrooms, leeks, thyme, cream, eggs, parmesan cheese, butter',
 2, 'Contains dairy, gluten, and eggs', TRUE, 'Meal'),

('Stuffed Zucchini Boats', 380, 16, 25, 8, 5, 24, 10, 12, 40, 580, 220, 2.5,
 'Zucchini, quinoa, cherry tomatoes, feta cheese, pine nuts, basil, garlic, olive oil',
 2, 'Contains dairy and nuts, gluten-free', TRUE, 'Meal'),

('Vegetable Tagine with Couscous', 420, 12, 65, 15, 10, 12, 2, 9, 0, 520, 100, 4.0,
 'Couscous, chickpeas, carrots, butternut squash, tomatoes, apricots, zucchini, harissa, spices',
 2, 'Vegan-adaptable, contains gluten', TRUE, 'Meal'),

('Cauliflower and Broccoli Cheese Bake', 450, 18, 25, 6, 8, 30, 16, 12, 60, 650, 350, 2.5,
 'Cauliflower, broccoli, cheddar cheese, milk, flour, butter, breadcrumbs, mustard',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Feta and Tomato Galette', 520, 16, 45, 5, 3, 32, 16, 14, 50, 600, 200, 2.5,
 'Pastry dough, feta cheese, cherry tomatoes, thyme, olives, honey, egg',
 2, 'Contains dairy, gluten, and egg', TRUE, 'Meal'),

('Ricotta and Spinach Stuffed Pasta Shells', 580, 24, 60, 6, 5, 28, 14, 12, 60, 750, 400, 3.0,
 'Jumbo pasta shells, ricotta cheese, spinach, mozzarella, parmesan, marinara sauce, basil',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Vegetable Curry with Paneer', 480, 20, 35, 10, 8, 28, 14, 12, 50, 620, 350, 3.5,
 'Paneer, mixed vegetables, tomatoes, onion, garlic, ginger, curry spices, cream, cilantro',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Eggplant and Halloumi Stacks', 420, 18, 20, 8, 5, 30, 14, 14, 50, 580, 300, 2.0,
 'Eggplant, halloumi cheese, tomatoes, basil, balsamic glaze, olive oil',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Mushroom and Barley Risotto', 450, 14, 70, 3, 10, 12, 4, 6, 15, 580, 80, 4.0,
 'Pearl barley, mushrooms, vegetable broth, white wine, parmesan cheese, thyme, garlic',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Zucchini Fritters with Tzatziki', 380, 14, 30, 4, 4, 24, 8, 14, 80, 550, 180, 2.0,
 'Zucchini, flour, eggs, feta cheese, dill, yogurt, cucumber, garlic, mint',
 2, 'Contains dairy, gluten, and eggs', TRUE, 'Meal'),

('Sweet Potato and Black Bean Burgers', 420, 15, 60, 8, 12, 16, 3, 11, 10, 580, 100, 4.0,
 'Sweet potatoes, black beans, quinoa, red onion, cilantro, cumin, egg, breadcrumbs',
 2, 'Contains gluten and egg', TRUE, 'Meal'),

('Spinach and Ricotta Crespelle', 520, 20, 45, 5, 3, 30, 15, 13, 200, 620, 350, 3.0,
 'Crepes, ricotta cheese, spinach, parmesan, eggs, milk, flour, marinara sauce',
 2, 'Contains dairy, gluten, and eggs', TRUE, 'Meal'),

('Mediterranean Stuffed Portobello Mushrooms', 380, 16, 20, 5, 5, 26, 10, 14, 40, 580, 250, 2.5,
 'Portobello mushrooms, quinoa, spinach, feta cheese, sun-dried tomatoes, olives, garlic',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Broccoli and Cheese Baked Potatoes', 420, 16, 50, 4, 6, 18, 9, 7, 40, 550, 300, 2.5,
 'Potatoes, broccoli, cheddar cheese, sour cream, butter, chives, garlic',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Pesto and Ricotta Lasagna', 580, 25, 60, 8, 4, 30, 15, 13, 60, 720, 400, 3.0,
 'Lasagna noodles, ricotta cheese, basil pesto, mozzarella, spinach, parmesan',
 2, 'Contains dairy, gluten, and nuts', TRUE, 'Meal'),

('Greek Stuffed Tomatoes', 380, 14, 40, 12, 5, 18, 6, 10, 20, 550, 120, 2.5,
 'Tomatoes, rice, feta cheese, pine nuts, olives, mint, dill, olive oil',
 2, 'Contains dairy and nuts, gluten-free', TRUE, 'Meal'),

('Caramelized Onion and Goat Cheese Quiche', 520, 18, 35, 5, 2, 35, 18, 15, 220, 650, 250, 2.5,
 'Pie crust, eggs, goat cheese, caramelized onions, cream, thyme',
 2, 'Contains dairy, gluten, and eggs', TRUE, 'Meal'),

('Butternut Squash and Sage Lasagna', 550, 22, 65, 12, 6, 25, 12, 11, 50, 680, 350, 3.0,
 'Lasagna noodles, butternut squash, ricotta cheese, sage, béchamel sauce, parmesan',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Roasted Vegetable and Halloumi Salad', 380, 16, 20, 8, 5, 28, 12, 14, 50, 480, 300, 2.5,
 'Halloumi cheese, roasted vegetables, mixed greens, pine nuts, balsamic vinaigrette',
 2, 'Contains dairy and nuts, gluten-free', TRUE, 'Meal'),

('Spinach and Artichoke Lasagna', 580, 25, 60, 8, 6, 28, 14, 12, 60, 720, 400, 3.0,
 'Lasagna noodles, spinach, artichoke hearts, ricotta cheese, mozzarella, parmesan',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Vegetable and Bean Enchiladas', 480, 18, 65, 10, 12, 18, 8, 8, 30, 720, 300, 4.0,
 'Corn tortillas, black beans, bell peppers, corn, onion, enchilada sauce, cheese, cilantro',
 2, 'Contains dairy', TRUE, 'Meal'),

('Butternut Squash and Goat Cheese Tart', 520, 16, 45, 10, 5, 30, 15, 13, 50, 620, 200, 2.5,
 'Puff pastry, butternut squash, goat cheese, sage, honey, walnuts, egg',
 2, 'Contains dairy, gluten, nuts, and egg', TRUE, 'Meal'),

('Mushroom and Spinach Strudel', 480, 16, 40, 3, 4, 30, 15, 13, 50, 580, 200, 3.0,
 'Phyllo pastry, mushrooms, spinach, ricotta cheese, feta cheese, garlic, thyme, egg',
 2, 'Contains dairy, gluten, and egg', TRUE, 'Meal'),

('Baked Feta and Cherry Tomato Pasta', 520, 18, 65, 8, 4, 22, 10, 10, 50, 750, 300, 2.5,
 'Pasta, feta cheese, cherry tomatoes, garlic, olive oil, basil, red pepper flakes',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Stuffed Poblano Peppers', 420, 15, 40, 6, 8, 22, 10, 10, 40, 580, 250, 3.0,
 'Poblano peppers, rice, black beans, corn, cheese, tomatoes, cilantro, lime, cumin',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Wild Mushroom and Truffle Risotto', 550, 12, 75, 3, 4, 24, 12, 10, 25, 680, 150, 2.5,
 'Arborio rice, wild mushrooms, truffle oil, vegetable broth, white wine, parmesan, butter',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Leek and Gruyere Tart', 520, 16, 40, 4, 3, 34, 18, 14, 50, 650, 300, 2.5,
 'Pastry dough, leeks, gruyere cheese, eggs, cream, nutmeg, thyme',
 2, 'Contains dairy, gluten, and eggs', TRUE, 'Meal'),

('Stuffed Tomatoes with Herbed Rice', 350, 12, 45, 8, 5, 16, 6, 8, 20, 520, 100, 2.5,
 'Tomatoes, rice, feta cheese, olives, parsley, dill, mint, olive oil, lemon zest',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Fig and Goat Cheese Flatbread', 480, 14, 55, 15, 4, 22, 10, 10, 30, 620, 200, 2.5,
 'Flatbread, goat cheese, figs, honey, arugula, balsamic glaze, walnuts',
 2, 'Contains dairy, gluten, and nuts', TRUE, 'Meal'),

('Spinach and Feta Pastry Triangles', 480, 16, 40, 3, 3, 30, 15, 13, 50, 650, 250, 2.5,
 'Phyllo pastry, spinach, feta cheese, eggs, dill, green onions, nutmeg',
 2, 'Contains dairy, gluten, and eggs', TRUE, 'Meal'),

('Moroccan Vegetable Tagine', 420, 12, 60, 15, 12, 14, 2, 10, 0, 580, 100, 4.0,
 'Chickpeas, sweet potatoes, carrots, zucchini, tomatoes, apricots, couscous, harissa, spices',
 2, 'Vegan-adaptable, contains gluten', TRUE, 'Meal'),

('Ricotta and Asparagus Tart', 480, 16, 35, 4, 4, 32, 16, 14, 50, 600, 250, 2.5,
 'Puff pastry, ricotta cheese, asparagus, parmesan, eggs, lemon zest, thyme',
 2, 'Contains dairy, gluten, and eggs', TRUE, 'Meal'),

('Quinoa Stuffed Tomatoes', 350, 14, 45, 8, 6, 16, 5, 9, 20, 520, 120, 3.0,
 'Tomatoes, quinoa, feta cheese, olives, spinach, pine nuts, basil, olive oil',
 2, 'Contains dairy and nuts, gluten-free', TRUE, 'Meal'),

('Curried Cauliflower and Chickpea Bake', 420, 14, 45, 8, 10, 20, 6, 12, 20, 580, 120, 4.0,
 'Cauliflower, chickpeas, tomatoes, onion, garlic, ginger, curry powder, yogurt, cilantro',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Creamy Garlic Mushroom Pasta', 520, 16, 65, 4, 5, 24, 12, 10, 50, 620, 180, 3.0,
 'Pasta, mushrooms, cream, garlic, parmesan cheese, parsley, butter, white wine',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),

('Mediterranean Quinoa Stuffed Peppers', 380, 15, 45, 8, 8, 18, 6, 10, 20, 520, 120, 3.5,
 'Bell peppers, quinoa, feta cheese, olives, sun-dried tomatoes, spinach, herbs',
 2, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Chickpea and Vegetable Tagine', 420, 14, 60, 15, 12, 14, 2, 10, 0, 580, 100, 4.5,
 'Chickpeas, carrots, zucchini, bell peppers, tomatoes, apricots, couscous, harissa, spices',
 2, 'Vegan-adaptable, contains gluten', TRUE, 'Meal'),

('Spinach and Ricotta Stuffed Pasta Shells', 580, 24, 60, 6, 5, 28, 14, 12, 60, 750, 400, 3.0,
 'Jumbo pasta shells, ricotta cheese, spinach, mozzarella, parmesan, marinara sauce, basil',
 2, 'Contains dairy and gluten', TRUE, 'Meal');


-- Vegan meals (CategoryID = 3)

INSERT INTO meals (
  MealName, Calories_cal, Protein_g, Carbs_g, Sugars_g, Fibers_g, 
  Fat_g, SatFat_g, UnsatFat_g, Cholesterol_mg, Sodium_mg, Calcium_mg, Iron_mg, 
  Ingredients, CategoryID, DietNotes, IsHomeCooked, IsMealorSnack
) VALUES
('Spicy Chickpea Buddha Bowl', 450, 18, 60, 8, 12, 16, 2, 12, 0, 420, 120, 5.5, 
 'Chickpeas, quinoa, sweet potato, kale, tahini, lemon juice, maple syrup, paprika, cumin, olive oil', 
 3, 'Contains sesame', TRUE, 'Meal'),
 
('Lentil Shepherds Pie', 420, 16, 65, 10, 14, 10, 1, 8, 0, 480, 90, 6.0, 
 'Green lentils, potatoes, carrots, peas, onion, garlic, tomato paste, thyme, rosemary, olive oil', 
 3, 'No common allergens', TRUE, 'Meal'),

('Mushroom Walnut Bolognese', 520, 15, 70, 8, 8, 18, 2, 14, 0, 540, 80, 4.5, 
 'Whole wheat spaghetti, mushrooms, walnuts, tomatoes, onion, garlic, basil, oregano, nutritional yeast, olive oil', 
 3, 'Contains gluten and nuts', TRUE, 'Meal'),

('Coconut Chickpea Curry', 480, 14, 55, 12, 10, 22, 16, 4, 0, 620, 110, 5.0, 
 'Chickpeas, coconut milk, tomatoes, spinach, onion, garlic, ginger, curry powder, cumin, coriander, brown rice', 
 3, 'No common allergens', TRUE, 'Meal'),

('Stuffed Bell Peppers with Quinoa', 390, 12, 50, 9, 8, 16, 2, 12, 0, 380, 70, 4.0, 
 'Bell peppers, quinoa, black beans, corn, tomatoes, onion, garlic, chili powder, cumin, cilantro, lime juice', 
 3, 'No common allergens', TRUE, 'Meal'),

('Sesame Ginger Tofu Stir-Fry', 420, 20, 35, 7, 6, 22, 3, 17, 0, 720, 350, 5.5, 
 'Tofu, broccoli, snap peas, carrots, bell peppers, brown rice, ginger, garlic, soy sauce, sesame oil, sesame seeds', 
 3, 'Contains soy, sesame and gluten', TRUE, 'Meal'),

('Black Bean Sweet Potato Tacos', 460, 14, 70, 12, 14, 14, 2, 10, 0, 550, 150, 4.5, 
 'Black beans, sweet potatoes, corn tortillas, avocado, lime juice, red onion, cilantro, cumin, paprika', 
 3, 'Contains gluten', TRUE, 'Meal'),

('Mediterranean Falafel Bowl', 520, 16, 60, 6, 12, 24, 3, 19, 0, 580, 130, 5.0, 
 'Chickpeas, parsley, cilantro, garlic, cumin, coriander, quinoa, tomatoes, cucumber, tahini, lemon juice', 
 3, 'Contains sesame', TRUE, 'Meal'),

('Creamy Cashew Vegetable Pasta', 550, 15, 75, 8, 9, 20, 4, 14, 0, 450, 80, 4.0, 
 'Whole wheat pasta, cashews, nutritional yeast, lemon juice, garlic, broccoli, spinach, cherry tomatoes, basil', 
 3, 'Contains gluten and nuts', TRUE, 'Meal'),

('Spicy Peanut Tofu Noodles', 580, 22, 68, 10, 8, 24, 4, 18, 0, 750, 160, 5.0, 
 'Tofu, rice noodles, carrots, cabbage, green onions, peanut butter, soy sauce, lime juice, chili flakes, garlic', 
 3, 'Contains gluten, soy, and peanuts', TRUE, 'Meal'),

('Lentil Walnut Burgers', 420, 18, 40, 3, 10, 20, 2, 16, 0, 530, 90, 5.5, 
 'Green lentils, walnuts, flax seeds, onion, garlic, breadcrumbs, smoked paprika, cumin, lettuce, tomato, whole grain buns', 
 3, 'Contains gluten and nuts', TRUE, 'Meal'),

('Moroccan Vegetable Tagine', 380, 10, 60, 15, 12, 12, 1, 10, 0, 480, 120, 4.0, 
 'Chickpeas, sweet potatoes, carrots, bell peppers, tomatoes, onions, garlic, ginger, cinnamon, cumin, apricots, couscous', 
 3, 'Contains gluten', TRUE, 'Meal'),

('Sweet and Sour Tempeh Stir-Fry', 450, 22, 55, 14, 7, 15, 2, 11, 0, 680, 150, 6.0, 
 'Tempeh, pineapple, bell peppers, onion, carrots, brown rice, garlic, ginger, soy sauce, rice vinegar, maple syrup', 
 3, 'Contains soy and gluten', TRUE, 'Meal'),

('Roasted Vegetable Quinoa Salad', 380, 12, 50, 8, 9, 16, 2, 12, 0, 320, 70, 4.5, 
 'Quinoa, zucchini, bell peppers, eggplant, cherry tomatoes, red onion, garlic, balsamic vinegar, olive oil, basil', 
 3, 'No common allergens', TRUE, 'Meal'),

('Mexican Black Bean Soup', 320, 14, 50, 6, 15, 8, 1, 6, 0, 510, 100, 5.0, 
 'Black beans, tomatoes, onion, bell peppers, corn, garlic, cumin, chili powder, lime juice, cilantro', 
 3, 'No common allergens', TRUE, 'Meal'),

('Jackfruit Pulled "Pork" Sandwich', 480, 8, 75, 15, 8, 14, 2, 10, 0, 620, 80, 3.0, 
 'Jackfruit, whole grain buns, barbecue sauce, maple syrup, apple cider vinegar, paprika, onion, garlic, coleslaw', 
 3, 'Contains gluten', TRUE, 'Meal'),

('Mushroom Risotto with Peas', 550, 12, 80, 5, 6, 18, 3, 13, 0, 490, 60, 3.5, 
 'Arborio rice, mushrooms, peas, onion, garlic, white wine, vegetable stock, nutritional yeast, thyme, olive oil', 
 3, 'No common allergens', TRUE, 'Meal'),

('Cauliflower Buffalo "Wings"', 320, 8, 25, 4, 6, 22, 3, 17, 0, 650, 80, 2.5, 
 'Cauliflower, flour, plant milk, garlic powder, buffalo sauce, maple syrup, breadcrumbs, celery, vegan ranch dressing', 
 3, 'Contains gluten', TRUE, 'Meal'),

('Thai Green Curry with Vegetables', 420, 10, 40, 8, 8, 25, 18, 5, 0, 580, 100, 4.0, 
 'Tofu, coconut milk, broccoli, snow peas, bell peppers, Thai green curry paste, lemongrass, lime leaves, basil, brown rice', 
 3, 'Contains soy', TRUE, 'Meal'),

('Spinach and Chickpea Stew', 350, 15, 45, 6, 11, 14, 2, 10, 0, 490, 150, 6.5, 
 'Chickpeas, spinach, tomatoes, onion, garlic, cumin, paprika, cinnamon, lemon juice, olive oil', 
 3, 'No common allergens', TRUE, 'Meal'),

('Eggplant and Lentil Moussaka', 420, 16, 50, 10, 12, 18, 3, 13, 0, 480, 120, 5.0, 
 'Eggplant, green lentils, tomatoes, onion, garlic, cinnamon, nutmeg, potatoes, olive oil, breadcrumbs', 
 3, 'Contains gluten', TRUE, 'Meal'),

('Sweet Potato Black Bean Enchiladas', 490, 14, 75, 12, 14, 15, 2, 11, 0, 580, 140, 5.0, 
 'Sweet potatoes, black beans, corn tortillas, tomato sauce, onion, garlic, cumin, chili powder, cilantro, avocado', 
 3, 'Contains gluten', TRUE, 'Meal'),

('Maple Glazed Brussels Sprout Bowl', 420, 12, 60, 16, 10, 16, 2, 12, 0, 380, 100, 4.5, 
 'Brussels sprouts, quinoa, cranberries, pecans, maple syrup, balsamic vinegar, garlic, thyme, olive oil', 
 3, 'Contains nuts', TRUE, 'Meal'),

('Smoky Split Pea Soup', 320, 16, 50, 8, 15, 6, 1, 4, 0, 540, 80, 5.0, 
 'Split peas, carrots, celery, onion, garlic, smoked paprika, thyme, bay leaves, vegetable stock, olive oil', 
 3, 'No common allergens', TRUE, 'Meal'),

('Zucchini Noodles with Avocado Pesto', 350, 8, 20, 5, 8, 28, 4, 22, 0, 290, 60, 3.0, 
 'Zucchini, avocado, basil, pine nuts, garlic, lemon juice, nutritional yeast, olive oil, cherry tomatoes', 
 3, 'Contains nuts', TRUE, 'Meal'),

('Red Lentil Dal with Spinach', 380, 18, 55, 5, 12, 10, 1, 8, 0, 420, 90, 6.0, 
 'Red lentils, spinach, tomatoes, onion, garlic, ginger, turmeric, cumin, coriander, lemon juice, brown rice', 
 3, 'No common allergens', TRUE, 'Meal'),

('Portobello Mushroom Fajitas', 380, 10, 45, 8, 8, 18, 2, 14, 0, 480, 60, 3.5, 
 'Portobello mushrooms, bell peppers, onions, whole wheat tortillas, lime juice, garlic, cumin, paprika, avocado, cilantro', 
 3, 'Contains gluten', TRUE, 'Meal'),

('Chickpea "Tuna" Salad Sandwich', 420, 15, 55, 6, 10, 16, 2, 12, 0, 550, 120, 4.0, 
 'Chickpeas, celery, red onion, whole grain bread, vegan mayo, mustard, dill, nori sheets, lemon juice', 
 3, 'Contains gluten', TRUE, 'Meal'),

('Tempeh Chili with Cornbread', 520, 25, 65, 9, 14, 16, 2, 12, 0, 620, 150, 7.0, 
 'Tempeh, kidney beans, tomatoes, bell peppers, onion, garlic, chili powder, cumin, cornmeal, plant milk, maple syrup', 
 3, 'Contains soy and gluten', TRUE, 'Meal'),

('Stuffed Acorn Squash with Wild Rice', 420, 10, 65, 12, 10, 14, 2, 10, 0, 320, 80, 4.0, 
 'Acorn squash, wild rice, cranberries, pecans, onion, celery, thyme, sage, maple syrup, olive oil', 
 3, 'Contains nuts', TRUE, 'Meal'),

('Tofu Vegetable Pot Pie', 480, 16, 60, 8, 8, 20, 3, 15, 0, 580, 120, 4.5, 
 'Tofu, carrots, peas, corn, celery, onion, plant milk, flour, thyme, rosemary, vegan pie crust', 
 3, 'Contains soy and gluten', TRUE, 'Meal'),

('Baked Falafel Salad with Tahini Dressing', 420, 15, 45, 5, 12, 22, 3, 17, 0, 480, 150, 5.0, 
 'Chickpeas, parsley, cilantro, garlic, cumin, mixed greens, tomatoes, cucumber, tahini, lemon juice, olive oil', 
 3, 'Contains sesame', TRUE, 'Meal'),

('Roasted Cauliflower Tikka Masala', 380, 12, 40, 8, 8, 20, 14, 4, 0, 550, 120, 4.5, 
 'Cauliflower, chickpeas, tomatoes, coconut milk, onion, garlic, ginger, garam masala, cumin, coriander, brown rice', 
 3, 'No common allergens', TRUE, 'Meal'),

('Peanut Noodle Salad with Edamame', 520, 18, 70, 10, 9, 20, 3, 15, 0, 620, 100, 5.0, 
 'Rice noodles, edamame, carrots, bell peppers, cabbage, peanut butter, soy sauce, lime juice, maple syrup, garlic, ginger', 
 3, 'Contains soy, gluten and peanuts', TRUE, 'Meal'),

('White Bean and Kale Soup', 320, 14, 45, 5, 10, 8, 1, 6, 0, 490, 180, 6.0, 
 'White beans, kale, carrots, celery, onion, garlic, rosemary, thyme, vegetable stock, lemon juice, olive oil', 
 3, 'No common allergens', TRUE, 'Meal'),

('Buffalo Cauliflower Wrap', 420, 12, 55, 6, 8, 18, 2, 14, 0, 650, 120, 4.0, 
 'Cauliflower, buffalo sauce, whole wheat wrap, lettuce, tomato, red onion, vegan ranch dressing, celery, carrots', 
 3, 'Contains gluten', TRUE, 'Meal'),

('Chickpea Flour Vegetable Frittata', 350, 16, 30, 4, 8, 20, 3, 15, 0, 390, 80, 4.5, 
 'Chickpea flour, nutritional yeast, bell peppers, spinach, onion, tomatoes, garlic, turmeric, black salt, olive oil', 
 3, 'No common allergens', TRUE, 'Meal'),

('Sweet and Sour Tofu with Pineapple', 450, 18, 60, 15, 6, 15, 2, 11, 0, 580, 350, 5.0, 
 'Tofu, pineapple, bell peppers, onion, carrots, brown rice, garlic, ginger, tomato paste, rice vinegar, maple syrup', 
 3, 'Contains soy', TRUE, 'Meal'),

('Mushroom and Walnut Pâté', 320, 10, 15, 2, 4, 28, 3, 23, 0, 380, 60, 2.5, 
 'Mushrooms, walnuts, onion, garlic, thyme, rosemary, tamari, nutritional yeast, whole grain crackers', 
 3, 'Contains nuts and gluten', TRUE, 'Meal'),

('Quinoa Stuffed Tomatoes', 320, 12, 45, 8, 8, 14, 2, 10, 0, 420, 80, 4.0, 
 'Tomatoes, quinoa, spinach, pine nuts, basil, garlic, nutritional yeast, olive oil, balsamic glaze', 
 3, 'Contains nuts', TRUE, 'Meal'),

('Chickpea and Vegetable Biryani', 480, 15, 75, 8, 10, 12, 1, 9, 0, 520, 90, 5.0, 
 'Chickpeas, basmati rice, carrots, peas, cauliflower, onion, garlic, ginger, turmeric, cardamom, cinnamon, coriander', 
 3, 'No common allergens', TRUE, 'Meal'),

('Smoky Bean and Potato Stew', 380, 16, 60, 6, 14, 8, 1, 6, 0, 540, 100, 5.5, 
 'Pinto beans, potatoes, carrots, celery, tomatoes, onion, garlic, smoked paprika, thyme, bay leaves, olive oil', 
 3, 'No common allergens', TRUE, 'Meal'),

('Teriyaki Tofu Rice Bowl', 450, 18, 65, 12, 6, 12, 2, 9, 0, 720, 350, 4.5, 
 'Tofu, brown rice, broccoli, carrots, edamame, soy sauce, rice vinegar, garlic, ginger, maple syrup, sesame seeds', 
 3, 'Contains soy, sesame and gluten', TRUE, 'Meal'),

('Quinoa Tabbouleh Salad', 350, 10, 45, 5, 8, 16, 2, 12, 0, 320, 80, 4.0, 
 'Quinoa, parsley, mint, tomatoes, cucumber, red onion, lemon juice, olive oil, garlic, salt, pepper', 
 3, 'No common allergens', TRUE, 'Meal'),

('Lentil and Mushroom Bolognese', 480, 18, 70, 9, 12, 12, 1, 9, 0, 520, 90, 6.0, 
 'Brown lentils, mushrooms, carrots, celery, onion, garlic, tomatoes, red wine, herbs, whole wheat pasta', 
 3, 'Contains gluten', TRUE, 'Meal'),

('Coconut Curried Vegetables', 420, 10, 50, 12, 10, 20, 15, 3, 0, 550, 100, 4.5, 
 'Cauliflower, sweet potatoes, peas, spinach, coconut milk, curry powder, turmeric, ginger, garlic, brown rice', 
 3, 'No common allergens', TRUE, 'Meal'),

('Loaded Sweet Potato with Black Beans', 390, 12, 60, 14, 12, 10, 1, 8, 0, 420, 80, 4.0, 
 'Sweet potatoes, black beans, corn, avocado, lime juice, cilantro, cumin, paprika, green onions', 
 3, 'No common allergens', TRUE, 'Meal'),

('Vegetable Paella with Artichokes', 450, 12, 70, 5, 8, 14, 2, 10, 0, 480, 60, 4.0, 
 'Rice, artichoke hearts, bell peppers, tomatoes, peas, saffron, paprika, garlic, onion, vegetable stock, olive oil', 
 3, 'No common allergens', TRUE, 'Meal'),

('Mushroom and Lentil Pies', 480, 16, 55, 6, 10, 20, 3, 15, 0, 580, 80, 5.0, 
 'Brown lentils, mushrooms, carrots, onions, garlic, thyme, rosemary, tomato paste, vegan pastry, olive oil', 
 3, 'Contains gluten', TRUE, 'Meal'),

('Butternut Squash and Chickpea Tagine', 380, 12, 60, 14, 12, 10, 1, 8, 0, 450, 120, 5.0, 
 'Butternut squash, chickpeas, tomatoes, onion, garlic, ginger, cinnamon, cumin, harissa, apricots, couscous', 
 3, 'Contains gluten', TRUE, 'Meal'),

('Black Bean and Corn Quesadillas', 420, 14, 60, 5, 10, 16, 2, 12, 0, 580, 80, 3.5, 
 'Black beans, corn, whole wheat tortillas, bell peppers, onion, garlic, cumin, nutritional yeast, avocado, salsa', 
 3, 'Contains gluten', TRUE, 'Meal'),

('Creamy Tomato and Red Lentil Soup', 320, 14, 45, 8, 9, 10, 1, 8, 0, 480, 70, 5.0, 
 'Red lentils, tomatoes, carrots, celery, onion, garlic, vegetable stock, coconut milk, basil, paprika', 
 3, 'No common allergens', TRUE, 'Meal'),

('Tofu and Vegetable Curry', 420, 20, 40, 8, 8, 22, 14, 6, 0, 550, 350, 6.0, 
 'Tofu, cauliflower, spinach, peas, tomatoes, coconut milk, curry powder, turmeric, ginger, garlic, brown rice', 
 3, 'Contains soy', TRUE, 'Meal'),

('Mediterranean Quinoa Stuffed Peppers', 380, 12, 50, 8, 9, 16, 2, 12, 0, 460, 80, 4.5, 
 'Bell peppers, quinoa, chickpeas, sun-dried tomatoes, spinach, olives, garlic, lemon juice, herbs, olive oil', 
 3, 'No common allergens', TRUE, 'Meal'),
  
('Roasted Vegetable Buddha Bowl', 450, 15, 60, 8, 12, 18, 2, 14, 0, 320, 120, 4.2,
 'Quinoa, sweet potato, chickpeas, kale, avocado, tahini, lemon juice, olive oil, nutritional yeast',
 3, 'Gluten-free', TRUE, 'Meal'),

('Black Bean Tacos', 380, 14, 50, 6, 10, 15, 2, 10, 0, 450, 150, 3.8,
 'Black beans, corn tortillas, avocado, tomato salsa, lime juice, cilantro, red onion, cumin',
 3, 'Gluten-free', TRUE, 'Meal'),

('Coconut Chickpea Curry', 520, 16, 65, 10, 12, 22, 14, 6, 0, 560, 120, 4.5,
 'Chickpeas, coconut milk, tomatoes, spinach, garlic, ginger, curry powder, onion, cilantro',
 3, 'Gluten-free', TRUE, 'Meal'),

('Lentil Bolognese', 420, 18, 70, 8, 14, 8, 1, 6, 0, 520, 80, 5.2,
 'Lentils, tomatoes, carrots, celery, onion, garlic, oregano, basil, nutritional yeast, whole grain pasta',
 3, 'Contains gluten', TRUE, 'Meal'),

('Mushroom Risotto', 480, 12, 75, 4, 6, 15, 2, 12, 0, 680, 40, 2.8,
 'Arborio rice, mushrooms, vegetable broth, white wine, onion, garlic, nutritional yeast, thyme, olive oil',
 3, 'Gluten-free', TRUE, 'Meal'),

('Sweet Potato & Chickpea Salad', 390, 12, 60, 12, 11, 14, 2, 10, 0, 410, 100, 3.6,
 'Sweet potato, chickpeas, spinach, tahini, lemon juice, olive oil, garlic, cumin, paprika',
 3, 'Gluten-free', TRUE, 'Meal'),

('Tofu Stir Fry', 380, 20, 35, 8, 8, 18, 3, 13, 0, 650, 250, 5.0,
 'Tofu, broccoli, bell peppers, carrots, snow peas, brown rice, garlic, ginger, soy sauce, sesame oil',
 3, 'Contains soy', TRUE, 'Meal'),

('Falafel Wrap', 520, 18, 70, 5, 12, 20, 3, 15, 0, 720, 120, 4.8,
 'Chickpeas, parsley, cilantro, garlic, cumin, whole wheat wrap, tahini sauce, tomatoes, lettuce, cucumber',
 3, 'Contains gluten', TRUE, 'Meal'),

('Quinoa Power Bowl', 450, 16, 65, 10, 14, 16, 2, 12, 0, 380, 100, 6.0,
 'Quinoa, roasted vegetables, edamame, avocado, kale, tahini dressing, pumpkin seeds, lemon juice',
 3, 'Contains soy, gluten-free', TRUE, 'Meal'),

('Red Lentil Dahl', 320, 18, 50, 6, 12, 8, 1, 6, 0, 480, 80, 4.5,
 'Red lentils, tomatoes, onion, garlic, ginger, curry powder, turmeric, coconut milk, cilantro',
 3, 'Gluten-free', TRUE, 'Meal'),

('Stuffed Bell Peppers', 340, 12, 55, 12, 8, 10, 1, 8, 0, 420, 60, 3.2,
 'Bell peppers, quinoa, black beans, corn, tomatoes, onion, garlic, cumin, chili powder, cilantro',
 3, 'Gluten-free', TRUE, 'Meal'),

('Mediterranean Couscous Bowl', 430, 14, 70, 8, 10, 12, 2, 9, 0, 550, 90, 3.5,
 'Couscous, chickpeas, cucumber, tomatoes, olives, red onion, parsley, mint, lemon juice, olive oil',
 3, 'Contains gluten', TRUE, 'Meal'),

('Portobello Mushroom Burger', 380, 10, 45, 6, 8, 18, 3, 14, 0, 650, 120, 2.8,
 'Portobello mushrooms, whole grain bun, lettuce, tomato, onion, avocado, mustard, vegan mayo',
 3, 'Contains gluten', TRUE, 'Meal'),

('Tempeh Taco Salad', 420, 22, 40, 8, 12, 20, 3, 15, 0, 580, 150, 4.2,
 'Tempeh, romaine lettuce, black beans, corn, tomatoes, avocado, tortilla chips, lime juice, cilantro',
 3, 'Contains soy', TRUE, 'Meal'),

('Vegetable Paella', 410, 12, 75, 6, 8, 8, 1, 6, 0, 560, 60, 3.6,
 'Arborio rice, bell peppers, artichokes, peas, tomatoes, onion, garlic, saffron, paprika, veggie broth',
 3, 'Gluten-free', TRUE, 'Meal'),

('Cauliflower Buffalo Wings', 280, 8, 30, 4, 6, 18, 2, 14, 0, 680, 40, 2.0,
 'Cauliflower, almond flour, garlic powder, onion powder, hot sauce, maple syrup, vegan butter',
 3, 'Gluten-free, contains nuts', TRUE, 'Meal'),

('Tofu Scramble', 320, 20, 20, 3, 5, 18, 3, 13, 0, 520, 300, 5.0,
 'Tofu, nutritional yeast, turmeric, onion, bell peppers, spinach, garlic, black salt, black pepper',
 3, 'Contains soy, gluten-free', TRUE, 'Meal'),

('Vegan Chili', 380, 16, 60, 12, 16, 8, 1, 6, 0, 620, 100, 6.5,
 'Kidney beans, black beans, tomatoes, bell peppers, onion, garlic, chili powder, cumin, oregano',
 3, 'Gluten-free', TRUE, 'Meal'),

('Kale & White Bean Soup', 290, 15, 45, 5, 10, 8, 1, 6, 0, 580, 150, 5.0,
 'Kale, white beans, carrots, celery, onion, garlic, vegetable broth, thyme, rosemary, olive oil',
 3, 'Gluten-free', TRUE, 'Meal'),

('Lentil Shepherds Pie', 450, 18, 70, 10, 14, 10, 1, 8, 0, 560, 80, 6.0,
 'Lentils, carrots, peas, corn, onion, garlic, tomato paste, mashed potatoes, thyme, rosemary',
 3, 'Gluten-free', TRUE, 'Meal'),

('Thai Green Curry', 450, 14, 45, 8, 10, 24, 18, 5, 0, 680, 100, 4.0,
 'Tofu, green curry paste, coconut milk, bamboo shoots, bell peppers, eggplant, basil, lime leaves, brown rice',
 3, 'Contains soy, gluten-free', TRUE, 'Meal'),

('Maple Glazed Brussels Sprouts', 320, 8, 40, 15, 8, 16, 2, 12, 0, 450, 80, 3.0,
 'Brussels sprouts, maple syrup, balsamic vinegar, pecans, cranberries, olive oil, garlic, thyme',
 3, 'Contains nuts, gluten-free', TRUE, 'Meal'),

('Moroccan Chickpea Stew', 380, 15, 55, 10, 12, 12, 1, 10, 0, 520, 150, 5.5,
 'Chickpeas, tomatoes, carrots, onion, garlic, ginger, cumin, cinnamon, paprika, cilantro, couscous',
 3, 'Contains gluten', TRUE, 'Meal'),

('Eggplant Rollatini', 410, 12, 35, 8, 10, 24, 3, 19, 0, 580, 100, 3.0,
 'Eggplant, tofu ricotta, spinach, nutritional yeast, marinara sauce, basil, garlic, olive oil',
 3, 'Contains soy, gluten-free', TRUE, 'Meal'),

('Black Bean & Sweet Potato Burgers', 380, 14, 58, 10, 12, 12, 1, 10, 0, 520, 80, 4.2,
 'Black beans, sweet potato, quinoa, onion, garlic, cumin, paprika, flaxseed, whole grain buns',
 3, 'Contains gluten', TRUE, 'Meal'),

('Pad Thai', 450, 15, 70, 15, 5, 12, 2, 9, 0, 850, 120, 3.5,
 'Rice noodles, tofu, bean sprouts, carrots, green onions, peanuts, tamarind paste, soy sauce, lime',
 3, 'Contains soy and nuts', TRUE, 'Meal'),

('Mushroom Stroganoff', 420, 12, 55, 4, 6, 18, 3, 14, 0, 580, 60, 3.2,
 'Mushrooms, garlic, onion, paprika, vegan sour cream, vegetable broth, thyme, whole grain pasta',
 3, 'Contains gluten', TRUE, 'Meal'),

('Chickpea & Spinach Curry', 380, 16, 50, 8, 10, 15, 10, 4, 0, 520, 150, 5.0,
 'Chickpeas, spinach, tomatoes, onion, garlic, ginger, coconut milk, curry powder, turmeric, cumin, rice',
 3, 'Gluten-free', TRUE, 'Meal'),

('Vegetable Lasagna', 450, 16, 60, 10, 8, 15, 2, 12, 0, 620, 120, 4.0,
 'Lasagna noodles, tofu ricotta, zucchini, spinach, mushrooms, marinara sauce, nutritional yeast, basil',
 3, 'Contains soy and gluten', TRUE, 'Meal'),

('Miso Ramen', 380, 14, 60, 5, 6, 8, 1, 6, 0, 820, 100, 3.5,
 'Ramen noodles, tofu, miso paste, mushrooms, bok choy, carrots, green onions, seaweed, sesame oil',
 3, 'Contains soy and gluten', TRUE, 'Meal'),

('BBQ Jackfruit Sandwich', 350, 8, 55, 20, 7, 8, 1, 6, 0, 680, 60, 2.5,
 'Jackfruit, BBQ sauce, whole grain bun, coleslaw, pickles, onion, vegan mayo',
 3, 'Contains gluten', TRUE, 'Meal'),

('Teriyaki Tempeh Bowl', 420, 20, 55, 18, 8, 12, 2, 9, 0, 850, 100, 4.0,
 'Tempeh, broccoli, carrots, snap peas, teriyaki sauce, ginger, garlic, brown rice, sesame seeds',
 3, 'Contains soy', TRUE, 'Meal'),

('Smoky Bean Burritos', 480, 18, 75, 6, 14, 12, 2, 9, 0, 750, 120, 5.0,
 'Pinto beans, black beans, brown rice, bell peppers, onion, garlic, chipotle, cumin, avocado, whole wheat tortilla',
 3, 'Contains gluten', TRUE, 'Meal'),

('Roasted Vegetable Penne', 450, 15, 75, 8, 8, 10, 1, 8, 0, 520, 80, 3.5,
 'Whole grain penne, zucchini, eggplant, bell peppers, cherry tomatoes, garlic, basil, olive oil, nutritional yeast',
 3, 'Contains gluten', TRUE, 'Meal'),

('Sweet & Sour Tofu', 380, 18, 50, 20, 4, 12, 2, 9, 0, 750, 150, 3.0,
 'Tofu, bell peppers, pineapple, onion, garlic, brown sugar, rice vinegar, tomato paste, soy sauce, rice',
 3, 'Contains soy', TRUE, 'Meal'),

('Farro Salad with Roasted Vegetables', 420, 14, 75, 10, 12, 10, 1, 8, 0, 480, 80, 4.2,
 'Farro, zucchini, bell peppers, cherry tomatoes, red onion, arugula, balsamic vinegar, olive oil, herbs',
 3, 'Contains gluten', TRUE, 'Meal'),

('Vegetable Biryani', 450, 12, 80, 5, 8, 10, 1, 8, 0, 520, 80, 3.5,
 'Basmati rice, mixed vegetables, onion, garlic, ginger, turmeric, cumin, coriander, cardamom, cinnamon',
 3, 'Gluten-free', TRUE, 'Meal'),

('Broccoli & Chickpea Stir Fry', 380, 18, 45, 6, 12, 14, 2, 11, 0, 620, 150, 5.0,
 'Broccoli, chickpeas, carrots, snow peas, garlic, ginger, soy sauce, rice vinegar, sesame oil, brown rice',
 3, 'Contains soy', TRUE, 'Meal'),

('Stuffed Butternut Squash', 420, 12, 65, 15, 10, 12, 2, 9, 0, 380, 120, 4.0,
 'Butternut squash, quinoa, cranberries, pecans, kale, onion, garlic, sage, maple syrup, olive oil',
 3, 'Contains nuts, gluten-free', TRUE, 'Meal'),

('Creamy Tomato Pasta', 450, 14, 70, 8, 6, 15, 2, 12, 0, 580, 100, 3.0,
 'Whole grain pasta, tomatoes, cashews, nutritional yeast, garlic, basil, onion, olive oil',
 3, 'Contains nuts and gluten', TRUE, 'Meal'),

('Roasted Cauliflower Tacos', 350, 10, 45, 5, 8, 16, 2, 12, 0, 480, 100, 3.2,
 'Cauliflower, corn tortillas, avocado, lime, cilantro, red cabbage, red onion, cumin, chili powder',
 3, 'Gluten-free', TRUE, 'Meal'),

('Three Bean Chili', 380, 18, 60, 8, 16, 6, 1, 4, 0, 580, 120, 6.0,
 'Kidney beans, black beans, pinto beans, tomatoes, bell pepper, onion, garlic, chili powder, cumin, oregano',
 3, 'Gluten-free', TRUE, 'Meal'),

('Sesame Soba Noodles', 420, 16, 65, 6, 5, 12, 2, 9, 0, 680, 80, 3.0,
 'Soba noodles, edamame, carrots, cucumber, green onion, sesame oil, rice vinegar, soy sauce, ginger',
 3, 'Contains soy and gluten', TRUE, 'Meal'),

('Chickpea Mediterranean Bowl', 450, 15, 55, 6, 12, 20, 3, 15, 0, 520, 120, 4.5,
 'Chickpeas, cucumber, tomatoes, red onion, kalamata olives, parsley, lemon juice, olive oil, tahini, quinoa',
 3, 'Gluten-free', TRUE, 'Meal'),

('Sweet Potato Black Bean Enchiladas', 480, 15, 70, 12, 14, 14, 2, 11, 0, 680, 150, 4.0,
 'Sweet potatoes, black beans, corn tortillas, enchilada sauce, avocado, cilantro, lime, cumin, chili powder',
 3, 'Gluten-free', TRUE, 'Meal'),

('Buffalo Cauliflower Wrap', 420, 12, 60, 6, 8, 16, 3, 12, 0, 750, 100, 3.5,
 'Cauliflower, hot sauce, whole wheat wrap, lettuce, tomato, red onion, avocado, vegan ranch',
 3, 'Contains gluten', TRUE, 'Meal'),

('Vegetable Pot Pie', 480, 10, 60, 8, 10, 22, 4, 16, 0, 620, 80, 3.0,
 'Carrots, peas, potatoes, celery, onion, vegetable broth, almond milk, vegan butter, flour, thyme, pie crust',
 3, 'Contains gluten', TRUE, 'Meal'),

('Spinach & Mushroom Stuffed Shells', 450, 16, 65, 6, 5, 12, 2, 9, 0, 580, 120, 4.0,
 'Pasta shells, tofu ricotta, spinach, mushrooms, nutritional yeast, marinara sauce, garlic, basil',
 3, 'Contains soy and gluten', TRUE, 'Meal'),

('Vegetable Tikka Masala', 420, 14, 55, 10, 12, 16, 12, 3, 0, 580, 120, 4.5,
 'Cauliflower, chickpeas, peas, tomatoes, coconut milk, onion, garlic, ginger, garam masala, turmeric, rice',
 3, 'Gluten-free', TRUE, 'Meal'),

('Roasted Vegetable & Hummus Wrap', 380, 14, 50, 6, 10, 15, 2, 12, 0, 520, 100, 3.5,
 'Whole wheat wrap, hummus, roasted zucchini, bell peppers, eggplant, spinach, red onion, tahini',
 3, 'Contains gluten', TRUE, 'Meal'),

('Peanut Noodle Salad', 450, 15, 65, 10, 8, 16, 3, 12, 0, 750, 100, 3.0,
 'Rice noodles, edamame, carrots, cucumber, red cabbage, peanut butter, lime juice, soy sauce, maple syrup, ginger',
 3, 'Contains soy and nuts', TRUE, 'Meal'),

('Stuffed Portobello Mushrooms', 350, 12, 35, 5, 8, 20, 3, 16, 0, 480, 80, 3.5,
 'Portobello mushrooms, quinoa, bell peppers, spinach, sun-dried tomatoes, garlic, thyme, nutritional yeast',
 3, 'Gluten-free', TRUE, 'Meal'),

('Lentil & Vegetable Soup', 320, 16, 45, 8, 14, 8, 1, 6, 0, 550, 80, 5.5,
 'Lentils, carrots, celery, onion, tomatoes, spinach, garlic, vegetable broth, thyme, bay leaves',
 3, 'Gluten-free', TRUE, 'Meal'),
  
('Coconut Red Curry Soup', 380, 12, 35, 8, 6, 22, 16, 5, 0, 580, 80, 4.0,
 'Red curry paste, coconut milk, tofu, mushrooms, bell peppers, snap peas, lime, cilantro',
 3, 'Contains soy, gluten-free', TRUE, 'Meal'),

('Sweet and Sour Tempeh', 420, 22, 50, 15, 6, 15, 2, 12, 0, 650, 120, 4.5,
 'Tempeh, pineapple, bell peppers, onion, brown rice, sweet and sour sauce, green onions',
 3, 'Contains soy', TRUE, 'Meal'),

('Maple Mustard Glazed Vegetable Bake', 350, 10, 50, 15, 10, 12, 1, 10, 0, 420, 80, 3.0,
 'Brussels sprouts, carrots, potatoes, maple syrup, dijon mustard, garlic, thyme',
 3, 'Gluten-free', TRUE, 'Meal'),

('Green Goddess Quinoa Bowl', 380, 14, 50, 4, 10, 16, 2, 13, 0, 380, 100, 4.5,
 'Quinoa, avocado, broccoli, kale, peas, hemp seeds, herbs, lemon, tahini',
 3, 'Contains sesame, gluten-free', TRUE, 'Meal'),

('Lentil and Mushroom Stuffed Peppers', 360, 14, 50, 8, 10, 12, 1, 10, 0, 420, 60, 4.5,
 'Bell peppers, brown lentils, mushrooms, onions, garlic, tomato sauce, herbs, spices',
 3, 'Gluten-free', TRUE, 'Meal'),

('Caribbean Rice and Beans', 450, 14, 80, 5, 12, 8, 1, 6, 0, 480, 80, 5.0,
 'Brown rice, kidney beans, coconut milk, thyme, allspice, scotch bonnet pepper, garlic, onion',
 3, 'Gluten-free', TRUE, 'Meal'),

('Tuscan White Bean Stew', 320, 16, 45, 6, 12, 8, 1, 6, 0, 520, 100, 5.5,
 'White beans, kale, tomatoes, carrots, celery, onion, garlic, Italian herbs, vegetable broth',
 3, 'Gluten-free', TRUE, 'Meal'),

('Spinach Artichoke Stuffed Mushrooms', 280, 10, 25, 3, 6, 18, 2, 15, 0, 450, 60, 3.0,
 'Portobello mushrooms, spinach, artichoke hearts, nutritional yeast, cashews, garlic, lemon',
 3, 'Contains nuts, gluten-free', TRUE, 'Meal'),

('Roasted Vegetable and Lentil Bowl', 420, 16, 60, 10, 14, 12, 1, 10, 0, 450, 80, 6.0,
 'Brown lentils, sweet potatoes, broccoli, bell peppers, onions, garlic, herbs, tahini',
 3, 'Contains sesame, gluten-free', TRUE, 'Meal'),

('Butternut Squash and Kale Pasta', 450, 12, 75, 8, 10, 12, 1, 10, 0, 480, 100, 4.0,
 'Whole grain pasta, butternut squash, kale, garlic, sage, nutritional yeast, olive oil',
 3, 'Contains gluten', TRUE, 'Meal'),

('Tofu and Vegetable Spring Rolls', 320, 14, 40, 6, 5, 12, 1, 10, 0, 580, 100, 3.0,
 'Tofu, rice paper, carrots, cucumber, bell peppers, mint, basil, rice noodles, peanut sauce',
 3, 'Contains soy and nuts, gluten-free', TRUE, 'Meal'),

('Creamy Broccoli Soup', 280, 10, 25, 4, 8, 18, 2, 15, 0, 450, 80, 2.5,
 'Broccoli, potatoes, onions, garlic, coconut milk, nutritional yeast, vegetable broth',
 3, 'Gluten-free', TRUE, 'Meal'),

('Chickpea Shawarma Wrap', 420, 15, 60, 5, 10, 15, 2, 12, 0, 580, 100, 4.0,
 'Chickpeas, shawarma spices, whole wheat wrap, lettuce, tomato, cucumber, tahini sauce',
 3, 'Contains gluten and sesame', TRUE, 'Meal'),

('Lentil and Spinach Dal', 350, 16, 50, 4, 12, 8, 1, 6, 0, 480, 100, 6.0,
 'Red lentils, spinach, tomatoes, onions, garlic, ginger, curry powder, cumin, cilantro',
 3, 'Gluten-free', TRUE, 'Meal'),

('Curried Cauliflower and Chickpea Bowl', 380, 14, 55, 8, 12, 12, 1, 10, 0, 520, 80, 4.5,
 'Cauliflower, chickpeas, curry powder, brown rice, spinach, raisins, cilantro',
 3, 'Gluten-free', TRUE, 'Meal'),

('Mushroom and Walnut Pâté', 320, 10, 15, 2, 4, 28, 3, 24, 0, 380, 60, 2.5,
 'Mushrooms, walnuts, onion, garlic, thyme, rosemary, tamari, nutritional yeast',
 3, 'Contains nuts and soy, gluten-free', TRUE, 'Snack'),

('Roasted Red Pepper Hummus Wrap', 420, 15, 60, 5, 10, 15, 2, 12, 0, 580, 100, 4.0,
 'Chickpeas, roasted red peppers, tahini, garlic, whole wheat wrap, spinach, cucumber',
 3, 'Contains gluten and sesame', TRUE, 'Meal'),

('Tomato and White Bean Stew', 320, 14, 45, 8, 10, 10, 1, 8, 0, 520, 80, 4.0,
 'White beans, tomatoes, kale, onions, garlic, herbs, vegetable broth, nutritional yeast',
 3, 'Gluten-free', TRUE, 'Meal'),

('Mushroom Walnut Bolognese', 420, 14, 65, 8, 10, 15, 2, 12, 0, 580, 80, 4.5,
 'Mushrooms, walnuts, carrots, celery, onions, garlic, tomato sauce, herbs, whole grain pasta',
 3, 'Contains gluten and nuts', TRUE, 'Meal'),

('Crispy Buffalo Cauliflower Bowl', 450, 12, 68, 10, 12, 16, 2, 13, 0, 650, 100, 3.5,
 'Cauliflower, buffalo sauce, quinoa, spinach, avocado, carrots, celery, vegan ranch',
 3, 'Gluten-free', TRUE, 'Meal'),

('Sweet Potato Lentil Curry', 380, 16, 60, 12, 14, 8, 1, 6, 0, 420, 90, 5.6,
 'Red lentils, sweet potatoes, coconut milk, curry powder, tomatoes, onion, garlic, ginger, spinach',
 3, 'Gluten-free', TRUE, 'Meal'),

('BBQ Jackfruit Pulled "Pork" Sandwiches', 450, 10, 75, 18, 8, 10, 1, 8, 0, 780, 100, 3.2,
 'Young jackfruit, BBQ sauce, onion, garlic, whole grain buns, coleslaw, pickles',
 3, 'Contains gluten', TRUE, 'Meal'),

('Harissa Roasted Vegetable Couscous', 420, 12, 70, 10, 10, 12, 1, 10, 0, 480, 80, 4.0,
 'Bell peppers, zucchini, carrots, chickpeas, couscous, harissa paste, garlic, lemon, mint',
 3, 'Contains gluten', TRUE, 'Meal'),

('Sesame Ginger Soba Noodle Bowl', 450, 15, 75, 8, 6, 12, 2, 10, 0, 750, 60, 3.0,
 'Soba noodles, edamame, carrots, bell peppers, cucumber, green onions, sesame oil, ginger, soy sauce',
 3, 'Contains gluten and soy', TRUE, 'Meal'),

('Stuffed Portobello Mushrooms', 380, 12, 40, 6, 8, 18, 2, 15, 0, 450, 100, 3.8,
 'Portobello mushrooms, quinoa, bell peppers, spinach, sun-dried tomatoes, herbs, balsamic glaze',
 3, 'Gluten-free', TRUE, 'Meal'),

('Roasted Cauliflower Shawarma Wrap', 420, 14, 60, 5, 12, 15, 2, 12, 0, 650, 120, 4.0,
 'Cauliflower, shawarma spices, whole wheat wrap, tahini sauce, tomatoes, cucumber, pickles',
 3, 'Contains gluten and sesame', TRUE, 'Meal'),

('Miso Glazed Eggplant', 350, 8, 45, 15, 6, 16, 2, 13, 0, 680, 80, 2.5,
 'Eggplant, miso paste, maple syrup, rice vinegar, ginger, garlic, green onions, sesame seeds, brown rice',
 3, 'Contains soy', TRUE, 'Meal'),

('Caribbean Black Bean Soup', 380, 14, 65, 8, 15, 6, 1, 5, 0, 520, 120, 6.0,
 'Black beans, bell peppers, onions, garlic, cumin, allspice, thyme, coconut milk, lime, cilantro',
 3, 'Gluten-free', TRUE, 'Meal'),

('Crispy Tofu Banh Mi', 450, 18, 60, 6, 5, 15, 2, 12, 0, 720, 150, 4.5,
 'Tofu, baguette, pickled carrots, daikon, cucumber, cilantro, vegan mayo, sriracha',
 3, 'Contains gluten and soy', TRUE, 'Meal'),

('Butternut Squash Mac and "Cheese"', 480, 14, 75, 10, 8, 15, 2, 12, 0, 520, 100, 3.5,
 'Butternut squash, cashews, nutritional yeast, garlic, onion powder, paprika, whole grain pasta',
 3, 'Contains gluten and nuts', TRUE, 'Meal'),

('Maple Sriracha Brussels Sprouts Bowl', 420, 15, 60, 15, 12, 14, 2, 11, 0, 580, 100, 4.5,
 'Brussels sprouts, sweet potatoes, black beans, quinoa, maple syrup, sriracha, lime',
 3, 'Gluten-free', TRUE, 'Meal'),

('Lentil Walnut Taco "Meat"', 380, 18, 45, 5, 14, 16, 2, 13, 0, 580, 90, 6.0,
 'Brown lentils, walnuts, taco seasoning, corn tortillas, lettuce, tomato, avocado, lime',
 3, 'Contains nuts, gluten-free', TRUE, 'Meal'),

('Mediterranean Chickpea Stuffed Peppers', 360, 12, 50, 8, 12, 14, 2, 11, 0, 450, 100, 4.0,
 'Bell peppers, chickpeas, quinoa, olives, sun-dried tomatoes, parsley, lemon, herbs',
 3, 'Gluten-free', TRUE, 'Meal'),

('Spicy Peanut Tofu Lettuce Wraps', 350, 18, 25, 8, 6, 20, 3, 16, 0, 620, 150, 3.5,
 'Tofu, lettuce leaves, carrots, cucumber, red cabbage, green onions, peanut sauce, sriracha',
 3, 'Contains soy and nuts, gluten-free', TRUE, 'Meal'),

('Coconut Curry Lentil Soup', 360, 16, 50, 6, 12, 12, 6, 5, 0, 480, 80, 6.0,
 'Red lentils, coconut milk, carrots, celery, onion, garlic, curry powder, ginger, spinach',
 3, 'Gluten-free', TRUE, 'Meal'),

('Roasted Vegetable Quinoa Power Bowl', 420, 14, 65, 12, 12, 12, 1, 10, 0, 360, 100, 5.5,
 'Quinoa, sweet potatoes, broccoli, chickpeas, kale, tahini dressing, avocado, pumpkin seeds',
 3, 'Contains sesame, gluten-free', TRUE, 'Meal'),

('Mushroom and White Bean Cassoulet', 380, 16, 55, 5, 14, 10, 1, 8, 0, 520, 120, 5.0,
 'White beans, mushrooms, carrots, celery, onions, garlic, tomatoes, herbs, breadcrumbs',
 3, 'Contains gluten', TRUE, 'Meal'),

('Green Goddess Buddha Bowl', 400, 15, 50, 8, 12, 18, 2, 15, 0, 420, 150, 4.5,
 'Quinoa, avocado, edamame, cucumber, kale, green tahini sauce, pumpkin seeds',
 3, 'Contains soy and sesame, gluten-free', TRUE, 'Meal'),

('Tandoori Cauliflower Tacos', 380, 10, 55, 6, 10, 15, 2, 12, 0, 550, 90, 3.5,
 'Cauliflower, tandoori spices, corn tortillas, cucumber raita, red onion, cilantro, lime',
 3, 'Gluten-free', TRUE, 'Meal'),

('Maple Dijon Tempeh with Roasted Vegetables', 450, 24, 45, 12, 10, 18, 2, 15, 0, 580, 160, 5.0,
 'Tempeh, maple syrup, dijon mustard, brussels sprouts, sweet potatoes, garlic, thyme',
 3, 'Contains soy, gluten-free', TRUE, 'Meal'),

('Za\'atar Roasted Carrot & Chickpea Bowl', 380, 12, 60, 10, 12, 12, 1, 10, 0, 420, 100, 4.5,
 'Carrots, chickpeas, quinoa, za\'atar spice, lemon, parsley, tahini sauce',
 3, 'Contains sesame, gluten-free', TRUE, 'Meal'),

('Black Bean Sweet Potato Chili', 360, 14, 65, 12, 15, 6, 1, 5, 0, 520, 120, 5.5,
 'Black beans, sweet potatoes, tomatoes, bell peppers, onion, garlic, chili powder, cumin, cilantro',
 3, 'Gluten-free', TRUE, 'Meal'),

('Cashew Cream Spinach Pasta', 480, 16, 70, 4, 8, 18, 3, 14, 0, 480, 100, 4.0,
 'Whole grain pasta, cashews, spinach, nutritional yeast, garlic, onion, lemon',
 3, 'Contains gluten and nuts', TRUE, 'Meal'),

('Chickpea Flour Vegetable Frittata', 380, 16, 35, 5, 8, 20, 2, 16, 0, 420, 80, 4.5,
 'Chickpea flour, nutritional yeast, zucchini, bell peppers, onions, garlic, herbs, turmeric',
 3, 'Gluten-free', TRUE, 'Meal'),

('Ginger Sesame Bok Choy with Tofu', 350, 18, 30, 6, 5, 18, 2, 15, 0, 650, 350, 5.0,
 'Tofu, bok choy, carrots, ginger, garlic, sesame oil, soy sauce, brown rice',
 3, 'Contains soy, gluten-free', TRUE, 'Meal'),

('Moroccan Stuffed Eggplant', 320, 10, 45, 12, 10, 14, 2, 11, 0, 380, 80, 3.5,
 'Eggplant, chickpeas, quinoa, tomatoes, cinnamon, cumin, raisins, mint, parsley',
 3, 'Gluten-free', TRUE, 'Meal'),

('Pumpkin Sage Pasta', 450, 14, 75, 8, 6, 12, 1, 10, 0, 420, 80, 4.0,
 'Whole grain pasta, pumpkin puree, sage, garlic, nutritional yeast, pumpkin seeds, olive oil',
 3, 'Contains gluten', TRUE, 'Meal'),

('Buffalo Chickpea Wrap', 420, 16, 60, 4, 10, 15, 2, 12, 0, 680, 100, 4.0,
 'Chickpeas, buffalo sauce, whole wheat wrap, lettuce, tomato, red onion, vegan ranch',
 3, 'Contains gluten', TRUE, 'Meal'),

('Smoky Bean and Sweet Potato Quesadillas', 450, 14, 70, 10, 12, 14, 2, 11, 0, 580, 120, 4.5,
 'Pinto beans, sweet potatoes, whole wheat tortillas, vegan cheese, chipotle peppers, cilantro',
 3, 'Contains gluten', TRUE, 'Meal'),

('Kale and White Bean Soup', 320, 15, 45, 5, 10, 8, 1, 6, 0, 520, 150, 5.0,
 'Kale, white beans, carrots, celery, onion, garlic, tomatoes, herbs, vegetable broth',
 3, 'Gluten-free', TRUE, 'Meal'),

('Rainbow Collard Wraps with Peanut Sauce', 350, 12, 35, 8, 8, 20, 3, 16, 0, 420, 100, 3.5,
 'Collard leaves, tofu, carrots, bell peppers, cucumber, red cabbage, peanut sauce',
 3, 'Contains soy and nuts, gluten-free', TRUE, 'Meal'),

('Roasted Garlic Cauliflower Soup', 280, 8, 30, 6, 8, 16, 2, 13, 0, 450, 80, 2.5,
 'Cauliflower, garlic, onions, vegetable broth, coconut milk, herbs, nutritional yeast',
 3, 'Gluten-free', TRUE, 'Meal'),

('Chickpea Avocado Salad Sandwich', 420, 15, 55, 5, 12, 18, 2, 15, 0, 580, 80, 4.0,
 'Chickpeas, avocado, whole grain bread, lettuce, tomato, red onion, herbs, lemon',
 3, 'Contains gluten', TRUE, 'Meal'),

('Thai Inspired Spiralized Zucchini Bowl', 320, 14, 30, 10, 8, 18, 2, 15, 0, 620, 100, 3.0,
 'Zucchini noodles, tofu, bell peppers, carrots, green onions, peanut sauce, lime, cilantro',
 3, 'Contains soy and nuts, gluten-free', TRUE, 'Meal'),

('Curried Lentil Stuffed Squash', 380, 14, 60, 12, 12, 10, 1, 8, 0, 420, 80, 5.5,
 'Acorn squash, lentils, carrots, celery, onion, curry powder, coconut milk, spinach',
 3, 'Gluten-free', TRUE, 'Meal'),

('Cauliflower Walnut Taco "Meat"', 360, 12, 30, 4, 8, 25, 3, 21, 0, 520, 80, 3.5,
 'Cauliflower, walnuts, taco seasoning, corn tortillas, lettuce, tomato, avocado, salsa',
 3, 'Contains nuts, gluten-free', TRUE, 'Meal'),

('Quinoa Stuffed Bell Peppers', 380, 12, 60, 8, 10, 10, 1, 8, 0, 420, 60, 4.0,
 'Bell peppers, quinoa, black beans, corn, tomatoes, cumin, chili powder, cilantro',
 3, 'Gluten-free', TRUE, 'Meal'),

('Roasted Beet and Lentil Salad', 350, 14, 50, 10, 12, 10, 1, 8, 0, 380, 80, 5.0,
 'Beets, lentils, arugula, walnuts, balsamic vinaigrette, orange segments',
 3, 'Contains nuts, gluten-free', TRUE, 'Meal'),

('Spinach Mushroom Tofu Quiche', 420, 20, 30, 3, 5, 25, 3, 21, 0, 480, 200, 4.5,
 'Tofu, mushrooms, spinach, nutritional yeast, onions, garlic, herbs, whole wheat crust',
 3, 'Contains soy and gluten', TRUE, 'Meal'),

('Lentil and Vegetable Shepherd\'s Pie', 450, 16, 70, 10, 14, 10, 1, 8, 0, 520, 80, 5.5,
 'Lentils, carrots, peas, corn, onions, garlic, tomato paste, mashed potatoes, herbs',
 3, 'Gluten-free', TRUE, 'Meal'),

('Sesame Orange Tempeh with Broccoli', 420, 25, 45, 15, 8, 16, 2, 13, 0, 750, 150, 4.5,
 'Tempeh, broccoli, orange juice, soy sauce, sesame oil, garlic, ginger, brown rice',
 3, 'Contains soy and sesame', TRUE, 'Meal'),

('Chickpea "Tuna" Salad', 350, 14, 40, 4, 10, 15, 2, 12, 0, 580, 80, 4.0,
 'Chickpeas, celery, red onion, nori sheets, vegan mayo, lemon, dill, whole grain bread',
 3, 'Contains gluten', TRUE, 'Meal'),

('Mushroom Lentil Loaf', 380, 18, 50, 6, 12, 10, 1, 8, 0, 520, 60, 5.0,
 'Brown lentils, mushrooms, onions, celery, flaxseed, breadcrumbs, tomato glaze, herbs',
 3, 'Contains gluten', TRUE, 'Meal'),

('Turmeric Roasted Cauliflower and Chickpea Bowl', 420, 15, 55, 8, 12, 18, 2, 15, 0, 480, 120, 5.0,
 'Cauliflower, chickpeas, turmeric, quinoa, kale, tahini dressing, lemon',
 3, 'Contains sesame, gluten-free', TRUE, 'Meal'),

('Walnut Mushroom Bolognese', 450, 14, 65, 8, 10, 18, 2, 15, 0, 580, 80, 4.5,
 'Walnuts, mushrooms, carrots, celery, onions, garlic, tomato sauce, herbs, pasta',
 3, 'Contains gluten and nuts', TRUE, 'Meal'),

('Thai Green Curry with Vegetables', 420, 10, 40, 8, 6, 25, 18, 6, 0, 650, 80, 4.0,
 'Coconut milk, green curry paste, tofu, bell peppers, eggplant, bamboo shoots, basil, brown rice',
 3, 'Contains soy, gluten-free', TRUE, 'Meal'),

('Stuffed Cabbage Rolls', 380, 12, 55, 10, 10, 10, 1, 8, 0, 420, 80, 4.5,
 'Cabbage, brown rice, lentils, tomato sauce, onions, garlic, herbs, spices',
 3, 'Gluten-free', TRUE, 'Meal'),

('Falafel Buddha Bowl', 450, 18, 60, 5, 12, 18, 2, 15, 0, 580, 150, 5.0,
 'Chickpeas, parsley, cilantro, cumin, coriander, quinoa, cucumber, tomatoes, tahini sauce',
 3, 'Contains sesame, gluten-free', TRUE, 'Meal'),

('Wild Rice and Mushroom Pilaf', 380, 10, 70, 3, 8, 8, 1, 6, 0, 420, 50, 3.0,
 'Wild rice, mushrooms, onions, garlic, thyme, rosemary, vegetable broth, cranberries',
 3, 'Gluten-free', TRUE, 'Meal'),

('Barbecue Tempeh Sandwich', 450, 22, 60, 12, 8, 15, 2, 12, 0, 750, 150, 4.5,
 'Tempeh, barbecue sauce, whole grain bun, lettuce, tomato, pickles, red onion',
 3, 'Contains soy and gluten', TRUE, 'Meal'),

('Roasted Vegetable and White Bean Pasta', 420, 16, 65, 6, 10, 12, 1, 10, 0, 480, 100, 4.5,
 'Whole grain pasta, white beans, zucchini, bell peppers, cherry tomatoes, garlic, herbs',
 3, 'Contains gluten', TRUE, 'Meal'),

('Sunflower Seed "Tuna" Wraps', 380, 14, 45, 4, 8, 18, 2, 15, 0, 520, 60, 3.5,
 'Sunflower seeds, celery, red onion, dill, lemon, vegan mayo, whole grain wraps, lettuce',
 3, 'Contains gluten', TRUE, 'Meal'),

('Chickpea and Vegetable Tagine', 350, 12, 55, 12, 10, 10, 1, 8, 0, 420, 80, 4.0,
 'Chickpeas, carrots, zucchini, sweet potatoes, tomatoes, onions, garlic, Moroccan spices',
 3, 'Gluten-free', TRUE, 'Meal'),

('Creamy Mushroom and Kale Pasta', 450, 14, 70, 4, 8, 15, 2, 12, 0, 480, 100, 4.0,
 'Whole grain pasta, mushrooms, kale, cashew cream, garlic, onions, nutritional yeast',
 3, 'Contains gluten and nuts', TRUE, 'Meal'),

('Lemon Herb Mediterranean Bowl', 420, 15, 60, 5, 10, 15, 2, 12, 0, 420, 80, 4.5,
 'Quinoa, chickpeas, cucumber, tomatoes, red onion, parsley, mint, lemon, tahini dressing',
 3, 'Contains sesame, gluten-free', TRUE, 'Meal'),

('Black-Eyed Pea Curry', 350, 14, 50, 6, 12, 10, 5, 4, 0, 480, 80, 5.0,
 'Black-eyed peas, tomatoes, coconut milk, onions, garlic, ginger, curry spices, cilantro',
 3, 'Gluten-free', TRUE, 'Meal'),

('Korean BBQ Tofu Bowl', 420, 20, 55, 10, 6, 15, 2, 12, 0, 750, 200, 4.5,
 'Tofu, brown rice, kimchi, carrots, cucumber, spinach, Korean BBQ sauce, sesame seeds',
 3, 'Contains soy and sesame', TRUE, 'Meal'),

('Hearty Vegetable and Barley Soup', 350, 12, 65, 8, 14, 5, 1, 4, 0, 520, 60, 4.0,
 'Barley, carrots, celery, kale, potatoes, onions, garlic, vegetable broth, herbs',
 3, 'Contains gluten', TRUE, 'Meal'),

('Chickpea Cucumber Mediterranean Salad', 320, 12, 40, 5, 8, 15, 2, 12, 0, 450, 80, 3.5,
 'Chickpeas, cucumber, tomatoes, red onion, olives, parsley, lemon, olive oil',
 3, 'Gluten-free', TRUE, 'Meal'),

('Cauliflower Steaks with Chimichurri', 280, 8, 25, 6, 10, 18, 2, 15, 0, 380, 60, 2.5,
 'Cauliflower, parsley, cilantro, garlic, red wine vinegar, olive oil, red pepper flakes',
 3, 'Gluten-free', TRUE, 'Meal'),

('Peanut Tofu Noodle Bowl', 450, 20, 60, 8, 6, 18, 3, 14, 0, 750, 150, 4.0,
 'Tofu, rice noodles, carrots, bell peppers, green onions, peanut sauce, cilantro, lime',
 3, 'Contains soy, nuts, and gluten', TRUE, 'Meal'),

('Lentil Loaf with Tomato Glaze', 420, 18, 60, 10, 12, 8, 1, 6, 0, 580, 60, 6.0,
 'Brown lentils, onions, celery, carrots, flaxseed, oats, tomato paste, maple syrup',
 3, 'Gluten-free', TRUE, 'Meal'),

('Creamy Tomato Basil Soup', 280, 6, 35, 8, 5, 15, 2, 12, 0, 620, 80, 2.5,
 'Tomatoes, coconut milk, onions, garlic, basil, vegetable broth, nutritional yeast',
 3, 'Gluten-free', TRUE, 'Meal'),

('Roasted Brussels Sprout and Tempeh Hash', 420, 22, 40, 8, 10, 20, 3, 16, 0, 580, 150, 5.0,
 'Tempeh, brussels sprouts, potatoes, onions, bell peppers, garlic, herbs, spices',
 3, 'Contains soy, gluten-free', TRUE, 'Meal'),

('Creamy Potato Leek Soup', 320, 8, 50, 5, 8, 10, 1, 8, 0, 480, 60, 2.5,
 'Potatoes, leeks, onions, garlic, vegetable broth, coconut milk, herbs',
 3, 'Gluten-free', TRUE, 'Meal'),

('Chipotle Black Bean Burgers', 380, 14, 50, 4, 12, 15, 2, 12, 0, 580, 80, 4.5,
 'Black beans, quinoa, onions, bell peppers, chipotle peppers, cumin, whole grain buns',
 3, 'Contains gluten', TRUE, 'Meal'),

('Maple Glazed Brussels Sprouts and Tempeh', 420, 22, 40, 14, 10, 18, 2, 15, 0, 520, 150, 4.5,
 'Tempeh, brussels sprouts, maple syrup, balsamic vinegar, garlic, thyme',
 3, 'Contains soy, gluten-free', TRUE, 'Meal'),

('Stuffed Sweet Potatoes with Black Beans', 380, 12, 65, 15, 12, 8, 1, 6, 0, 420, 100, 4.0,
 'Sweet potatoes, black beans, corn, bell peppers, onions, cilantro, lime, avocado',
 3, 'Gluten-free', TRUE, 'Meal'),

('Roasted Red Pepper and Tomato Soup', 250, 6, 30, 10, 6, 12, 1, 10, 0, 520, 60, 2.0,
 'Red bell peppers, tomatoes, onions, garlic, vegetable broth, herbs, nutritional yeast',
 3, 'Gluten-free', TRUE, 'Meal'),

('Mushroom and Spinach Risotto', 450, 10, 75, 3, 4, 12, 1, 10, 0, 580, 60, 3.0,
 'Arborio rice, mushrooms, spinach, onions, garlic, vegetable broth, nutritional yeast',
 3, 'Gluten-free', TRUE, 'Meal'),

('Teriyaki Tofu Stir Fry', 420, 20, 50, 12, 6, 15, 2, 12, 0, 850, 150, 4.0,
 'Tofu, broccoli, bell peppers, carrots, teriyaki sauce, garlic, ginger, brown rice',
 3, 'Contains soy', TRUE, 'Meal'),

('Moroccan Chickpea Stew', 380, 14, 60, 10, 12, 10, 1, 8, 0, 480, 100, 5.0,
 'Chickpeas, sweet potatoes, tomatoes, onions, garlic, Moroccan spices, cilantro',
 3, 'Gluten-free', TRUE, 'Meal'),

('Cashew Vegetable Curry', 450, 12, 50, 8, 8, 25, 5, 19, 0, 580, 100, 4.0,
 'Cashews, bell peppers, carrots, green beans, coconut milk, curry powder, garlic, ginger',
 3, 'Contains nuts, gluten-free', TRUE, 'Meal'),

('Mediterranean Stuffed Zucchini Boats', 350, 10, 40, 6, 8, 18, 2, 15, 0, 420, 60, 3.0,
 'Zucchini, quinoa, chickpeas, tomatoes, olives, herbs, lemon, tahini sauce',
 3, 'Contains sesame, gluten-free', TRUE, 'Meal');

-- Pescatarian meals (CategoryID = 4)

INSERT INTO meals (
  MealName, Calories_cal, Protein_g, Carbs_g, Sugars_g, Fibers_g, 
  Fat_g, SatFat_g, UnsatFat_g, Cholesterol_mg, Sodium_mg, Calcium_mg, Iron_mg, 
  Ingredients, CategoryID, DietNotes, IsHomeCooked, IsMealorSnack
) VALUES
('Tuna Sweetcorn Cakes', 400, 30, 20, 3, 2, 22, 4, 15, 70, 500, 60, 1.8, 
 'Canned tuna, sweetcorn, egg, breadcrumbs, spring onions, lemon zest, olive oil, salt, pepper', 
 4, 'Contains gluten and egg', TRUE, 'Meal'),
 
('Harissa Prawns with Couscous', 480, 35, 30, 2, 2, 22, 3, 15, 120, 500, 100, 1.9, 
 'Prawns, couscous, harissa paste, lemon juice, coriander, olive oil, garlic', 
 4, 'Contains shellfish and gluten', TRUE, 'Meal'),

('Salmon Avocado Bowl', 520, 32, 25, 4, 6, 32, 5, 24, 85, 430, 120, 2.5, 
 'Salmon fillet, avocado, brown rice, cucumber, seaweed, soy sauce, sesame seeds, ginger', 
 4, 'Contains fish and soy', TRUE, 'Meal'),

('Mediterranean Baked Cod', 350, 28, 15, 3, 4, 20, 3, 15, 65, 480, 80, 1.5, 
 'Cod fillet, cherry tomatoes, olives, capers, garlic, olive oil, lemon juice, parsley', 
 4, 'Contains fish', TRUE, 'Meal'),

('Miso Glazed Sea Bass', 390, 30, 18, 5, 2, 22, 4, 16, 70, 620, 60, 1.2, 
 'Sea bass fillet, miso paste, honey, ginger, sesame oil, bok choy, spring onions', 
 4, 'Contains fish and soy', TRUE, 'Meal'),

('Lemon Garlic Shrimp Pasta', 550, 25, 65, 3, 4, 18, 2, 14, 140, 580, 70, 2.8, 
 'Shrimp, whole wheat pasta, garlic, lemon juice, white wine, parsley, olive oil, chili flakes', 
 4, 'Contains shellfish and gluten', TRUE, 'Meal'),

('Anchovy and Olive Flatbread', 420, 15, 48, 2, 3, 20, 4, 14, 15, 750, 150, 3.0, 
 'Flatbread, anchovies, olives, cherry tomatoes, mozzarella, capers, oregano, olive oil', 
 4, 'Contains fish, gluten and dairy', TRUE, 'Meal'),

('Tuna Niçoise Salad', 380, 25, 18, 4, 5, 24, 3, 19, 60, 490, 100, 3.5, 
 'Tuna steak, baby potatoes, green beans, eggs, olives, cherry tomatoes, lettuce, mustard vinaigrette', 
 4, 'Contains fish and egg', TRUE, 'Meal'),

('Sesame Crusted Tuna Steak', 410, 35, 12, 1, 2, 25, 4, 19, 55, 420, 60, 2.0, 
 'Tuna steak, sesame seeds, soy sauce, mirin, ginger, wasabi, mixed greens, rice vinegar', 
 4, 'Contains fish and soy', TRUE, 'Meal'),

('Sardines on Toast', 320, 18, 25, 2, 3, 16, 3, 11, 45, 580, 250, 2.5, 
 'Canned sardines, sourdough bread, lemon juice, parsley, red onion, black pepper, olive oil', 
 4, 'Contains fish and gluten', TRUE, 'Meal'),

('Prawn and Avocado Salad', 350, 22, 15, 5, 7, 24, 3, 18, 130, 410, 95, 2.2, 
 'Prawns, avocado, mixed greens, cherry tomatoes, cucumber, lime juice, olive oil, coriander', 
 4, 'Contains shellfish', TRUE, 'Meal'),

('Smoked Salmon Bagel', 440, 24, 50, 6, 2, 18, 5, 10, 30, 850, 120, 3.0, 
 'Smoked salmon, bagel, cream cheese, red onion, capers, dill, lemon juice, black pepper', 
 4, 'Contains fish, gluten and dairy', TRUE, 'Meal'),

('Mackerel Pâté on Rye', 380, 20, 22, 2, 5, 24, 6, 16, 75, 650, 150, 2.8, 
 'Smoked mackerel, cream cheese, horseradish, lemon juice, rye bread, cucumber, dill', 
 4, 'Contains fish, gluten and dairy', TRUE, 'Meal'),

('Fish Tacos with Lime Slaw', 420, 25, 40, 4, 5, 18, 3, 13, 60, 560, 120, 2.0, 
 'White fish fillets, corn tortillas, cabbage, lime, avocado, coriander, yogurt, spices', 
 4, 'Contains fish, gluten and dairy', TRUE, 'Meal'),

('Trout with Almond Butter', 450, 30, 8, 2, 3, 35, 7, 25, 80, 390, 90, 2.5, 
 'Trout fillet, almonds, butter, lemon juice, parsley, green beans, salt, pepper', 
 4, 'Contains fish, nuts and dairy', TRUE, 'Meal'),

('Spicy Tuna Rice Bowl', 480, 28, 55, 3, 4, 16, 2, 12, 45, 620, 60, 2.5, 
 'Tuna steak, brown rice, edamame, carrot, cucumber, sriracha, mayo, sesame seeds, nori', 
 4, 'Contains fish, soy and egg', TRUE, 'Meal'),

('Lemon Butter Sole', 350, 25, 10, 1, 1, 25, 8, 15, 70, 450, 50, 1.0, 
 'Sole fillet, butter, lemon juice, capers, parsley, white wine, salt, pepper', 
 4, 'Contains fish and dairy', TRUE, 'Meal'),

('Crab Linguine', 520, 22, 65, 3, 3, 17, 2, 13, 85, 680, 100, 3.5, 
 'Crab meat, linguine, garlic, chili, lemon juice, white wine, parsley, olive oil', 
 4, 'Contains shellfish and gluten', TRUE, 'Meal'),

('Grilled Halloumi with Seafood Salad', 420, 25, 15, 4, 4, 30, 12, 15, 50, 700, 350, 2.0, 
 'Halloumi cheese, mixed seafood, rocket, cherry tomatoes, cucumber, lemon juice, olive oil, mint', 
 4, 'Contains shellfish and dairy', TRUE, 'Meal'),

('Teriyaki Salmon with Noodles', 540, 30, 58, 10, 3, 22, 4, 16, 75, 950, 80, 2.5, 
 'Salmon fillet, udon noodles, teriyaki sauce, broccoli, spring onions, sesame seeds, ginger', 
 4, 'Contains fish, soy and gluten', TRUE, 'Meal'),

('Seafood Paella', 580, 28, 70, 4, 4, 18, 3, 13, 95, 780, 70, 4.0, 
 'Mixed seafood, rice, saffron, tomatoes, peas, bell peppers, onion, garlic, olive oil, paprika', 
 4, 'Contains shellfish', TRUE, 'Meal'),

('Tuna and Bean Salad', 350, 28, 30, 3, 9, 15, 2, 11, 30, 490, 120, 4.5, 
 'Canned tuna, mixed beans, red onion, cherry tomatoes, parsley, lemon juice, olive oil, balsamic vinegar', 
 4, 'Contains fish', TRUE, 'Meal'),

('Smoked Haddock Chowder', 420, 25, 35, 5, 3, 20, 8, 10, 60, 720, 180, 2.0, 
 'Smoked haddock, potatoes, sweetcorn, leeks, milk, butter, bay leaf, parsley', 
 4, 'Contains fish and dairy', TRUE, 'Meal'),

('Prawn and Pea Risotto', 550, 22, 70, 4, 4, 18, 5, 11, 110, 650, 100, 2.5, 
 'Prawns, arborio rice, peas, onion, garlic, white wine, vegetable stock, parmesan, butter', 
 4, 'Contains shellfish and dairy', TRUE, 'Meal'),

('Spicy Fish Curry', 420, 28, 35, 6, 5, 20, 5, 13, 65, 580, 120, 3.0, 
 'White fish fillets, coconut milk, curry paste, tomatoes, spinach, coriander, lime juice, brown rice', 
 4, 'Contains fish', TRUE, 'Meal'),

('Baked Tilapia with Roasted Vegetables', 380, 30, 20, 5, 6, 18, 3, 13, 70, 450, 80, 2.0, 
 'Tilapia fillet, bell peppers, zucchini, cherry tomatoes, red onion, garlic, herbs, olive oil', 
 4, 'Contains fish', TRUE, 'Meal'),

('Salmon and Asparagus Quiche', 490, 22, 30, 3, 3, 32, 12, 18, 180, 580, 250, 3.0, 
 'Salmon fillet, asparagus, eggs, cream, shortcrust pastry, dill, lemon zest, black pepper', 
 4, 'Contains fish, gluten, egg and dairy', TRUE, 'Meal'),

('Mussels Mariniere', 350, 25, 15, 2, 1, 20, 4, 14, 70, 750, 80, 6.0, 
 'Mussels, white wine, shallots, garlic, parsley, butter, black pepper, baguette', 
 4, 'Contains shellfish, gluten and dairy', TRUE, 'Meal'),

('Prawn and Mango Salad', 320, 18, 25, 15, 4, 16, 2, 12, 120, 430, 80, 1.5, 
 'Prawns, mango, avocado, mixed greens, red chili, lime juice, coriander, olive oil', 
 4, 'Contains shellfish', TRUE, 'Meal'),

('Cod with Lentils', 420, 35, 40, 3, 10, 12, 2, 9, 65, 520, 90, 5.0, 
 'Cod fillet, puy lentils, cherry tomatoes, spinach, onion, garlic, lemon juice, olive oil, herbs', 
 4, 'Contains fish', TRUE, 'Meal'),

('Salmon and Broccoli Pasta Bake', 560, 30, 55, 4, 6, 25, 9, 14, 90, 620, 280, 2.5, 
 'Salmon fillet, whole wheat pasta, broccoli, cheddar cheese, milk, flour, mustard, breadcrumbs', 
 4, 'Contains fish, gluten and dairy', TRUE, 'Meal'),

('Kedgeree', 470, 25, 55, 3, 2, 18, 5, 11, 180, 650, 80, 3.0, 
 'Smoked haddock, rice, eggs, curry powder, peas, butter, parsley, lemon juice', 
 4, 'Contains fish, egg and dairy', TRUE, 'Meal'),

('Prawn and Coconut Soup', 320, 20, 12, 5, 3, 22, 15, 5, 110, 720, 90, 3.5, 
 'Prawns, coconut milk, lemongrass, ginger, chili, lime juice, fish sauce, coriander, mushrooms', 
 4, 'Contains shellfish', TRUE, 'Meal'),

('Sardine and Tomato Pasta', 450, 22, 60, 6, 5, 15, 3, 10, 50, 580, 150, 4.0, 
 'Canned sardines, whole wheat pasta, cherry tomatoes, garlic, chili flakes, parsley, lemon juice, olive oil', 
 4, 'Contains fish and gluten', TRUE, 'Meal'),

('Sushi Bowl', 480, 20, 70, 5, 3, 12, 2, 9, 50, 650, 60, 2.0, 
 'Salmon, sushi rice, avocado, cucumber, carrot, nori, pickled ginger, soy sauce, wasabi, sesame seeds', 
 4, 'Contains fish and soy', TRUE, 'Meal'),

('Tuna Melt Sandwich', 480, 28, 40, 4, 3, 22, 8, 12, 65, 780, 300, 3.0, 
 'Canned tuna, whole grain bread, cheddar cheese, mayonnaise, red onion, celery, lemon juice', 
 4, 'Contains fish, gluten, egg and dairy', TRUE, 'Meal'),

('Cajun Fish with Sweet Potato Mash', 420, 30, 35, 8, 5, 18, 3, 13, 70, 580, 70, 2.5, 
 'White fish fillets, cajun spices, sweet potatoes, spring onions, lime juice, olive oil, coriander', 
 4, 'Contains fish', TRUE, 'Meal'),

('Prawn and Vegetable Stir Fry', 380, 25, 30, 7, 6, 16, 2, 12, 130, 850, 100, 3.0, 
 'Prawns, broccoli, bell peppers, snap peas, carrots, garlic, ginger, soy sauce, sesame oil', 
 4, 'Contains shellfish and soy', TRUE, 'Meal'),

('Smoked Mackerel and Potato Salad', 420, 22, 35, 3, 4, 22, 5, 15, 60, 620, 80, 2.5, 
 'Smoked mackerel, new potatoes, yogurt, horseradish, spring onions, capers, dill, lemon juice', 
 4, 'Contains fish and dairy', TRUE, 'Meal'),

('Salmon Fishcakes', 430, 25, 35, 2, 3, 20, 4, 14, 80, 580, 120, 2.0, 
 'Salmon fillet, potatoes, breadcrumbs, egg, spring onions, dill, lemon zest, olive oil', 
 4, 'Contains fish, gluten and egg', TRUE, 'Meal'),

('Tuna Poke Bowl', 450, 28, 45, 6, 5, 16, 2, 12, 45, 560, 80, 3.0, 
 'Tuna steak, brown rice, edamame, avocado, cucumber, radish, seaweed, soy sauce, sesame oil', 
 4, 'Contains fish and soy', TRUE, 'Meal'),

('Fish Pie', 520, 30, 40, 5, 3, 25, 12, 11, 100, 680, 280, 2.5, 
 'Mixed fish fillets, potatoes, milk, butter, flour, peas, carrots, parsley, cheese', 
 4, 'Contains fish and dairy', TRUE, 'Meal'),

('Prawn and Tomato Linguine', 480, 22, 65, 7, 4, 14, 2, 10, 110, 620, 90, 3.5, 
 'Prawns, linguine, cherry tomatoes, garlic, white wine, chili flakes, parsley, olive oil', 
 4, 'Contains shellfish and gluten', TRUE, 'Meal'),

('Creamy Garlic Scallops', 390, 25, 10, 2, 1, 28, 10, 16, 90, 660, 70, 1.5, 
 'Scallops, garlic, cream, white wine, lemon juice, parsley, butter, black pepper', 
 4, 'Contains shellfish and dairy', TRUE, 'Meal'),

('Asian-Style Baked Cod', 340, 28, 20, 6, 3, 15, 2, 11, 65, 780, 60, 1.8, 
 'Cod fillet, soy sauce, honey, ginger, garlic, spring onions, sesame oil, bok choy', 
 4, 'Contains fish and soy', TRUE, 'Meal'),

('Smoked Salmon and Scrambled Eggs', 380, 25, 5, 1, 0, 30, 8, 20, 380, 590, 120, 3.0, 
 'Smoked salmon, eggs, butter, chives, black pepper, sourdough toast', 
 4, 'Contains fish, egg, gluten and dairy', TRUE, 'Meal'),

('Mediterranean Fish Stew', 380, 28, 25, 6, 5, 18, 3, 13, 70, 650, 100, 3.5, 
 'Mixed fish, tomatoes, fennel, olives, garlic, white wine, herbs, olive oil, crusty bread', 
 4, 'Contains fish and gluten', TRUE, 'Meal'),

('Grilled Sardines with Greek Salad', 360, 25, 10, 6, 3, 25, 5, 18, 70, 590, 150, 2.5, 
 'Fresh sardines, cucumber, tomatoes, red onion, feta cheese, olives, oregano, lemon juice, olive oil', 
 4, 'Contains fish and dairy', TRUE, 'Meal'),

('Tuna and Quinoa Stuffed Peppers', 380, 28, 35, 8, 7, 15, 3, 10, 40, 480, 80, 4.0, 
 'Canned tuna, quinoa, bell peppers, spinach, cherry tomatoes, feta cheese, herbs, lemon juice', 
 4, 'Contains fish and dairy', TRUE, 'Meal'),

('Steamed Mussels with Tomato and Chorizo', 440, 30, 15, 5, 2, 28, 8, 18, 90, 890, 90, 8.0, 
 'Mussels, chorizo, tomatoes, garlic, white wine, parsley, olive oil, crusty bread', 
 4, 'Contains shellfish, gluten and may contain pork', TRUE, 'Meal'),

('Salmon with Roasted Beetroot and Lentils', 460, 32, 35, 8, 9, 20, 3, 15, 70, 510, 100, 5.0, 
 'Salmon fillet, beetroot, puy lentils, spinach, balsamic vinegar, olive oil, dill, horseradish', 
 4, 'Contains fish', TRUE, 'Meal'),

('Prawn and Chorizo Jambalaya', 520, 28, 65, 5, 5, 18, 5, 11, 130, 850, 80, 4.5, 
 'Prawns, chorizo, rice, bell peppers, onion, celery, tomatoes, cajun spices, garlic', 
 4, 'Contains shellfish and may contain pork', TRUE, 'Meal'),

('Caesar Salad with Anchovies', 380, 18, 15, 2, 3, 28, 6, 20, 60, 720, 200, 2.0, 
 'Romaine lettuce, anchovies, parmesan cheese, croutons, egg yolk, garlic, lemon juice, olive oil', 
 4, 'Contains fish, gluten, egg and dairy', TRUE, 'Meal'),

('Grilled Salmon with Asparagus', 420, 35, 10, 2, 4, 25, 5, 18, 85, 450, 60, 2.5,
 'Salmon fillet, asparagus, lemon, garlic, olive oil, dill, black pepper, sea salt',
 4, 'Gluten-free, dairy-free', TRUE, 'Meal'),

('Tuna Sweetcorn Cakes', 400, 30, 20, 3, 2, 22, 4, 15, 70, 500, 60, 1.8,
 'Canned tuna, sweetcorn, egg, breadcrumbs, spring onions, lemon zest, olive oil, salt, pepper',
 4, 'Contains gluten and egg', TRUE, 'Meal'),

('Harissa Prawns with Couscous', 480, 35, 30, 2, 2, 22, 3, 15, 120, 500, 100, 1.9,
 'Prawns, couscous, harissa paste, lemon juice, coriander, olive oil, garlic',
 4, 'Contains shellfish and gluten', TRUE, 'Meal'),

('Baked Cod with Herby Crust', 410, 36, 10, 1, 1, 25, 4, 18, 70, 450, 80, 1.2,
 'Cod fillet, parsley, dill, lemon zest, breadcrumbs, olive oil, garlic',
 4, 'Contains gluten', TRUE, 'Meal'),

('Mediterranean Fish Stew', 380, 32, 20, 6, 4, 18, 3, 13, 85, 680, 80, 2.8,
 'White fish, tomatoes, onion, garlic, fennel, white wine, olives, capers, herbs de provence, olive oil',
 4, 'Gluten-free, dairy-free', TRUE, 'Meal'),

('Shrimp Scampi with Zoodles', 340, 30, 12, 4, 5, 20, 4, 14, 185, 680, 120, 2.0,
 'Shrimp, zucchini noodles, garlic, butter, white wine, lemon juice, parsley, red pepper flakes',
 4, 'Contains shellfish and dairy, gluten-free', TRUE, 'Meal'),

('Tuna Niçoise Salad', 380, 28, 20, 5, 6, 20, 3, 15, 90, 520, 100, 3.0,
 'Tuna, eggs, green beans, potatoes, tomatoes, olives, lettuce, dijon mustard, olive oil, lemon juice',
 4, 'Contains eggs, gluten-free', TRUE, 'Meal'),

('Miso Glazed Cod', 350, 30, 20, 8, 2, 14, 2, 10, 75, 780, 40, 1.2,
 'Cod fillet, miso paste, honey, soy sauce, ginger, garlic, green onions, sesame seeds, brown rice',
 4, 'Contains soy', TRUE, 'Meal'),

('Crab Cakes with Remoulade', 420, 25, 25, 2, 2, 25, 4, 19, 120, 650, 120, 2.2,
 'Crab meat, breadcrumbs, egg, bell pepper, onion, celery, mayonnaise, dijon mustard, Old Bay seasoning',
 4, 'Contains shellfish, gluten, and eggs', TRUE, 'Meal'),

('Grilled Shrimp & Pineapple Skewers', 320, 26, 25, 18, 3, 10, 1, 8, 180, 480, 80, 1.8,
 'Shrimp, pineapple, bell peppers, red onion, olive oil, lime juice, cilantro, brown rice',
 4, 'Contains shellfish, gluten-free', TRUE, 'Meal'),

('Lemon Butter Baked Cod', 350, 35, 5, 1, 0, 20, 8, 10, 85, 420, 40, 1.0,
 'Cod fillet, butter, lemon, garlic, parsley, thyme, black pepper',
 4, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Tuna Poke Bowl', 450, 30, 45, 6, 5, 16, 2, 12, 60, 580, 60, 2.2,
 'Tuna, brown rice, cucumber, avocado, edamame, seaweed, soy sauce, sesame oil, sriracha mayo',
 4, 'Contains soy', TRUE, 'Meal'),

('Lobster Mac & Cheese', 620, 32, 55, 4, 2, 32, 18, 12, 120, 780, 450, 2.0,
 'Lobster meat, macaroni, cheddar, gruyere, milk, flour, butter, breadcrumbs, mustard powder',
 4, 'Contains shellfish, dairy, and gluten', TRUE, 'Meal'),

('Blackened Tilapia Tacos', 380, 28, 30, 3, 4, 16, 3, 12, 70, 620, 120, 2.0,
 'Tilapia, corn tortillas, cabbage slaw, avocado, lime crema, blackening spice, cilantro',
 4, 'Contains dairy', TRUE, 'Meal'),

('Salmon Sushi Bowl', 450, 28, 45, 5, 3, 18, 3, 13, 65, 720, 80, 2.5,
 'Salmon, sushi rice, avocado, cucumber, edamame, nori, soy sauce, wasabi, pickled ginger',
 4, 'Contains soy', TRUE, 'Meal'),

('Trout with Almonds & Green Beans', 420, 32, 10, 3, 5, 25, 4, 19, 80, 360, 100, 3.0,
 'Trout fillet, almonds, green beans, lemon, butter, parsley, garlic',
 4, 'Contains nuts and dairy, gluten-free', TRUE, 'Meal'),

('Coconut Shrimp Curry', 520, 25, 35, 8, 6, 32, 18, 12, 170, 680, 120, 4.2,
 'Shrimp, coconut milk, curry paste, bell peppers, onion, garlic, ginger, cilantro, lime juice, rice',
 4, 'Contains shellfish, gluten-free', TRUE, 'Meal'),

('Mediterranean Sardine Salad', 360, 24, 20, 6, 7, 22, 3, 17, 40, 580, 350, 3.8,
 'Canned sardines, romaine lettuce, tomatoes, cucumber, red onion, olives, feta, olive oil, lemon juice',
 4, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Fish Tacos with Mango Salsa', 420, 25, 40, 12, 5, 18, 3, 13, 70, 520, 100, 2.0,
 'White fish, corn tortillas, mango, red onion, cilantro, lime juice, cabbage, avocado, sour cream',
 4, 'Contains dairy', TRUE, 'Meal'),

('Sesame Crusted Tuna Steak', 380, 35, 15, 2, 3, 20, 3, 15, 65, 450, 60, 2.5,
 'Tuna steak, sesame seeds, soy sauce, ginger, honey, wasabi, mixed greens, rice vinegar',
 4, 'Contains soy', TRUE, 'Meal'),

('Scallops with Lemon Butter Sauce', 350, 25, 10, 2, 1, 25, 12, 11, 80, 520, 40, 1.0,
 'Scallops, butter, lemon, white wine, garlic, parsley, shallots, black pepper',
 4, 'Contains shellfish and dairy, gluten-free', TRUE, 'Meal'),

('Shrimp Pasta Primavera', 480, 28, 55, 6, 4, 18, 4, 12, 160, 620, 100, 3.0,
 'Shrimp, fettuccine, zucchini, cherry tomatoes, bell peppers, peas, garlic, olive oil, parmesan',
 4, 'Contains shellfish, dairy, and gluten', TRUE, 'Meal'),

('Honey Garlic Salmon', 420, 35, 15, 12, 1, 22, 4, 16, 85, 580, 60, 2.0,
 'Salmon fillet, honey, soy sauce, garlic, lemon juice, butter, green onions, sesame seeds',
 4, 'Contains soy and dairy', TRUE, 'Meal'),

('Ceviche with Avocado', 280, 24, 15, 5, 6, 14, 2, 10, 60, 450, 60, 1.5,
 'White fish, lime juice, red onion, tomato, cilantro, jalapeño, avocado, salt, pepper',
 4, 'Gluten-free, dairy-free', TRUE, 'Meal'),

('Fish & Vegetable Curry', 450, 30, 35, 8, 8, 22, 15, 5, 70, 650, 100, 3.5,
 'White fish, coconut milk, curry powder, tomatoes, bell peppers, spinach, onion, garlic, ginger, rice',
 4, 'Gluten-free, dairy-free', TRUE, 'Meal'),

('Calamari Stir Fry', 380, 28, 30, 5, 4, 16, 2, 12, 150, 720, 80, 2.5,
 'Squid, bell peppers, snow peas, carrots, garlic, ginger, soy sauce, sesame oil, rice',
 4, 'Contains soy', TRUE, 'Meal'),

('Smoked Salmon Breakfast Bowl', 420, 25, 30, 3, 5, 22, 6, 14, 250, 680, 120, 2.5,
 'Smoked salmon, quinoa, eggs, avocado, spinach, cherry tomatoes, red onion, capers, dill',
 4, 'Contains eggs, gluten-free', TRUE, 'Meal'),

('Fish Chowder', 450, 25, 35, 5, 3, 24, 12, 10, 80, 750, 150, 2.0,
 'White fish, potatoes, corn, celery, onion, bacon, milk, cream, butter, thyme, bay leaf',
 4, 'Contains dairy', TRUE, 'Meal'),

('Clam Linguine', 520, 28, 60, 4, 3, 18, 3, 13, 70, 680, 80, 5.0,
 'Clams, linguine, white wine, garlic, red pepper flakes, parsley, olive oil, butter, lemon zest',
 4, 'Contains shellfish, dairy, and gluten', TRUE, 'Meal'),

('Teriyaki Salmon Bowl', 480, 32, 45, 15, 4, 18, 3, 13, 85, 850, 60, 2.0,
 'Salmon fillet, teriyaki sauce, brown rice, broccoli, carrots, edamame, green onions, sesame seeds',
 4, 'Contains soy', TRUE, 'Meal'),

('Cajun Shrimp and Grits', 520, 30, 45, 3, 2, 25, 12, 11, 180, 750, 150, 2.0,
 'Shrimp, grits, bell peppers, onion, celery, garlic, cajun seasoning, butter, cheese, green onions',
 4, 'Contains shellfish and dairy, gluten-free', TRUE, 'Meal'),

('Baked Tilapia with Roasted Vegetables', 380, 32, 20, 6, 5, 16, 3, 12, 70, 450, 80, 2.0,
 'Tilapia fillet, zucchini, bell peppers, cherry tomatoes, red onion, garlic, thyme, olive oil, lemon',
 4, 'Gluten-free, dairy-free', TRUE, 'Meal'),

('Anchovy and Olive Pasta', 450, 18, 60, 3, 4, 20, 3, 15, 35, 880, 80, 3.0,
 'Spaghetti, anchovies, kalamata olives, capers, garlic, red pepper flakes, parsley, olive oil',
 4, 'Contains gluten', TRUE, 'Meal'),

('Seared Scallops with Risotto', 550, 30, 65, 3, 2, 18, 6, 10, 80, 680, 60, 1.5,
 'Scallops, arborio rice, white wine, vegetable broth, shallots, garlic, parmesan, butter, parsley',
 4, 'Contains shellfish and dairy', TRUE, 'Meal'),

('Mediterranean Tuna Salad Wrap', 420, 28, 40, 3, 6, 16, 3, 12, 60, 580, 120, 3.0,
 'Canned tuna, whole wheat wrap, hummus, cucumber, tomato, red onion, feta cheese, olives, mixed greens',
 4, 'Contains dairy and gluten', TRUE, 'Meal'),

('Steamed Fish with Ginger and Scallions', 320, 30, 10, 1, 2, 18, 3, 13, 80, 520, 60, 1.2,
 'White fish, ginger, scallions, soy sauce, sesame oil, cilantro, steamed vegetables, rice',
 4, 'Contains soy, gluten-free', TRUE, 'Meal'),

('Shrimp and Avocado Salad', 350, 25, 15, 3, 8, 22, 3, 17, 175, 480, 100, 2.0,
 'Shrimp, avocado, mixed greens, cucumber, cherry tomatoes, red onion, lime juice, olive oil, cilantro',
 4, 'Contains shellfish, gluten-free, dairy-free', TRUE, 'Meal'),

('Lemon Garlic Butter Shrimp Pasta', 520, 28, 55, 3, 3, 24, 12, 10, 180, 620, 100, 3.0,
 'Shrimp, linguine, butter, garlic, lemon juice, parsley, red pepper flakes, parmesan cheese',
 4, 'Contains shellfish, dairy, and gluten', TRUE, 'Meal'),

('Salmon with Dill Sauce', 420, 35, 5, 2, 1, 28, 10, 16, 85, 480, 100, 2.0,
 'Salmon fillet, Greek yogurt, dill, lemon juice, garlic, cucumber, capers, olive oil',
 4, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Fish Curry with Coconut Rice', 520, 30, 60, 5, 4, 22, 16, 4, 75, 680, 80, 3.0,
 'White fish, coconut milk, curry paste, tomatoes, onion, garlic, ginger, jasmine rice, cilantro, lime',
 4, 'Gluten-free, dairy-free', TRUE, 'Meal'),

('Tuna Melt Sandwich', 480, 30, 35, 4, 3, 24, 10, 12, 75, 750, 350, 2.5,
 'Canned tuna, whole grain bread, cheddar cheese, Greek yogurt, celery, red onion, mustard, pickles',
 4, 'Contains dairy and gluten', TRUE, 'Meal'),

('Sardines on Toast', 380, 25, 25, 2, 4, 20, 4, 14, 50, 650, 350, 4.0,
 'Canned sardines, whole grain bread, tomatoes, red onion, parsley, lemon juice, olive oil, black pepper',
 4, 'Contains gluten', TRUE, 'Meal'),

('Shrimp and Vegetable Skewers', 320, 28, 15, 6, 4, 16, 3, 12, 180, 450, 80, 2.0,
 'Shrimp, bell peppers, zucchini, red onion, cherry tomatoes, olive oil, garlic, lemon juice, oregano',
 4, 'Contains shellfish, gluten-free, dairy-free', TRUE, 'Meal'),

('Cioppino (Seafood Stew)', 420, 35, 20, 6, 4, 18, 3, 13, 150, 680, 100, 3.5,
 'Mixed seafood (shrimp, mussels, fish), tomatoes, fennel, onion, garlic, white wine, herbs, red pepper flakes',
 4, 'Contains shellfish, gluten-free, dairy-free', TRUE, 'Meal'),

('Tuna Stuffed Bell Peppers', 380, 30, 25, 8, 5, 16, 3, 12, 65, 520, 120, 2.5,
 'Canned tuna, bell peppers, quinoa, spinach, onion, garlic, tomatoes, feta cheese, lemon juice, olive oil',
 4, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Baked Salmon with Sweet Potato', 450, 35, 30, 10, 5, 20, 4, 14, 85, 420, 80, 3.0,
 'Salmon fillet, sweet potato, olive oil, garlic, rosemary, thyme, lemon, green beans',
 4, 'Gluten-free, dairy-free', TRUE, 'Meal'),

('Shrimp Fried Rice', 480, 25, 60, 3, 4, 16, 3, 12, 170, 750, 60, 3.0,
 'Shrimp, brown rice, eggs, peas, carrots, onion, garlic, ginger, soy sauce, sesame oil, green onions',
 4, 'Contains shellfish, soy, and eggs', TRUE, 'Meal'),

('Fish and Chips (Baked)', 520, 30, 50, 3, 5, 22, 4, 16, 70, 580, 60, 2.5,
 'Cod fillet, potatoes, breadcrumbs, eggs, lemon, tartar sauce, peas, olive oil, garlic, dill',
 4, 'Contains gluten and eggs', TRUE, 'Meal'),

('Shrimp and Spinach Quesadilla', 450, 28, 35, 3, 4, 22, 10, 10, 180, 680, 350, 3.0,
 'Shrimp, whole wheat tortilla, spinach, bell peppers, onion, cheddar cheese, Greek yogurt, salsa',
 4, 'Contains shellfish, dairy, and gluten', TRUE, 'Meal'),

('Salmon Cakes with Dill Sauce', 420, 30, 25, 3, 3, 22, 5, 15, 85, 580, 100, 2.5,
 'Salmon, breadcrumbs, eggs, onion, bell pepper, Greek yogurt, dill, lemon juice, dijon mustard',
 4, 'Contains gluten, dairy, and eggs', TRUE, 'Meal'),

('Shrimp and Broccoli Alfredo', 520, 30, 45, 3, 4, 28, 16, 10, 180, 750, 350, 2.0,
 'Shrimp, fettuccine, broccoli, garlic, parmesan cheese, heavy cream, butter, black pepper',
 4, 'Contains shellfish, dairy, and gluten', TRUE, 'Meal'),

('Tuna and White Bean Salad', 350, 30, 25, 3, 8, 15, 2, 12, 60, 480, 100, 4.0,
 'Canned tuna, white beans, cherry tomatoes, red onion, parsley, lemon juice, olive oil, capers',
 4, 'Gluten-free, dairy-free', TRUE, 'Meal'),

('Mussels in White Wine Sauce', 380, 25, 15, 2, 1, 18, 3, 13, 60, 650, 80, 6.0,
 'Mussels, white wine, shallots, garlic, butter, parsley, lemon juice, baguette',
 4, 'Contains shellfish, dairy, and gluten', TRUE, 'Meal'),
  
('Miso Glazed Salmon Bowl', 520, 32, 45, 8, 5, 24, 4, 20, 85, 850, 120, 3.0,
 'Salmon fillet, brown rice, miso paste, ginger, garlic, broccoli, sesame seeds, green onions, soy sauce',
 4, 'Contains fish and soy', TRUE, 'Meal'),

('Mediterranean Baked Cod', 380, 35, 15, 3, 4, 18, 3, 15, 80, 520, 80, 2.5,
 'Cod fillet, cherry tomatoes, kalamata olives, capers, garlic, olive oil, lemon juice, parsley, oregano',
 4, 'Contains fish, gluten-free', TRUE, 'Meal'),

('Shrimp Scampi Linguine', 540, 28, 65, 3, 4, 20, 5, 15, 180, 620, 100, 3.5,
 'Shrimp, linguine, garlic, white wine, lemon juice, butter, parsley, red pepper flakes, parmesan cheese',
 4, 'Contains shellfish, dairy, and gluten', TRUE, 'Meal'),

('Tuna Poke Bowl', 450, 30, 50, 6, 6, 16, 2, 14, 60, 680, 80, 3.0,
 'Ahi tuna, sushi rice, avocado, cucumber, edamame, nori, soy sauce, sesame oil, green onions',
 4, 'Contains fish and soy', TRUE, 'Meal'),

('Lemon Butter Trout', 380, 32, 8, 2, 1, 24, 10, 14, 90, 420, 100, 2.5,
 'Rainbow trout, butter, lemon, garlic, thyme, parsley, capers, olive oil, black pepper',
 4, 'Contains fish and dairy, gluten-free', TRUE, 'Meal'),

('Coconut Curry Shrimp', 480, 28, 30, 10, 6, 30, 20, 10, 180, 720, 120, 4.2,
 'Shrimp, coconut milk, curry paste, bell peppers, onion, garlic, ginger, lime juice, cilantro, rice',
 4, 'Contains shellfish, gluten-free', TRUE, 'Meal'),

('Sardines on Toast', 320, 22, 20, 2, 3, 18, 3, 15, 60, 580, 350, 3.5,
 'Canned sardines, whole grain bread, lemon juice, parsley, red onion, olive oil, black pepper, tomato slices',
 4, 'Contains fish and gluten', TRUE, 'Meal'),

('Salmon Teriyaki', 450, 35, 35, 15, 2, 20, 4, 16, 85, 880, 60, 2.5,
 'Salmon fillet, teriyaki sauce, ginger, garlic, brown rice, broccoli, sesame seeds, green onions',
 4, 'Contains fish and soy', TRUE, 'Meal'),

('Crab Cakes with Remoulade', 480, 25, 30, 3, 2, 28, 5, 23, 160, 780, 150, 2.5,
 'Crab meat, bell pepper, green onions, mayonnaise, dijon mustard, egg, panko breadcrumbs, lemon juice, Old Bay seasoning',
 4, 'Contains shellfish, eggs, and gluten', TRUE, 'Meal'),

('Grilled Shrimp Skewers', 320, 28, 10, 4, 2, 18, 3, 15, 180, 620, 100, 2.0,
 'Shrimp, bell peppers, zucchini, red onion, olive oil, lemon juice, garlic, paprika, oregano',
 4, 'Contains shellfish, gluten-free, dairy-free', TRUE, 'Meal'),

('Smoked Salmon Bagel', 420, 25, 45, 5, 3, 16, 5, 11, 50, 950, 150, 3.0,
 'Smoked salmon, bagel, cream cheese, capers, red onion, dill, lemon juice, black pepper, tomato slices',
 4, 'Contains fish, dairy, and gluten', TRUE, 'Meal'),

('Tuna Niçoise Salad', 380, 28, 20, 5, 6, 22, 4, 18, 120, 580, 100, 3.5,
 'Ahi tuna, green beans, potatoes, eggs, olives, cherry tomatoes, red onion, capers, dijon vinaigrette',
 4, 'Contains fish and eggs, gluten-free', TRUE, 'Meal'),

('Fish Tacos with Slaw', 450, 28, 40, 6, 5, 20, 3, 17, 65, 680, 150, 2.5,
 'White fish, corn tortillas, cabbage slaw, avocado, lime crema, cilantro, jalapeño, salsa',
 4, 'Contains fish and dairy', TRUE, 'Meal'),

('Shrimp Pad Thai', 520, 25, 65, 12, 3, 18, 3, 15, 180, 920, 120, 3.5,
 'Shrimp, rice noodles, egg, bean sprouts, green onions, peanuts, lime, tamarind paste, fish sauce, palm sugar',
 4, 'Contains shellfish, eggs, nuts, and soy', TRUE, 'Meal'),

('Baked Tilapia Packets', 350, 32, 15, 5, 4, 15, 2, 13, 70, 480, 80, 2.0,
 'Tilapia fillets, zucchini, cherry tomatoes, lemon slices, garlic, olive oil, thyme, parsley',
 4, 'Contains fish, gluten-free, dairy-free', TRUE, 'Meal'),

('Seared Scallops with Risotto', 520, 28, 60, 3, 2, 20, 6, 14, 80, 720, 100, 2.0,
 'Sea scallops, arborio rice, white wine, vegetable broth, shallots, garlic, parmesan cheese, butter, parsley',
 4, 'Contains shellfish and dairy, gluten-free', TRUE, 'Meal'),

('Tuna Melt Sandwich', 450, 30, 35, 4, 3, 22, 8, 14, 80, 850, 300, 3.0,
 'Canned tuna, whole grain bread, cheddar cheese, mayonnaise, celery, red onion, dijon mustard, dill pickle',
 4, 'Contains fish, dairy, and gluten', TRUE, 'Meal'),

('Mussels Marinière', 420, 28, 20, 2, 1, 22, 6, 16, 80, 820, 100, 6.5,
 'Mussels, white wine, shallots, garlic, butter, parsley, lemon juice, crusty bread',
 4, 'Contains shellfish, dairy, and gluten', TRUE, 'Meal'),

('Grilled Mahi-Mahi', 350, 35, 10, 2, 3, 16, 3, 13, 120, 480, 60, 2.0,
 'Mahi-mahi, olive oil, lemon juice, garlic, thyme, bell peppers, zucchini, red onion',
 4, 'Contains fish, gluten-free, dairy-free', TRUE, 'Meal'),

('Shrimp and Vegetable Stir Fry', 380, 28, 30, 8, 6, 16, 2, 14, 180, 780, 120, 3.0,
 'Shrimp, broccoli, snap peas, bell peppers, carrots, garlic, ginger, soy sauce, sesame oil, rice',
 4, 'Contains shellfish and soy', TRUE, 'Meal'),

('Smoked Mackerel Pâté', 320, 20, 8, 2, 1, 24, 6, 18, 70, 650, 150, 2.5,
 'Smoked mackerel, cream cheese, lemon juice, horseradish, dill, black pepper, whole grain crackers',
 4, 'Contains fish, dairy, and gluten', TRUE, 'Meal'),

('Shrimp and Grits', 520, 25, 55, 3, 2, 25, 10, 15, 180, 880, 200, 2.5,
 'Shrimp, stone-ground grits, cheddar cheese, bacon, garlic, lemon juice, parsley, green onions, butter',
 4, 'Contains shellfish and dairy, gluten-free', TRUE, 'Meal'),

('Oven-Baked Salmon Cakes', 380, 28, 25, 2, 3, 20, 4, 16, 120, 620, 150, 2.5,
 'Canned salmon, panko breadcrumbs, eggs, bell pepper, green onions, dijon mustard, lemon juice, dill',
 4, 'Contains fish, eggs, and gluten', TRUE, 'Meal'),

('Tuna Salad Stuffed Avocado', 350, 28, 15, 2, 10, 22, 4, 18, 60, 480, 80, 2.0,
 'Canned tuna, avocado, celery, red onion, lemon juice, mayonnaise, dijon mustard, dill, black pepper',
 4, 'Contains fish, gluten-free', TRUE, 'Meal'),

('Mediterranean Fish Stew', 420, 30, 25, 8, 5, 20, 3, 17, 80, 780, 120, 3.5,
 'White fish, shrimp, mussels, tomatoes, fennel, onion, garlic, white wine, saffron, herbs, olive oil',
 4, 'Contains fish and shellfish, gluten-free', TRUE, 'Meal'),

('Lemon Dill Baked Tilapia', 280, 32, 5, 1, 1, 14, 2, 12, 70, 420, 60, 1.5,
 'Tilapia fillets, lemon juice, olive oil, garlic, dill, parsley, black pepper',
 4, 'Contains fish, gluten-free, dairy-free', TRUE, 'Meal'),

('Shrimp and Avocado Salad', 320, 25, 15, 3, 8, 18, 3, 15, 180, 480, 100, 2.5,
 'Shrimp, avocado, mixed greens, cucumber, cherry tomatoes, red onion, lime juice, olive oil, cilantro',
 4, 'Contains shellfish, gluten-free, dairy-free', TRUE, 'Meal'),

('Salmon and Vegetable Foil Packets', 420, 35, 20, 6, 5, 22, 4, 18, 85, 480, 80, 2.5,
 'Salmon fillet, zucchini, bell peppers, cherry tomatoes, red onion, lemon, dill, olive oil, garlic',
 4, 'Contains fish, gluten-free, dairy-free', TRUE, 'Meal'),

('Tuna Pasta Salad', 450, 28, 50, 4, 4, 16, 3, 13, 60, 620, 80, 3.0,
 'Canned tuna, whole wheat pasta, cherry tomatoes, cucumber, red onion, olives, feta cheese, lemon juice, olive oil',
 4, 'Contains fish, dairy, and gluten', TRUE, 'Meal'),

('Cioppino Seafood Stew', 420, 32, 20, 6, 4, 18, 3, 15, 200, 780, 120, 3.5,
 'Shrimp, mussels, clams, white fish, tomatoes, fennel, onion, garlic, white wine, herbs, red pepper flakes',
 4, 'Contains fish and shellfish, gluten-free', TRUE, 'Meal'),

('Smoked Salmon Frittata', 380, 28, 8, 2, 1, 25, 8, 17, 320, 680, 200, 2.5,
 'Eggs, smoked salmon, spinach, onion, cherry tomatoes, feta cheese, dill, black pepper',
 4, 'Contains fish, eggs, and dairy, gluten-free', TRUE, 'Meal'),

('Shrimp and Black Bean Burrito Bowl', 450, 30, 55, 5, 12, 12, 2, 10, 180, 680, 120, 4.0,
 'Shrimp, black beans, brown rice, corn, avocado, cilantro, lime juice, cherry tomatoes, red onion, bell peppers',
 4, 'Contains shellfish, gluten-free, dairy-free', TRUE, 'Meal'),

('Tuna Stuffed Bell Peppers', 350, 28, 20, 8, 5, 16, 3, 13, 60, 520, 120, 2.5,
 'Canned tuna, bell peppers, quinoa, spinach, onion, garlic, tomatoes, feta cheese, lemon juice, olive oil',
 4, 'Contains fish and dairy, gluten-free', TRUE, 'Meal'),

('Baked Cod with Herb Crust', 320, 32, 15, 1, 2, 14, 2, 12, 80, 520, 80, 2.0,
 'Cod fillet, whole wheat breadcrumbs, parsley, dill, lemon zest, olive oil, garlic, dijon mustard',
 4, 'Contains fish and gluten', TRUE, 'Meal'),

('Cajun Shrimp and Quinoa', 420, 28, 45, 3, 6, 15, 2, 13, 180, 720, 80, 4.5,
 'Shrimp, quinoa, bell peppers, celery, onion, garlic, cajun seasoning, thyme, parsley, lemon juice',
 4, 'Contains shellfish, gluten-free, dairy-free', TRUE, 'Meal'),

('Honey Garlic Salmon', 420, 35, 20, 15, 1, 22, 4, 18, 85, 650, 60, 2.0,
 'Salmon fillet, honey, soy sauce, garlic, ginger, lemon juice, green onions, sesame seeds',
 4, 'Contains fish and soy', TRUE, 'Meal'),

('Tuna and White Bean Salad', 380, 30, 25, 3, 8, 18, 3, 15, 60, 520, 100, 4.5,
 'Canned tuna, white beans, arugula, cherry tomatoes, red onion, olives, capers, lemon juice, olive oil',
 4, 'Contains fish, gluten-free, dairy-free', TRUE, 'Meal'),

('Shrimp Fajita Bowls', 420, 28, 40, 5, 6, 16, 3, 13, 180, 680, 100, 3.0,
 'Shrimp, bell peppers, onion, brown rice, black beans, avocado, lime juice, cilantro, cumin, chili powder',
 4, 'Contains shellfish, gluten-free, dairy-free', TRUE, 'Meal'),

('Fish and Vegetable Curry', 450, 30, 35, 8, 8, 22, 16, 6, 80, 720, 120, 4.0,
 'White fish, coconut milk, curry paste, bell peppers, spinach, onion, garlic, ginger, lime juice, brown rice',
 4, 'Contains fish, gluten-free, dairy-free', TRUE, 'Meal'),

('Smoked Trout and Potato Salad', 380, 25, 30, 3, 4, 20, 4, 16, 70, 580, 80, 2.5,
 'Smoked trout, baby potatoes, green beans, eggs, capers, red onion, dill, yogurt, dijon mustard, lemon juice',
 4, 'Contains fish, eggs, and dairy, gluten-free', TRUE, 'Meal'),

('Shrimp and Asparagus Risotto', 520, 25, 65, 3, 4, 18, 6, 12, 180, 680, 100, 3.0,
 'Shrimp, arborio rice, asparagus, white wine, vegetable broth, shallots, garlic, parmesan cheese, lemon zest',
 4, 'Contains shellfish and dairy, gluten-free', TRUE, 'Meal'),

('Grilled Swordfish Steaks', 380, 35, 5, 1, 1, 22, 5, 17, 80, 480, 60, 2.0,
 'Swordfish steak, olive oil, lemon juice, garlic, oregano, thyme, black pepper, parsley',
 4, 'Contains fish, gluten-free, dairy-free', TRUE, 'Meal'),

('Shrimp and Corn Chowder', 420, 25, 40, 10, 4, 20, 8, 12, 180, 780, 150, 2.5,
 'Shrimp, corn, potatoes, onion, celery, bell pepper, vegetable broth, milk, butter, thyme',
 4, 'Contains shellfish and dairy, gluten-free', TRUE, 'Meal'),

('Teriyaki Salmon Bowls', 480, 35, 50, 15, 4, 18, 3, 15, 85, 880, 60, 2.5,
 'Salmon fillet, teriyaki sauce, brown rice, broccoli, carrots, edamame, avocado, green onions, sesame seeds',
 4, 'Contains fish and soy', TRUE, 'Meal'),

('Mediterranean Tuna Salad Wraps', 420, 28, 35, 3, 6, 18, 3, 15, 60, 680, 120, 3.0,
 'Canned tuna, whole wheat wraps, hummus, cucumber, tomato, red onion, feta cheese, olives, mixed greens',
 4, 'Contains fish, dairy, and gluten', TRUE, 'Meal'),

('Clam Linguine', 520, 28, 65, 3, 3, 18, 3, 15, 60, 720, 100, 5.0,
 'Clams, linguine, white wine, garlic, red pepper flakes, parsley, olive oil, lemon zest, black pepper',
 4, 'Contains shellfish and gluten, dairy-free', TRUE, 'Meal'),

('Steamed Fish with Ginger and Scallions', 320, 32, 10, 2, 2, 16, 3, 13, 80, 580, 60, 1.5,
 'White fish, ginger, scallions, soy sauce, sesame oil, cilantro, rice, garlic',
 4, 'Contains fish and soy, dairy-free', TRUE, 'Meal'),

('Shrimp and Pineapple Skewers', 320, 25, 25, 20, 2, 14, 2, 12, 180, 450, 80, 2.0,
 'Shrimp, pineapple, bell peppers, red onion, olive oil, lime juice, garlic, cilantro, chili powder',
 4, 'Contains shellfish, gluten-free, dairy-free', TRUE, 'Meal'),

('Grilled Sardines', 350, 30, 5, 0, 0, 22, 5, 17, 100, 420, 350, 3.5,
 'Fresh sardines, olive oil, lemon juice, garlic, oregano, parsley, black pepper',
 4, 'Contains fish, gluten-free, dairy-free', TRUE, 'Meal'),

('Fish and Chips (Baked)', 520, 32, 50, 3, 4, 22, 4, 18, 80, 680, 60, 2.5,
 'Cod fillet, potatoes, panko breadcrumbs, eggs, flour, lemon, tartar sauce, parsley',
 4, 'Contains fish, eggs, and gluten', TRUE, 'Meal'),

('Shrimp and Kale Salad', 350, 25, 20, 4, 6, 18, 3, 15, 180, 480, 150, 3.5,
 'Shrimp, kale, quinoa, avocado, cherry tomatoes, cucumber, red onion, lemon juice, olive oil',
 4, 'Contains shellfish, gluten-free, dairy-free', TRUE, 'Meal'),

('Baked Salmon with Dill Sauce', 420, 35, 10, 3, 2, 25, 8, 17, 85, 580, 120, 2.5,
 'Salmon fillet, Greek yogurt, dill, lemon juice, garlic, cucumber, green onions, black pepper',
 4, 'Contains fish and dairy, gluten-free', TRUE, 'Meal'),

('Tuna and Avocado Poke', 380, 30, 15, 3, 8, 22, 4, 18, 60, 520, 60, 2.0,
 'Ahi tuna, avocado, cucumber, seaweed, soy sauce, sesame oil, green onions, sesame seeds, rice',
 4, 'Contains fish and soy', TRUE, 'Meal'),

('Seafood Paella', 520, 30, 65, 5, 4, 16, 3, 13, 180, 680, 100, 3.5,
 'Shrimp, mussels, clams, arborio rice, saffron, tomatoes, peas, bell peppers, onion, garlic, olive oil',
 4, 'Contains shellfish, gluten-free', TRUE, 'Meal'),

('Blackened Tilapia Tacos', 420, 30, 35, 3, 5, 18, 3, 15, 70, 620, 150, 2.5,
 'Tilapia, corn tortillas, cabbage slaw, avocado, lime crema, cilantro, blackening spice',
 4, 'Contains fish and dairy', TRUE, 'Meal'),

('Baked Cod with Mediterranean Vegetables', 350, 32, 20, 6, 5, 14, 2, 12, 80, 520, 80, 2.0,
 'Cod fillet, zucchini, cherry tomatoes, red onion, olives, garlic, lemon juice, olive oil, oregano',
 4, 'Contains fish, gluten-free, dairy-free', TRUE, 'Meal'),

('Shrimp and Spinach Quesadilla', 450, 28, 35, 3, 4, 22, 10, 12, 180, 720, 350, 3.0,
 'Shrimp, whole wheat tortilla, spinach, bell peppers, onion, cheddar cheese, Greek yogurt, salsa',
 4, 'Contains shellfish, dairy, and gluten', TRUE, 'Meal'),

('Smoked Salmon and Cucumber Bites', 180, 15, 5, 1, 1, 12, 6, 6, 30, 480, 80, 1.0,
 'Smoked salmon, cucumber, cream cheese, dill, capers, lemon zest, black pepper',
 4, 'Contains fish and dairy, gluten-free', TRUE, 'Snack'),

('Tuna and White Bean Salad', 320, 25, 20, 2, 6, 15, 2, 13, 40, 480, 100, 3.5,
 'Canned tuna, white beans, cherry tomatoes, red onion, parsley, lemon juice, olive oil, capers',
 4, 'Contains fish, gluten-free, dairy-free', TRUE, 'Meal'),

('Shrimp Ceviche', 180, 20, 10, 5, 2, 8, 1, 7, 150, 420, 60, 1.5,
 'Shrimp, lime juice, cherry tomatoes, red onion, jalapeño, cilantro, avocado, cucumber',
 4, 'Contains shellfish, gluten-free, dairy-free', TRUE, 'Snack'),

('Smoked Trout Spread', 220, 18, 5, 1, 0, 15, 5, 10, 45, 480, 100, 1.0,
 'Smoked trout, cream cheese, Greek yogurt, lemon juice, dill, horseradish, capers, green onions',
 4, 'Contains fish and dairy, gluten-free', TRUE, 'Snack'),

('Tuna Stuffed Avocado', 280, 22, 12, 1, 8, 18, 3, 15, 40, 420, 50, 1.5,
 'Canned tuna, avocado, lime juice, red onion, cilantro, salt, pepper',
 4, 'Contains fish, gluten-free, dairy-free', TRUE, 'Snack'),

('Prawn Cocktail Cups', 150, 15, 8, 5, 1, 8, 1, 7, 120, 480, 40, 1.0,
 'Shrimp, cocktail sauce, lemon juice, avocado, lettuce cups, parsley',
 4, 'Contains shellfish, gluten-free, dairy-free', TRUE, 'Snack'),

('Salmon Cucumber Rounds', 180, 15, 5, 1, 1, 12, 5, 7, 35, 480, 40, 1.0,
 'Smoked salmon, cucumber, cream cheese, dill, lemon zest, capers',
 4, 'Contains fish and dairy, gluten-free', TRUE, 'Snack'),

('Seaweed Snacks with Wasabi', 50, 2, 5, 0, 1, 3, 0, 3, 0, 150, 20, 0.5,
 'Nori seaweed, olive oil, sea salt, wasabi powder',
 4, 'Gluten-free, dairy-free', FALSE, 'Snack'),

('Sardines on Crackers', 180, 15, 15, 1, 2, 10, 2, 8, 40, 480, 200, 2.0,
 'Canned sardines, whole grain crackers, lemon juice, hot sauce, black pepper',
 4, 'Contains fish and gluten', TRUE, 'Snack'),

('Tuna Salad Cucumber Boats', 150, 18, 5, 2, 1, 8, 1, 7, 30, 380, 30, 1.0,
 'Canned tuna, cucumber, Greek yogurt, dill, lemon juice, red onion, capers',
 4, 'Contains fish and dairy, gluten-free', TRUE, 'Snack'),

('Smoked Salmon Pinwheels', 220, 15, 20, 2, 1, 10, 5, 5, 30, 520, 80, 1.0,
 'Smoked salmon, tortilla, cream cheese, spinach, capers, dill, red onion',
 4, 'Contains fish, dairy, and gluten', TRUE, 'Snack'),

('Shrimp and Avocado Lettuce Cups', 150, 15, 8, 1, 5, 10, 2, 8, 120, 350, 30, 1.0,
 'Shrimp, avocado, lime juice, cilantro, red onion, lettuce leaves, hot sauce',
 4, 'Contains shellfish, gluten-free, dairy-free', TRUE, 'Snack'),

('Roasted Seaweed Tuna Wraps', 120, 15, 5, 0, 1, 6, 1, 5, 30, 380, 20, 1.2,
 'Canned tuna, nori sheets, avocado, cucumber, carrot, sriracha mayo',
 4, 'Contains fish, gluten-free', TRUE, 'Snack'),

('Smoked Trout Deviled Eggs', 180, 12, 2, 1, 0, 14, 4, 10, 320, 420, 50, 1.5,
 'Eggs, smoked trout, Greek yogurt, dijon mustard, dill, paprika, capers',
 4, 'Contains fish and eggs, gluten-free', TRUE, 'Snack'),

('Mini Salmon Quiches', 220, 15, 15, 2, 1, 14, 6, 8, 120, 450, 120, 1.5,
 'Smoked salmon, eggs, milk, pie crust, spinach, dill, cream cheese',
 4, 'Contains fish, eggs, dairy, and gluten', TRUE, 'Snack'),

('Tuna Stuffed Cherry Tomatoes', 120, 12, 6, 4, 1, 6, 1, 5, 30, 350, 40, 1.0,
 'Canned tuna, cherry tomatoes, Greek yogurt, herbs, lemon juice, capers',
 4, 'Contains fish and dairy, gluten-free', TRUE, 'Snack'),

('Crab Stuffed Mushrooms', 180, 12, 8, 2, 1, 12, 5, 7, 60, 420, 80, 1.5,
 'Crab meat, mushroom caps, cream cheese, green onions, garlic, breadcrumbs, lemon juice, parsley',
 4, 'Contains shellfish, dairy, and gluten', TRUE, 'Snack'),

('Shrimp Salad Endive Boats', 120, 12, 5, 1, 2, 7, 1, 6, 120, 380, 30, 1.0,
 'Shrimp, endive leaves, celery, red onion, mayonnaise, lemon juice, dill, Old Bay seasoning',
 4, 'Contains shellfish, gluten-free', TRUE, 'Snack'),

('Smoked Mackerel Pâté Crackers', 180, 15, 10, 1, 1, 12, 4, 8, 45, 480, 80, 1.2,
 'Smoked mackerel, cream cheese, horseradish, lemon juice, dill, whole grain crackers',
 4, 'Contains fish, dairy, and gluten', TRUE, 'Snack'),

('Tuna Avocado Dip', 150, 10, 8, 1, 5, 10, 2, 8, 25, 320, 30, 1.0,
 'Canned tuna, avocado, Greek yogurt, lime juice, cilantro, jalapeño, tortilla chips',
 4, 'Contains fish and dairy', TRUE, 'Snack'),

('Prawn Cocktail Lettuce Cups', 120, 15, 5, 2, 1, 5, 1, 4, 120, 380, 30, 1.0,
 'Shrimp, cocktail sauce, lettuce cups, lemon wedges, avocado',
 4, 'Contains shellfish, gluten-free, dairy-free', TRUE, 'Snack'),

('Smoked Salmon Cucumber Canapés', 150, 12, 5, 1, 1, 10, 4, 6, 30, 450, 60, 1.0,
 'Smoked salmon, cucumber, cream cheese, dill, capers, lemon zest',
 4, 'Contains fish and dairy, gluten-free', TRUE, 'Snack'),

('Anchovy Olive Tapenade', 120, 6, 5, 1, 2, 10, 2, 8, 15, 650, 60, 1.5,
 'Anchovies, kalamata olives, capers, garlic, lemon juice, olive oil, parsley, crackers',
 4, 'Contains fish and gluten', TRUE, 'Snack'),

('Spicy Tuna Stuffed Peppers', 150, 15, 5, 3, 1, 8, 1, 7, 30, 380, 30, 1.0,
 'Canned tuna, mini bell peppers, Greek yogurt, sriracha, green onions, cilantro',
 4, 'Contains fish and dairy, gluten-free', TRUE, 'Snack'),

('Smoked Salmon Cream Cheese Balls', 180, 12, 5, 1, 0, 14, 7, 7, 35, 420, 80, 1.0,
 'Smoked salmon, cream cheese, chives, dill, everything bagel seasoning, crackers',
 4, 'Contains fish, dairy, and gluten', TRUE, 'Snack'),

('Garlic Herb Shrimp Skewers', 120, 18, 2, 0, 0, 5, 1, 4, 150, 350, 40, 1.0,
 'Shrimp, olive oil, garlic, parsley, lemon juice, oregano, black pepper',
 4, 'Contains shellfish, gluten-free, dairy-free', TRUE, 'Snack'),

('Tuna Stuffed Mini Potatoes', 180, 12, 15, 1, 2, 8, 2, 6, 30, 380, 40, 1.5,
 'Canned tuna, baby potatoes, Greek yogurt, chives, dill, lemon juice, paprika',
 4, 'Contains fish and dairy, gluten-free', TRUE, 'Snack'),

('Salmon Jerky', 150, 20, 5, 3, 0, 6, 1, 5, 40, 580, 30, 1.0,
 'Salmon, soy sauce, brown sugar, garlic powder, black pepper, liquid smoke',
 4, 'Contains fish and soy', FALSE, 'Snack'),

('Mini Crab Cakes', 180, 12, 12, 1, 1, 10, 3, 7, 60, 420, 60, 1.0,
 'Crab meat, panko breadcrumbs, egg, bell pepper, green onions, mayonnaise, Old Bay seasoning',
 4, 'Contains shellfish, eggs, and gluten', TRUE, 'Snack'),

('Seaweed Salad', 80, 2, 10, 2, 2, 3, 0, 3, 0, 350, 150, 2.0,
 'Seaweed, sesame oil, rice vinegar, soy sauce, sesame seeds, ginger',
 4, 'Contains soy, gluten-free, dairy-free', FALSE, 'Snack'),

('Smoked Trout Rice Paper Rolls', 150, 12, 15, 2, 1, 5, 1, 4, 35, 380, 30, 1.0,
 'Smoked trout, rice paper, cucumber, carrot, avocado, mint, cilantro, rice noodles',
 4, 'Contains fish, gluten-free, dairy-free', TRUE, 'Snack'),

('Tuna Egg Salad', 180, 15, 2, 1, 0, 12, 3, 9, 220, 350, 40, 1.5,
 'Canned tuna, eggs, Greek yogurt, dijon mustard, celery, red onion, dill',
 4, 'Contains fish and eggs, gluten-free', TRUE, 'Snack');


  -- Omnivore meals (CategoryID = 5)

INSERT INTO meals (
  MealName, Calories_cal, Protein_g, Carbs_g, Sugars_g, Fibers_g,
  Fat_g, SatFat_g, UnsatFat_g, Cholesterol_mg, Sodium_mg, Calcium_mg, Iron_mg,
  Ingredients, CategoryID, DietNotes, IsHomeCooked, IsMealOrSnack
) VALUES
('Crispy Chilli Turkey Noodles', 520, 35, 40, 6, 2, 25, 5, 18, 75, 950, 70, 2.1, 'Turkey mince, udon noodles, garlic, chili flakes, soy sauce, honey, spring onions, sesame oil', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Teriyaki Chicken Rice Bowl', 600, 40, 55, 12, 3, 18, 6, 12, 80, 850, 40, 2.5, 'Chicken thigh, jasmine rice, teriyaki sauce, broccoli, sesame seeds', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Beef and Vegetable Stir Fry', 650, 45, 30, 8, 4, 30, 10, 18, 100, 900, 50, 3.2, 'Beef strips, broccoli, carrots, soy sauce, garlic, ginger', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Grilled Salmon with Rice', 580, 42, 25, 1, 2, 25, 9, 16, 95, 700, 60, 3.8, 'Salmon fillet, white rice, lemon, dill, olive oil', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Chicken Alfredo Pasta', 700, 35, 50, 4, 2, 40, 16, 22, 105, 750, 100, 2.6, 'Chicken breast, fettuccine, alfredo sauce, parmesan, spinach', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Turkey and Cheese Sandwich', 480, 28, 35, 5, 2, 20, 8, 12, 60, 900, 60, 2.0, 'Turkey slices, whole wheat bread, cheddar cheese, lettuce, tomato', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Shrimp Fried Rice', 630, 35, 45, 5, 3, 28, 10, 18, 110, 950, 55, 3.1, 'Shrimp, white rice, peas, carrots, soy sauce, egg', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('BBQ Chicken Wrap', 550, 36, 40, 7, 3, 20, 8, 12, 85, 800, 45, 2.7, 'Chicken breast, whole wheat wrap, BBQ sauce, lettuce, cheese', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Pork Stir Fry Noodles', 670, 38, 50, 6, 2, 30, 12, 18, 120, 950, 50, 3.4, 'Pork strips, egg noodles, cabbage, soy sauce, sesame oil', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Tuna Pasta Salad', 510, 30, 35, 2, 3, 22, 8, 14, 85, 600, 70, 3.0, 'Tuna, pasta, mayonnaise, celery, peas', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Beef Taco Rice Bowl', 796, 42, 40, 6, 4, 26, 10.7, 15.3, 130, 918, 52, 4.9, 'Sample ingredients for beef taco rice bowl', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Chicken Caesar Wrap', 549, 41, 33, 4, 3, 24, 9.9, 14.1, 132, 937, 112, 2.1, 'Sample ingredients for chicken caesar wrap', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Grilled Fish with Couscous', 698, 39, 39, 1, 3, 26, 9.7, 16.3, 145, 979, 77, 3.6, 'Sample ingredients for grilled fish with couscous', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Lamb Gyros Plate', 799, 44, 52, 5, 5, 21, 6.9, 14.1, 138, 588, 85, 3.6, 'Sample ingredients for lamb gyros plate', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('BBQ Pork Fried Rice', 633, 33, 53, 1, 5, 35, 17.0, 18.0, 131, 976, 77, 3.0, 'Sample ingredients for bbq pork fried rice', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Shrimp Alfredo Pasta', 521, 37, 46, 2, 4, 23, 8.1, 14.9, 140, 683, 80, 2.7, 'Sample ingredients for shrimp alfredo pasta', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Turkey Pesto Sandwich', 466, 38, 48, 3, 5, 34, 11.3, 22.7, 67, 825, 88, 3.5, 'Sample ingredients for turkey pesto sandwich', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Steak and Potato Skillet', 606, 43, 30, 4, 3, 36, 15.8, 20.2, 131, 884, 100, 3.7, 'Sample ingredients for steak and potato skillet', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Salmon Sushi Rolls', 521, 42, 46, 4, 3, 34, 11.3, 22.7, 149, 631, 107, 4.5, 'Sample ingredients for salmon sushi rolls', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Pork Banh Mi', 564, 43, 42, 8, 1, 33, 11.0, 22.0, 84, 844, 118, 2.2, 'Sample ingredients for pork banh mi', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Chicken and Waffles', 523, 38, 53, 7, 2, 37, 17.1, 19.9, 117, 779, 88, 2.8, 'Sample ingredients for chicken and waffles', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Beef Burrito', 738, 38, 37, 10, 2, 20, 7.1, 12.9, 91, 540, 112, 4.0, 'Sample ingredients for beef burrito', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Butter Chicken and Rice', 734, 50, 40, 1, 1, 26, 11.8, 14.2, 144, 569, 100, 2.3, 'Sample ingredients for butter chicken and rice', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Chicken Teriyaki Skewers', 701, 35, 49, 8, 3, 28, 12.0, 16.0, 146, 885, 58, 4.9, 'Sample ingredients for chicken teriyaki skewers', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Prawn Coconut Curry', 725, 49, 34, 2, 1, 24, 8.6, 15.4, 72, 582, 89, 3.4, 'Sample ingredients for prawn coconut curry', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Ham and Cheese Croissant', 693, 47, 45, 1, 1, 33, 12.7, 20.3, 86, 683, 56, 3.9, 'Sample ingredients for ham and cheese croissant', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Fish Tacos', 676, 39, 50, 7, 2, 37, 14.4, 22.6, 69, 588, 66, 4.7, 'Sample ingredients for fish tacos', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Steak and Egg Breakfast Plate', 654, 35, 54, 4, 3, 32, 9.7, 22.3, 73, 696, 59, 4.5, 'Sample ingredients for steak and egg breakfast plate', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Grilled Chicken Quesadilla', 518, 49, 49, 3, 2, 32, 11.5, 20.5, 111, 967, 52, 4.9, 'Sample ingredients for grilled chicken quesadilla', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Seafood Paella', 506, 34, 58, 9, 4, 23, 7.1, 15.9, 129, 907, 109, 2.9, 'Sample ingredients for seafood paella', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Chili Con Carne', 578, 40, 60, 8, 2, 28, 11.2, 16.8, 150, 894, 76, 3.8, 'Sample ingredients for chili con carne', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Pulled Pork Tacos', 773, 42, 57, 3, 3, 20, 9.9, 10.1, 98, 967, 116, 3.3, 'Sample ingredients for pulled pork tacos', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Chicken Tikka Masala', 733, 30, 49, 10, 3, 23, 7.7, 15.3, 149, 690, 52, 3.5, 'Sample ingredients for chicken tikka masala', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Crab Cakes', 458, 32, 56, 5, 2, 31, 12.7, 18.3, 63, 632, 71, 4.7, 'Sample ingredients for crab cakes', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Grilled Lamb Chops', 498, 34, 53, 5, 3, 34, 15.0, 19.0, 84, 547, 46, 2.8, 'Sample ingredients for grilled lamb chops', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Pork Schnitzel Burger', 671, 35, 54, 2, 4, 22, 9.2, 12.8, 113, 989, 115, 4.3, 'Sample ingredients for pork schnitzel burger', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Korean BBQ Beef Bowl', 731, 35, 31, 8, 2, 31, 12.1, 18.9, 86, 967, 69, 4.0, 'Sample ingredients for korean bbq beef bowl', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Tuna Nicoise Salad', 738, 39, 40, 5, 3, 25, 8.4, 16.6, 61, 520, 104, 2.3, 'Sample ingredients for tuna nicoise salad', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Turkey Meatballs and Pasta', 687, 37, 53, 4, 2, 33, 13.0, 20.0, 139, 966, 83, 4.7, 'Sample ingredients for turkey meatballs and pasta', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Chicken Parmesan', 726, 38, 58, 7, 1, 34, 11.4, 22.6, 71, 707, 66, 3.7, 'Sample ingredients for chicken parmesan', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Shrimp Spring Rolls', 659, 46, 38, 10, 3, 29, 9.2, 19.8, 112, 809, 94, 3.9, 'Sample ingredients for shrimp spring rolls', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Beef Stroganoff', 719, 50, 42, 9, 1, 36, 13.7, 22.3, 134, 894, 102, 3.7, 'Sample ingredients for beef stroganoff', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Grilled Salmon Caesar Salad', 638, 31, 34, 3, 1, 20, 6.5, 13.5, 89, 702, 101, 3.4, 'Sample ingredients for grilled salmon caesar salad', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Pork Adobo Rice Bowl', 796, 50, 33, 6, 3, 21, 10.4, 10.6, 145, 805, 79, 4.6, 'Sample ingredients for pork adobo rice bowl', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Chicken Fried Rice', 630, 36, 37, 7, 4, 30, 11.6, 18.4, 64, 925, 50, 3.7, 'Sample ingredients for chicken fried rice', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Beef Enchiladas', 719, 45, 43, 3, 4, 38, 16.4, 21.6, 80, 963, 79, 3.3, 'Sample ingredients for beef enchiladas', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Chicken Shawarma Plate', 766, 43, 41, 8, 5, 40, 17.3, 22.7, 102, 518, 54, 4.5, 'Sample ingredients for chicken shawarma plate', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Seafood Pasta', 732, 49, 41, 8, 2, 21, 9.0, 12.0, 140, 886, 69, 3.8, 'Sample ingredients for seafood pasta', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Pork Dumplings', 781, 37, 49, 6, 1, 35, 14.5, 20.5, 139, 684, 62, 2.6, 'Sample ingredients for pork dumplings', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Chicken Fajitas', 491, 30, 42, 1, 4, 28, 10.2, 17.8, 63, 585, 76, 2.3, 'Sample ingredients for chicken fajitas', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Beef Kofta Wraps', 774, 32, 57, 2, 5, 20, 8.7, 11.3, 83, 687, 109, 4.2, 'Sample ingredients for beef kofta wraps', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Shrimp Pad Thai', 519, 36, 38, 10, 3, 25, 10.9, 14.1, 120, 761, 62, 3.0, 'Sample ingredients for shrimp pad thai', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Turkey Avocado Wrap', 494, 31, 39, 5, 2, 20, 7.6, 12.4, 144, 842, 96, 4.0, 'Sample ingredients for turkey avocado wrap', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Bacon Cheeseburger', 640, 48, 34, 5, 5, 24, 8.5, 15.5, 120, 792, 102, 4.0, 'Sample ingredients for bacon cheeseburger', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Thai Chicken Curry', 692, 32, 51, 10, 4, 27, 9.8, 17.2, 88, 661, 85, 3.8, 'Sample ingredients for thai chicken curry', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Baked Fish and Chips', 734, 32, 50, 1, 5, 23, 9.9, 13.1, 149, 653, 64, 2.2, 'Sample ingredients for baked fish and chips', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Pork Roast with Veggies', 665, 39, 49, 4, 5, 35, 13.7, 21.3, 122, 868, 74, 3.1, 'Sample ingredients for pork roast with veggies', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Lamb Curry', 601, 38, 52, 6, 3, 28, 11.0, 17.0, 61, 521, 91, 2.7, 'Sample ingredients for lamb curry', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Chicken Alfredo Pizza', 627, 42, 59, 1, 3, 31, 9.4, 21.6, 80, 834, 63, 3.7, 'Sample ingredients for chicken alfredo pizza', 5, 'Contains soy and gluten', TRUE, 'Meal'),
('Beef Brisket Sandwich', 700, 34, 54, 8, 5, 32, 11.3, 20.7, 133, 517, 78, 2.7, 'Sample ingredients for beef brisket sandwich', 5, 'Contains soy and gluten', TRUE, 'Meal'),

('Chicken & Vegetable Stir Fry', 420, 30, 35, 8, 6, 18, 4, 12, 80, 720, 60, 3.0,
 'Chicken breast, broccoli, bell peppers, carrots, snap peas, garlic, ginger, soy sauce, sesame oil, rice',
 5, 'Contains soy', TRUE, 'Meal'),

('Mediterranean Quinoa Bowl', 450, 20, 55, 8, 10, 18, 4, 12, 60, 580, 120, 4.2,
 'Quinoa, chicken, feta cheese, cucumber, tomatoes, olives, red onion, parsley, lemon juice, olive oil',
 5, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Taco Salad with Ground Turkey', 480, 32, 35, 8, 12, 25, 8, 15, 90, 750, 200, 3.5,
 'Ground turkey, romaine lettuce, black beans, corn, tomatoes, avocado, cheddar, tortilla chips, lime',
 5, 'Contains dairy', TRUE, 'Meal'),

('Salmon & Roasted Vegetables', 420, 35, 25, 6, 8, 18, 4, 12, 80, 450, 80, 2.8,
 'Salmon fillet, broccoli, carrots, zucchini, red onion, olive oil, lemon, garlic, dill',
 5, 'Gluten-free', TRUE, 'Meal'),

('Vietnamese Pho with Beef', 480, 30, 60, 4, 3, 10, 3, 6, 80, 980, 60, 4.5,
 'Rice noodles, beef sirloin, bean sprouts, basil, lime, jalapeño, hoisin sauce, sriracha, beef broth',
 5, 'Contains soy', TRUE, 'Meal'),

('Turkey Chili', 420, 35, 40, 10, 12, 10, 2, 7, 80, 650, 100, 4.0,
 'Ground turkey, kidney beans, black beans, tomatoes, onion, bell pepper, garlic, chili powder, cumin',
 5, 'Gluten-free', TRUE, 'Meal'),

('Shrimp & Veggie Pasta Primavera', 450, 28, 55, 6, 5, 12, 3, 8, 160, 520, 120, 2.5,
 'Shrimp, whole wheat pasta, zucchini, cherry tomatoes, bell peppers, peas, garlic, olive oil, parmesan',
 5, 'Contains shellfish, dairy, and gluten', TRUE, 'Meal'),

('Chicken & Quinoa Power Bowl', 480, 35, 45, 5, 8, 16, 3, 11, 85, 480, 80, 4.2,
 'Chicken breast, quinoa, kale, avocado, sweet potato, red onion, feta cheese, lemon juice, olive oil',
 5, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Beef & Bean Burrito', 580, 30, 65, 5, 12, 22, 8, 12, 70, 850, 200, 5.0,
 'Ground beef, pinto beans, rice, cheddar cheese, flour tortilla, lettuce, tomato, salsa, sour cream',
 5, 'Contains dairy and gluten', TRUE, 'Meal'),

('Grilled Chicken Caesar Salad', 380, 35, 15, 3, 4, 22, 5, 15, 95, 720, 180, 2.0,
 'Chicken breast, romaine lettuce, parmesan cheese, croutons, caesar dressing, lemon juice, black pepper',
 5, 'Contains dairy, gluten, and eggs', TRUE, 'Meal'),

('Turkey & Avocado Wrap', 420, 30, 35, 4, 8, 18, 4, 12, 70, 680, 120, 2.5,
 'Turkey breast, avocado, whole wheat wrap, spinach, tomato, red onion, hummus, mustard',
 5, 'Contains gluten', TRUE, 'Meal'),

('Sweet Potato & Black Bean Breakfast Bowl', 450, 20, 55, 12, 10, 18, 3, 13, 10, 520, 100, 4.0,
 'Sweet potatoes, black beans, eggs, avocado, salsa, cilantro, lime juice, cumin, chili powder',
 5, 'Contains eggs, gluten-free', TRUE, 'Meal'),

('Teriyaki Chicken & Vegetables', 480, 35, 50, 20, 5, 10, 2, 7, 85, 1200, 60, 2.5,
 'Chicken breast, broccoli, carrots, snap peas, bell pepper, teriyaki sauce, ginger, garlic, brown rice',
 5, 'Contains soy', TRUE, 'Meal'),

('Mediterranean Lamb Bowl', 550, 35, 40, 5, 6, 28, 12, 14, 90, 620, 100, 4.5,
 'Ground lamb, quinoa, cucumber, tomatoes, kalamata olives, red onion, tzatziki sauce, feta cheese, mint',
 5, 'Contains dairy', TRUE, 'Meal'),

('Chicken & Vegetable Soup', 320, 25, 30, 8, 6, 10, 2, 7, 70, 850, 60, 2.5,
 'Chicken breast, carrots, celery, onion, garlic, peas, corn, chicken broth, thyme, bay leaves',
 5, 'Gluten-free', TRUE, 'Meal'),

('Beef & Vegetable Stew', 420, 30, 35, 10, 8, 18, 6, 10, 80, 780, 80, 4.5,
 'Beef chuck, potatoes, carrots, celery, onion, peas, garlic, tomato paste, beef broth, bay leaves, thyme',
 5, 'Gluten-free', TRUE, 'Meal'),

('Egg & Vegetable Breakfast Burrito', 450, 25, 45, 3, 6, 20, 8, 10, 380, 720, 200, 3.5,
 'Eggs, spinach, bell peppers, onion, black beans, cheddar cheese, flour tortilla, salsa, avocado',
 5, 'Contains dairy, gluten, and eggs', TRUE, 'Meal'),

('Thai Green Curry with Chicken', 520, 30, 40, 8, 6, 28, 18, 8, 85, 780, 100, 3.5,
 'Chicken thighs, green curry paste, coconut milk, bamboo shoots, bell peppers, thai basil, fish sauce, brown rice',
 5, 'Contains fish, gluten-free', TRUE, 'Meal'),

('Spaghetti Bolognese', 580, 30, 70, 10, 5, 18, 6, 10, 70, 750, 100, 4.5,
 'Ground beef, spaghetti, tomatoes, onion, carrot, celery, garlic, red wine, olive oil, parmesan',
 5, 'Contains dairy and gluten', TRUE, 'Meal'),

('Pork Chops with Roasted Vegetables', 450, 35, 25, 8, 6, 22, 7, 13, 85, 580, 60, 2.5,
 'Pork chops, sweet potatoes, brussels sprouts, red onion, garlic, rosemary, thyme, olive oil, balsamic vinegar',
 5, 'Gluten-free', TRUE, 'Meal'),

('Tuna Niçoise Salad', 380, 30, 25, 5, 7, 18, 3, 13, 90, 580, 100, 3.0,
 'Tuna, eggs, green beans, potatoes, tomatoes, olives, lettuce, dijon mustard, olive oil, lemon juice',
 5, 'Contains eggs and fish, gluten-free', TRUE, 'Meal'),

('Chicken Fajita Bowl', 520, 35, 50, 6, 8, 20, 5, 13, 85, 680, 120, 3.5,
 'Chicken breast, bell peppers, onion, brown rice, black beans, avocado, lime, cilantro, cumin, chili powder',
 5, 'Gluten-free', TRUE, 'Meal'),

('Beef & Broccoli Stir Fry', 450, 35, 35, 10, 5, 18, 5, 11, 80, 850, 100, 3.8,
 'Beef sirloin, broccoli, onion, garlic, ginger, soy sauce, sesame oil, brown sugar, rice',
 5, 'Contains soy', TRUE, 'Meal'),

('Shrimp & Sausage Jambalaya', 550, 32, 60, 5, 4, 20, 6, 12, 180, 980, 80, 4.5,
 'Shrimp, andouille sausage, rice, bell peppers, onion, celery, tomatoes, garlic, cajun seasoning, thyme',
 5, 'Contains shellfish, gluten-free', TRUE, 'Meal'),

('Turkey & Sweet Potato Skillet', 420, 30, 40, 12, 6, 15, 3, 10, 75, 580, 100, 3.5,
 'Ground turkey, sweet potatoes, kale, onion, garlic, cumin, paprika, olive oil, chicken broth',
 5, 'Gluten-free', TRUE, 'Meal'),

('Chicken Caesar Wrap', 480, 35, 40, 3, 5, 22, 6, 14, 90, 750, 200, 2.5,
 'Chicken breast, whole wheat wrap, romaine lettuce, parmesan cheese, caesar dressing, bacon bits',
 5, 'Contains dairy and gluten', TRUE, 'Meal'),

('Beef & Quinoa Stuffed Bell Peppers', 420, 28, 35, 8, 7, 18, 6, 10, 70, 620, 100, 4.0,
 'Ground beef, quinoa, bell peppers, tomatoes, onion, garlic, spinach, oregano, cheese',
 5, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Mediterranean Baked Cod', 380, 35, 20, 5, 5, 15, 2, 11, 80, 520, 80, 2.0,
 'Cod fillet, cherry tomatoes, olives, capers, red onion, garlic, lemon, olive oil, parsley',
 5, 'Gluten-free', TRUE, 'Meal'),

('Breakfast Hash with Eggs', 450, 25, 40, 6, 5, 22, 8, 12, 380, 620, 100, 3.5,
 'Eggs, potatoes, bell peppers, onion, sausage, spinach, cheddar cheese, paprika, black pepper',
 5, 'Contains dairy and eggs, gluten-free', TRUE, 'Meal'),

('Cashew Chicken', 480, 35, 35, 8, 3, 22, 5, 15, 85, 850, 80, 3.0,
 'Chicken breast, cashews, bell peppers, onion, garlic, ginger, soy sauce, brown sugar, rice',
 5, 'Contains soy and nuts', TRUE, 'Meal'),

('Beef & Mushroom Stroganoff', 520, 30, 45, 4, 3, 28, 12, 14, 80, 720, 100, 3.8,
 'Beef sirloin, mushrooms, onion, garlic, sour cream, beef broth, Worcestershire sauce, egg noodles, parsley',
 5, 'Contains dairy, gluten, and eggs', TRUE, 'Meal'),

('Grilled Salmon with Quinoa Salad', 450, 35, 30, 5, 6, 20, 4, 14, 80, 480, 100, 3.0,
 'Salmon fillet, quinoa, cucumber, cherry tomatoes, red onion, feta cheese, lemon juice, olive oil, dill',
 5, 'Contains dairy and fish, gluten-free', TRUE, 'Meal'),

('Tex-Mex Bowl', 550, 30, 60, 8, 12, 22, 7, 13, 80, 780, 200, 4.5,
 'Ground beef, rice, black beans, corn, tomatoes, avocado, cheddar cheese, lime, cilantro, cumin',
 5, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Asian Lettuce Wraps', 380, 28, 20, 8, 3, 20, 4, 14, 75, 620, 60, 2.5,
 'Ground chicken, water chestnuts, mushrooms, onion, garlic, ginger, soy sauce, hoisin sauce, lettuce leaves',
 5, 'Contains soy, gluten-free', TRUE, 'Meal'),

('Pork & Pineapple Stir Fry', 450, 30, 45, 20, 4, 18, 5, 11, 80, 750, 80, 3.0,
 'Pork tenderloin, pineapple, bell pepper, broccoli, onion, garlic, ginger, soy sauce, sesame oil, rice',
 5, 'Contains soy', TRUE, 'Meal'),

('Lentil & Sausage Soup', 420, 28, 40, 6, 12, 16, 5, 9, 60, 780, 100, 5.0,
 'Italian sausage, lentils, carrots, celery, onion, garlic, tomatoes, spinach, chicken broth, rosemary',
 5, 'Gluten-free', TRUE, 'Meal'),

('Chicken & Hummus Plate', 450, 35, 30, 4, 8, 20, 4, 14, 85, 580, 120, 3.5,
 'Chicken breast, hummus, cucumber, cherry tomatoes, feta cheese, kalamata olives, pita bread, tzatziki',
 5, 'Contains dairy and gluten', TRUE, 'Meal'),

('Beef & Black Bean Enchiladas', 580, 30, 65, 8, 10, 22, 10, 10, 75, 950, 350, 4.5,
 'Ground beef, black beans, corn tortillas, enchilada sauce, cheese, onion, garlic, cumin, sour cream',
 5, 'Contains dairy', TRUE, 'Meal'),

('Tuna Salad Sandwich', 450, 30, 35, 5, 5, 22, 4, 16, 60, 680, 120, 3.0,
 'Canned tuna, whole grain bread, celery, red onion, mayo, dijon mustard, lettuce, tomato, pickle',
 5, 'Contains gluten and fish', TRUE, 'Meal'),

('One-Pot Chicken & Rice', 520, 35, 60, 3, 4, 15, 3, 10, 85, 680, 60, 3.0,
 'Chicken thighs, rice, carrots, peas, onion, garlic, chicken broth, thyme, bay leaf, olive oil',
 5, 'Gluten-free', TRUE, 'Meal'),

('Pork Tenderloin with Roasted Vegetables', 450, 35, 30, 10, 6, 18, 4, 12, 85, 580, 80, 3.0,
 'Pork tenderloin, sweet potatoes, brussels sprouts, onion, garlic, olive oil, balsamic vinegar, rosemary',
 5, 'Gluten-free', TRUE, 'Meal'),

('Turkey Burger with Sweet Potato Fries', 520, 35, 45, 8, 7, 22, 5, 15, 85, 680, 100, 3.5,
 'Ground turkey, whole wheat bun, lettuce, tomato, onion, avocado, sweet potatoes, olive oil, paprika',
 5, 'Contains gluten', TRUE, 'Meal'),

('Shrimp & Mango Rice Bowl', 450, 25, 60, 15, 5, 12, 2, 9, 170, 580, 80, 2.5,
 'Shrimp, brown rice, mango, avocado, cucumber, red bell pepper, cilantro, lime juice, honey',
 5, 'Contains shellfish, gluten-free', TRUE, 'Meal'),

('Chicken & Spinach Quesadilla', 480, 30, 35, 3, 5, 25, 10, 13, 85, 750, 350, 3.0,
 'Chicken breast, whole wheat tortilla, spinach, onion, cheddar cheese, Greek yogurt, salsa',
 5, 'Contains dairy and gluten', TRUE, 'Meal'),

('Beef & Potato Hash', 520, 30, 45, 5, 5, 25, 10, 13, 80, 620, 60, 4.0,
 'Ground beef, potatoes, bell peppers, onion, garlic, eggs, paprika, olive oil, thyme',
 5, 'Contains eggs, gluten-free', TRUE, 'Meal'),

('Teriyaki Salmon Bowl', 480, 30, 55, 15, 4, 16, 3, 11, 80, 850, 60, 2.5,
 'Salmon fillet, brown rice, broccoli, carrots, edamame, teriyaki sauce, sesame seeds, green onions',
 5, 'Contains soy and fish', TRUE, 'Meal'),

('Buffalo Chicken Wrap', 520, 35, 40, 5, 3, 25, 8, 15, 90, 980, 200, 2.5,
 'Chicken breast, whole wheat wrap, buffalo sauce, romaine lettuce, tomato, blue cheese dressing, celery',
 5, 'Contains dairy and gluten', TRUE, 'Meal'),

('Lemon Garlic Shrimp Pasta', 520, 28, 60, 3, 4, 18, 4, 12, 160, 650, 100, 3.0,
 'Shrimp, whole wheat pasta, cherry tomatoes, spinach, garlic, lemon juice, olive oil, parmesan cheese',
 5, 'Contains shellfish, dairy, and gluten', TRUE, 'Meal'),

('Turkey & Veggie Stuffed Peppers', 420, 30, 30, 8, 5, 18, 5, 11, 75, 620, 150, 3.5,
 'Ground turkey, bell peppers, zucchini, onion, garlic, quinoa, tomato sauce, mozzarella cheese, oregano',
 5, 'Contains dairy, gluten-free', TRUE, 'Meal'),

('Hawaiian Chicken Bowl', 480, 35, 55, 15, 5, 12, 2, 9, 85, 680, 60, 2.5,
 'Chicken breast, pineapple, bell peppers, onion, brown rice, teriyaki sauce, green onions, sesame seeds',
 5, 'Contains soy', TRUE, 'Meal'),

('Classic BLT Sandwich', 450, 20, 35, 6, 4, 25, 8, 15, 60, 850, 100, 3.0,
 'Bacon, whole grain bread, lettuce, tomato, mayonnaise, avocado',
 5, 'Contains gluten', TRUE, 'Meal'),

('Honey Garlic Glazed Salmon', 420, 35, 20, 15, 2, 20, 4, 14, 80, 580, 60, 2.0,
 'Salmon fillet, honey, soy sauce, garlic, ginger, lemon juice, broccoli, brown rice',
 5, 'Contains soy and fish', TRUE, 'Meal');


-- Mixed diet snacks

INSERT INTO meals (
  MealName, Calories_cal, Protein_g, Carbs_g, Sugars_g, Fibers_g,
  Fat_g, SatFat_g, UnsatFat_g, Cholesterol_mg, Sodium_mg, Calcium_mg, Iron_mg,
  Ingredients, CategoryID, DietNotes, IsHomeCooked, IsMealorSnack
)
VALUES
('Trail Mix', 163, 5, 12, 6, 3, 12, 2, 10, 0, 5, 34, 1.2, 
  'Almonds, cashews, walnuts, dried cranberries, dark chocolate chips', 2, 'GF, NF', FALSE, 'Snack'),
  
('Hummus with Carrot Sticks', 210, 7, 23, 5, 6, 11, 1.5, 9.5, 0, 375, 45, 1.8, 
  'Chickpeas, tahini, lemon juice, garlic, olive oil, carrots', 3, 'GF', TRUE, 'Snack'),
  
('Greek Yogurt with Honey', 180, 17, 18, 17, 0, 4.5, 3, 1.5, 15, 65, 200, 0.1, 
  'Greek yogurt, honey, cinnamon', 2, 'GF', FALSE, 'Snack'),
  
('Rice Cakes with Avocado', 145, 3, 17, 0, 4, 8, 1, 7, 0, 105, 12, 0.4, 
  'Rice cakes, avocado, salt, pepper, lemon juice', 3, 'GF', TRUE, 'Snack'),

('Edamame', 122, 11, 10, 2, 5, 5, 0.5, 4.5, 0, 9, 60, 2.3, 
  'Soybeans, sea salt', 3, 'GF', FALSE, 'Snack'),

('Beef Jerky', 116, 13, 7, 6, 0, 3, 1.5, 1.5, 25, 470, 5, 1.5, 
  'Beef, salt, sugar, spices, smoke flavor', 5, 'GF, No Pork', FALSE, 'Snack'),

('Crispy Roasted Chickpeas', 120, 6, 16, 1, 4, 3, 0.5, 2.5, 0, 170, 43, 1.1,
  'Chickpeas, olive oil, cumin, paprika, salt', 3, 'GF', TRUE, 'Snack'),

('Cheese and Crackers', 220, 8, 20, 2, 1, 13, 7, 6, 30, 400, 200, 0.6,
  'Cheddar cheese, whole grain crackers', 2, 'No', FALSE, 'Snack'),

('Fruit Leather', 80, 0, 20, 12, 1, 0, 0, 0, 0, 10, 10, 0.3,
  'Pureed fruits, honey', 3, 'GF', TRUE, 'Snack'),

('Kale Chips', 110, 3, 11, 0, 2, 7, 1, 6, 0, 180, 90, 1.7,
  'Kale, olive oil, nutritional yeast, salt', 3, 'GF', TRUE, 'Snack'),

('Peanut Butter Apple Slices', 190, 5, 22, 15, 4, 10, 2, 8, 0, 75, 20, 0.5,
  'Apple, peanut butter', 3, 'No Fish', TRUE, 'Snack'),

('Seaweed Snacks', 30, 1, 3, 0, 1, 2, 0, 2, 0, 120, 15, 0.7,
  'Seaweed, sesame oil, salt', 3, 'GF', FALSE, 'Snack'),

('Protein Shake', 160, 20, 7, 3, 1, 3, 1, 2, 5, 120, 250, 1.0,
  'Whey protein, milk, banana, ice', 2, 'GF', TRUE, 'Snack'),

('Popcorn', 100, 3, 20, 0, 4, 2, 0.5, 1.5, 0, 200, 3, 0.9,
  'Popcorn kernels, olive oil, salt', 3, 'GF', TRUE, 'Snack'),

('Hard-Boiled Egg', 78, 6, 1, 0, 0, 5, 1.5, 3.5, 212, 62, 25, 0.6,
  'Egg', 2, 'GF, No Fish, No Pork', TRUE, 'Snack'),

('Chocolate Protein Ball', 110, 7, 11, 5, 3, 5, 1.5, 3.5, 0, 35, 35, 2.1,
  'Dates, protein powder, cocoa powder, almond butter, chia seeds', 3, 'GF', TRUE, 'Snack'),

('Veggie Chips', 140, 2, 16, 2, 3, 7, 0.5, 6.5, 0, 220, 30, 1.3,
  'Sweet potatoes, beets, carrots, olive oil, sea salt', 3, 'GF', FALSE, 'Snack'),

('Chia Pudding', 170, 6, 15, 8, 8, 10, 1, 9, 0, 45, 180, 2.2,
  'Chia seeds, almond milk, honey, vanilla, berries', 3, 'GF, NF', TRUE, 'Snack'),

('Tuna Salad Cucumber Boats', 140, 15, 4, 2, 1, 7, 1, 6, 30, 350, 20, 0.9,
  'Tuna, Greek yogurt, dill, cucumber, lemon juice', 4, 'GF, No Pork', TRUE, 'Snack'),

('Chocolate Covered Almonds', 200, 5, 15, 10, 4, 15, 4, 11, 5, 10, 80, 1.1,
  'Almonds, dark chocolate, cocoa powder', 2, 'GF', FALSE, 'Snack'),

-- Additional snacks from original data
('Roasted Pumpkin Seeds', 126, 5, 5, 0, 3, 10, 2, 8, 0, 5, 20, 2.5,
  'Pumpkin seeds, olive oil, salt, paprika', 3, 'GF', TRUE, 'Snack'),

('Veggie Sticks with Guacamole', 160, 2, 14, 3, 7, 11, 2, 9, 0, 250, 30, 0.8,
  'Avocado, lime juice, onion, tomato, cilantro, bell peppers, carrots, celery', 3, 'GF', TRUE, 'Snack'),

('Cottage Cheese with Pineapple', 140, 14, 11, 10, 1, 3, 2, 1, 15, 430, 100, 0.3,
  'Cottage cheese, pineapple chunks', 2, 'GF', FALSE, 'Snack'),

('Protein Bar', 220, 20, 23, 14, 7, 7, 2.5, 4.5, 10, 190, 50, 3.6,
  'Protein blend, dates, nuts, chocolate chips', 2, 'No', FALSE, 'Snack'),
  
('Stuffed Grape Leaves', 160, 3, 20, 1, 4, 8, 1, 7, 0, 320, 45, 1.5,
  'Grape leaves, rice, herbs, olive oil, lemon juice', 3, 'GF', FALSE, 'Snack'),

('Chocolate Banana Smoothie', 200, 5, 35, 20, 5, 4, 2, 2, 5, 70, 200, 1.2,
  'Banana, cocoa powder, milk, honey, ice', 2, 'GF', TRUE, 'Snack'),

('Smoked Salmon Rice Cakes', 130, 10, 13, 0, 1, 5, 1, 4, 10, 350, 15, 0.5,
  'Rice cakes, smoked salmon, cream cheese, dill', 4, 'GF, No Pork', FALSE, 'Snack'),

('Deviled Eggs', 145, 6, 1, 0, 0, 13, 3, 10, 215, 150, 30, 0.6,
  'Eggs, mayonnaise, mustard, paprika, salt', 2, 'GF, No Fish, No Pork', TRUE, 'Snack'),

('Fruit and Nut Bar', 185, 4, 21, 15, 3, 10, 1, 9, 0, 5, 25, 1.0,
  'Dates, almonds, cashews, dried apricots', 3, 'GF', FALSE, 'Snack'),

('Tzatziki with Pita', 180, 6, 20, 3, 2, 8, 4, 4, 10, 340, 120, 1.2,
  'Greek yogurt, cucumber, garlic, dill, olive oil, pita bread', 2, 'No', TRUE, 'Snack'),

('Buffalo Cauliflower Bites', 120, 3, 17, 3, 4, 5, 1, 4, 0, 380, 25, 0.7,
  'Cauliflower, flour, buffalo sauce, garlic powder', 3, 'No', TRUE, 'Snack'),

('Avocado Chocolate Mousse', 180, 3, 19, 12, 8, 12, 3, 9, 0, 5, 20, 1.8,
  'Avocado, cocoa powder, maple syrup, almond milk, vanilla', 3, 'GF', TRUE, 'Snack'),

('Coconut Date Rolls', 150, 1, 26, 24, 3, 6, 5, 1, 0, 15, 15, 0.4,
  'Dates, shredded coconut, almonds', 3, 'GF', TRUE, 'Snack'),

('Mini Caprese Skewers', 110, 7, 2, 1, 0, 9, 4, 5, 15, 170, 200, 0.3,
  'Cherry tomatoes, fresh mozzarella, basil, olive oil, balsamic glaze', 2, 'GF, No Fish, No Pork', TRUE, 'Snack'),

('Biltong', 90, 16, 1, 0, 0, 2, 1, 1, 30, 420, 10, 2.3,
  'Beef, vinegar, salt, spices', 5, 'GF, No Pork', FALSE, 'Snack'),

('Energy Balls', 135, 3, 18, 13, 2, 6, 1, 5, 0, 3, 30, 1.2,
  'Oats, peanut butter, honey, chia seeds, chocolate chips', 2, 'No', TRUE, 'Snack'),

('Cucumber Sushi Rolls', 80, 3, 15, 2, 2, 0.5, 0, 0.5, 0, 320, 15, 0.9,
  'Cucumber, rice, nori, avocado, carrot, rice vinegar', 3, 'GF', TRUE, 'Snack'),

('Feta and Watermelon Cubes', 130, 5, 13, 11, 1, 7, 5, 2, 25, 260, 150, 0.4,
  'Watermelon, feta cheese, mint leaves', 2, 'GF', TRUE, 'Snack'),

('Wasabi Peas', 120, 5, 19, 2, 2, 2, 0, 2, 0, 240, 20, 1.0,
  'Green peas, starch, wasabi, salt', 3, 'GF', FALSE, 'Snack'),

('Almond Flour Crackers', 150, 6, 10, 1, 3, 11, 1, 10, 0, 180, 60, 1.2,
  'Almond flour, flaxseed, olive oil, herbs, salt', 3, 'GF', TRUE, 'Snack'),

('Olives and Cheese', 140, 7, 2, 0, 1, 12, 5, 7, 15, 560, 180, 0.5,
  'Kalamata olives, feta cheese, olive oil, herbs', 2, 'GF', FALSE, 'Snack'),

('Lentil Chips', 130, 5, 18, 1, 3, 4, 0.5, 3.5, 0, 170, 20, 1.8,
  'Lentil flour, potato starch, sunflower oil, salt', 3, 'GF', FALSE, 'Snack'),

('Turkey Roll-Ups', 120, 15, 2, 1, 0, 6, 2, 4, 35, 450, 20, 0.8,
  'Turkey slices, cream cheese, bell peppers, spinach', 5, 'GF, No Pork', TRUE, 'Snack'),

('Frozen Yogurt Bark', 110, 6, 15, 12, 1, 2, 1, 1, 5, 40, 150, 0.2,
  'Greek yogurt, honey, berries, dark chocolate chips', 2, 'GF', TRUE, 'Snack'),

('Roasted Seaweed Tuna Wraps', 95, 12, 3, 0, 1, 4, 0.5, 3.5, 15, 280, 15, 1.0,
  'Seaweed sheets, tuna, avocado, cucumber, sesame seeds', 4, 'GF, No Pork', TRUE, 'Snack'),

('Flaxseed Crackers', 140, 5, 6, 0, 5, 11, 1, 10, 0, 120, 40, 1.6,
  'Flaxseeds, chia seeds, sunflower seeds, herbs, salt', 3, 'GF', TRUE, 'Snack'),

('Jackfruit Jerky', 70, 1, 15, 8, 3, 0, 0, 0, 0, 320, 30, 1.2,
  'Jackfruit, soy sauce, maple syrup, liquid smoke, spices', 3, 'No', FALSE, 'Snack'),

('Chocolate Ricotta Dip', 160, 10, 13, 11, 1, 7, 4, 3, 25, 45, 150, 0.3,
  'Ricotta cheese, cocoa powder, honey, vanilla, strawberries', 2, 'GF', TRUE, 'Snack'),

('Baked Plantain Chips', 150, 1, 29, 12, 3, 5, 2, 3, 0, 120, 5, 0.6,
  'Plantains, coconut oil, cinnamon, salt', 3, 'GF', TRUE, 'Snack'),

('Mini Frittata Bites', 130, 10, 3, 1, 0, 9, 3, 6, 185, 210, 100, 1.0,
  'Eggs, spinach, bell peppers, cheese, onions', 2, 'GF, No Fish, No Pork', TRUE, 'Snack'),
  
('Greek Yogurt Parfait', 280, 15, 35, 25, 5, 8, 5, 2, 25, 120, 300, 1.0,
 'Greek yogurt, granola, berries, honey, chia seeds',
 2, 'Contains dairy and gluten', TRUE, 'Snack'),

('Trail Mix', 420, 12, 35, 20, 6, 28, 4, 22, 0, 180, 80, 3.5,
 'Almonds, walnuts, cashews, pumpkin seeds, dried cranberries, dark chocolate chips',
 3, 'Contains nuts', TRUE, 'Snack'),

('Tuna Salad Lettuce Cups', 220, 25, 5, 2, 3, 12, 2, 9, 50, 480, 40, 1.5,
 'Canned tuna, Greek yogurt, celery, red onion, dill, lemon juice, lettuce leaves',
 4, 'Contains dairy, gluten-free', TRUE, 'Snack'),

('Beef Jerky', 150, 25, 5, 4, 0, 3, 1, 1, 40, 620, 20, 2.0,
 'Beef, soy sauce, Worcestershire sauce, honey, black pepper, garlic powder',
 1, 'Contains soy, gluten-free', TRUE, 'Snack'),

('Protein Energy Balls', 250, 10, 25, 15, 4, 14, 3, 10, 10, 120, 80, 2.0,
 'Oats, peanut butter, honey, whey protein, chia seeds, dark chocolate chips',
 5, 'Contains dairy and nuts', TRUE, 'Snack'),

('Caprese Salad Bites', 180, 10, 5, 3, 1, 12, 7, 4, 25, 220, 250, 0.8,
 'Cherry tomatoes, fresh mozzarella balls, basil, balsamic glaze, olive oil, salt, pepper',
 2, 'Contains dairy, gluten-free', TRUE, 'Snack'),

('Apple with Almond Butter', 280, 8, 35, 25, 8, 16, 2, 12, 0, 120, 80, 1.5,
 'Apple, almond butter, cinnamon',
 3, 'Contains nuts, gluten-free', TRUE, 'Snack'),

('Smoked Salmon Cucumber Rounds', 180, 15, 5, 2, 1, 12, 3, 8, 25, 580, 40, 0.8,
 'Smoked salmon, cucumber, cream cheese, dill, capers, lemon zest',
 4, 'Contains dairy and fish, gluten-free', TRUE, 'Snack'),

('Turkey Roll-Ups', 180, 20, 3, 2, 0, 10, 3, 6, 60, 580, 100, 1.0,
 'Turkey slices, cheese, lettuce, mustard',
 1, 'Contains dairy, gluten-free', TRUE, 'Snack'),

('Mini Quiches', 280, 15, 18, 2, 1, 18, 9, 8, 220, 420, 150, 1.5,
 'Eggs, milk, cheese, spinach, bacon, pie crust',
 5, 'Contains dairy, gluten, and eggs', TRUE, 'Snack'),

('Hummus & Veggie Plate', 250, 8, 25, 4, 8, 14, 2, 10, 0, 450, 80, 2.0,
 'Hummus, carrots, cucumber, bell peppers, cherry tomatoes, olives, pita bread',
 2, 'Contains gluten', TRUE, 'Snack'),

('Roasted Chickpeas', 220, 10, 30, 2, 8, 8, 1, 6, 0, 350, 60, 2.5,
 'Chickpeas, olive oil, cumin, paprika, garlic powder, sea salt',
 3, 'Gluten-free', TRUE, 'Snack'),

('Shrimp Cocktail', 150, 25, 5, 3, 1, 2, 0, 1, 170, 450, 60, 1.0,
 'Shrimp, cocktail sauce, lemon, parsley',
 4, 'Contains shellfish, gluten-free', TRUE, 'Snack'),

('Bacon-Wrapped Dates', 220, 8, 25, 20, 2, 12, 4, 7, 25, 480, 30, 1.0,
 'Dates, bacon, maple syrup',
 1, 'Gluten-free', TRUE, 'Snack'),

('Peanut Butter Banana Toast', 300, 12, 35, 15, 5, 14, 3, 9, 0, 280, 60, 2.0,
 'Whole grain bread, peanut butter, banana, honey, cinnamon',
 5, 'Contains gluten and nuts', TRUE, 'Snack'),

('Cheese & Fruit Plate', 320, 12, 25, 20, 3, 18, 10, 7, 45, 350, 300, 0.8,
 'Cheddar, brie, grapes, apple slices, walnuts, crackers, honey',
 2, 'Contains dairy, nuts, and gluten', TRUE, 'Snack'),

('Chia Pudding', 280, 8, 35, 15, 10, 14, 2, 10, 0, 150, 200, 3.0,
 'Chia seeds, almond milk, maple syrup, vanilla extract, berries',
 3, 'Gluten-free', TRUE, 'Snack'),

('Crab Stuffed Mushrooms', 220, 15, 10, 2, 2, 14, 5, 8, 80, 480, 100, 1.0,
 'Mushroom caps, crab meat, cream cheese, green onions, garlic, breadcrumbs, lemon juice',
 4, 'Contains shellfish, dairy, and gluten', TRUE, 'Snack'),

('Pepperoni Chips', 180, 10, 2, 0, 0, 15, 6, 8, 40, 850, 20, 1.0,
 'Pepperoni slices',
 1, 'Gluten-free', TRUE, 'Snack'),

('Deviled Eggs', 160, 10, 2, 1, 0, 12, 3, 8, 240, 320, 40, 1.0,
 'Eggs, mayonnaise, mustard, paprika, chives, salt, pepper',
 5, 'Contains eggs, gluten-free', TRUE, 'Snack'),

('Avocado Toast', 220, 6, 25, 2, 6, 12, 2, 9, 0, 280, 40, 1.5,
 'Whole grain bread, avocado, cherry tomatoes, microgreens, red pepper flakes, sea salt',
 2, 'Contains gluten', TRUE, 'Snack'),

('Kale Chips', 150, 5, 15, 1, 3, 9, 1, 7, 0, 320, 100, 1.5,
 'Kale, olive oil, nutritional yeast, garlic powder, sea salt',
 3, 'Gluten-free', TRUE, 'Snack'),

('Tuna Sushi Roll', 250, 12, 40, 2, 1, 5, 1, 3, 25, 550, 30, 1.0,
 'Nori, sushi rice, tuna, cucumber, avocado, sesame seeds, soy sauce, wasabi',
 4, 'Contains fish and soy', TRUE, 'Snack'),

('Mini Meatballs', 280, 22, 10, 2, 1, 18, 7, 9, 80, 500, 60, 2.0,
 'Ground beef, breadcrumbs, egg, onion, garlic, parsley, parmesan, olive oil',
 1, 'Contains dairy, gluten, and eggs', TRUE, 'Snack'),

('Chicken Quesadilla Triangles', 280, 18, 25, 2, 2, 14, 6, 7, 60, 550, 200, 1.5,
 'Flour tortilla, chicken breast, cheddar cheese, bell peppers, onion, salsa',
 5, 'Contains dairy and gluten', TRUE, 'Snack'),

('Spinach & Feta Mini Quiches', 260, 14, 15, 2, 1, 18, 9, 7, 160, 380, 200, 1.5,
 'Eggs, spinach, feta cheese, milk, pie crust, onion, garlic, nutmeg',
 2, 'Contains dairy, gluten, and eggs', TRUE, 'Snack'),

('Fruit & Nut Energy Balls', 240, 6, 25, 15, 4, 14, 2, 10, 0, 50, 60, 2.0,
 'Dates, oats, almond butter, flaxseed, chia seeds, dark chocolate chips, vanilla extract',
 3, 'Contains nuts', TRUE, 'Snack'),

('Salmon and Cream Cheese Pinwheels', 240, 15, 20, 2, 1, 12, 6, 5, 40, 580, 100, 1.0,
 'Smoked salmon, cream cheese, tortilla, capers, dill, lemon juice, red onion',
 4, 'Contains fish, dairy, and gluten', TRUE, 'Snack'),

('Chicken Salad Cucumber Boats', 220, 20, 5, 2, 2, 14, 3, 9, 65, 380, 40, 1.0,
 'Chicken breast, mayo, celery, grapes, walnuts, cucumber',
 1, 'Contains nuts, gluten-free', TRUE, 'Snack'),

('Yogurt and Granola Bowl', 250, 12, 35, 18, 4, 8, 3, 4, 15, 120, 250, 1.5,
 'Greek yogurt, granola, mixed berries, honey, almonds',
 5, 'Contains dairy, gluten, and nuts', TRUE, 'Snack'),

('Cottage Cheese with Fruit', 180, 15, 15, 12, 2, 5, 3, 1, 15, 400, 150, 0.5,
 'Cottage cheese, peaches, berries, honey, cinnamon',
 2, 'Contains dairy, gluten-free', TRUE, 'Snack'),

('Avocado & Cucumber Sushi Rolls', 220, 6, 30, 2, 5, 10, 1, 8, 0, 350, 40, 1.0,
 'Nori, sushi rice, avocado, cucumber, carrot, sesame seeds, rice vinegar, soy sauce',
 3, 'Contains soy', TRUE, 'Snack'),

('Tuna Stuffed Avocado', 280, 20, 12, 1, 8, 18, 3, 13, 45, 380, 50, 1.5,
 'Avocado, canned tuna, mayo, celery, red onion, lemon juice, salt, pepper',
 4, 'Contains fish, gluten-free', TRUE, 'Snack'),

('Ham and Cheese Roll-Ups', 200, 18, 2, 1, 0, 14, 7, 6, 55, 850, 250, 0.8,
 'Ham slices, cheese slices, cream cheese, green onions',
 1, 'Contains dairy, gluten-free', TRUE, 'Snack'),

('Vegetable and Hummus Wrap', 280, 10, 38, 4, 6, 12, 2, 9, 0, 480, 80, 2.5,
 'Whole wheat wrap, hummus, cucumber, carrot, bell pepper, spinach, olives',
 5, 'Contains gluten', TRUE, 'Snack'),

('Stuffed Mushrooms', 220, 10, 12, 3, 2, 16, 6, 8, 25, 350, 100, 1.2,
 'Mushroom caps, cream cheese, parmesan, garlic, breadcrumbs, parsley, olive oil',
 2, 'Contains dairy and gluten', TRUE, 'Snack'),

('Edamame', 180, 16, 15, 2, 8, 8, 1, 6, 0, 280, 60, 2.5,
 'Edamame beans, sea salt',
 3, 'Contains soy, gluten-free', TRUE, 'Snack'),

('Mini Crab Cakes', 220, 15, 18, 1, 1, 12, 3, 8, 80, 450, 80, 1.2,
 'Crab meat, breadcrumbs, egg, bell pepper, onion, mayonnaise, dijon mustard, Old Bay seasoning',
 4, 'Contains shellfish, gluten, and eggs', TRUE, 'Snack'),

('BBQ Chicken Wings', 320, 28, 5, 4, 0, 22, 6, 14, 120, 750, 40, 1.5,
 'Chicken wings, BBQ sauce, garlic powder, onion powder, paprika',
 1, 'Gluten-free', TRUE, 'Snack'),

('Apple and Cheese Slices', 200, 7, 25, 20, 4, 9, 5, 3, 25, 180, 200, 0.5,
 'Apple, cheddar cheese',
 5, 'Contains dairy, gluten-free', TRUE, 'Snack'),

('Tomato Soup with Grilled Cheese Dipper', 350, 12, 30, 8, 3, 20, 12, 6, 45, 650, 300, 1.5,
 'Tomatoes, vegetable broth, cream, bread, cheddar cheese, butter, basil',
 2, 'Contains dairy and gluten', TRUE, 'Snack'),

('Vegetable Spring Rolls', 250, 6, 35, 5, 4, 10, 1, 8, 0, 400, 45, 1.5,
 'Rice paper, carrots, cucumber, bell pepper, avocado, mint, basil, rice noodles, peanut sauce',
 3, 'Contains nuts', TRUE, 'Snack'),

('Seaweed Snacks', 50, 2, 5, 0, 1, 3, 0, 2, 0, 180, 20, 0.5,
 'Nori seaweed, olive oil, sea salt',
 4, 'Gluten-free', TRUE, 'Snack'),

('Salami and Cheese Bites', 250, 15, 2, 0, 0, 20, 9, 9, 60, 750, 200, 1.0,
 'Salami, cheddar cheese, olives',
 1, 'Contains dairy, gluten-free', TRUE, 'Snack'),

('Pizza Bagel Bites', 320, 15, 40, 3, 2, 12, 5, 6, 25, 580, 200, 2.0,
 'Mini bagels, pizza sauce, mozzarella cheese, pepperoni, dried oregano',
 5, 'Contains dairy and gluten', TRUE, 'Snack'),

('Egg Salad on Crackers', 280, 14, 18, 3, 2, 18, 5, 11, 280, 450, 80, 1.5,
 'Eggs, mayonnaise, mustard, celery, green onions, paprika, whole grain crackers',
 2, 'Contains eggs and gluten', TRUE, 'Snack'),

('Dark Chocolate Covered Strawberries', 180, 2, 25, 20, 4, 10, 6, 3, 0, 5, 25, 1.0,
 'Strawberries, dark chocolate, coconut oil',
 3, 'Gluten-free', TRUE, 'Snack'),

('Prawn and Mango Skewers', 180, 15, 15, 12, 2, 6, 1, 4, 120, 380, 40, 1.0,
 'Prawns, mango, lime juice, cilantro, olive oil, chili flakes',
 4, 'Contains shellfish, gluten-free', TRUE, 'Snack'),

('Prosciutto-Wrapped Asparagus', 160, 12, 5, 1, 2, 12, 3, 8, 25, 580, 30, 1.5,
 'Asparagus, prosciutto, olive oil, black pepper',
 1, 'Gluten-free', TRUE, 'Snack'),

('Fruit and Yogurt Smoothie', 220, 15, 35, 28, 3, 3, 2, 1, 10, 80, 300, 1.0,
 'Greek yogurt, banana, berries, honey, milk, ice',
 5, 'Contains dairy, gluten-free', TRUE, 'Snack');


-- Create views for common reporting needs
CREATE VIEW nutrition_summary AS
SELECT 
  m.MealName,
  dc.CategoryName AS DietCategory,
  m.Calories_cal,
  m.Protein_g,
  m.Carbs_g,
  m.Fat_g,
  m.IsMealorSnack
FROM meals m
JOIN diet_categories dc ON m.CategoryID = dc.CategoryID;

-- Create view for dietary restrictions
CREATE VIEW dietary_options AS
SELECT 
  m.MealName,
  dc.CategoryName,
  m.DietNotes,
  m.Calories_cal,
  (m.Protein_g / m.Calories_cal * 100) AS protein_pct,
  m.IsMealorSnack
FROM meals m
JOIN diet_categories dc ON m.CategoryID = dc.CategoryID
WHERE m.Calories_cal > 0
ORDER BY protein_pct DESC;

-- Create stored procedure for meal filtering
DELIMITER $$
CREATE PROCEDURE get_meals_by_nutrition(
  IN min_protein DECIMAL(5,2),
  IN max_calories SMALLINT
)
BEGIN
  SELECT 
    MealName, 
    Calories_cal,
    Protein_g,
    Carbs_g,
    Fat_g
  FROM meals
  WHERE Protein_g >= min_protein
  AND (Calories_cal <= max_calories OR max_calories IS NULL)
  ORDER BY Protein_g DESC;
END$$
DELIMITER ;

-- Create stored procedure for finding meals by ingredient
DELIMITER $$
CREATE PROCEDURE find_meals_with_ingredient(
  IN ingredient_name VARCHAR(100)
)
BEGIN
  SELECT 
    m.MealName,
    dc.CategoryName AS DietCategory,
    m.Calories_cal,
    m.Protein_g,
    m.Carbs_g,
    m.Fat_g,
    m.Ingredients
  FROM meals m
  JOIN diet_categories dc ON m.CategoryID = dc.CategoryID
  WHERE m.Ingredients LIKE CONCAT('%', ingredient_name, '%')
  ORDER BY m.Calories_cal;
END$$
DELIMITER ;

-- Create stored procedure for weekly meal planning
DELIMITER $$
CREATE PROCEDURE create_meal_plan(
  IN diet_category VARCHAR(100),
  IN max_daily_calories INT
)
BEGIN
  DECLARE target_category_id INT;
  
  -- Get the category ID
  SELECT CategoryID INTO target_category_id 
  FROM diet_categories 
  WHERE CategoryName = diet_category;
  
  -- Select meals for a 7-day plan
  (SELECT 
    m.MealName,
    'Breakfast' AS MealTime,
    m.Calories_cal,
    m.Protein_g,
    m.Carbs_g,
    m.Fat_g
  FROM meals m
  WHERE m.CategoryID = target_category_id
  AND m.Calories_cal < (max_daily_calories * 0.3)
  AND m.IsMealorSnack = 'Meal'
  LIMIT 7)
  
  UNION ALL
  
  (SELECT 
    m.MealName,
    'Lunch' AS MealTime,
    m.Calories_cal,
    m.Protein_g,
    m.Carbs_g,
    m.Fat_g
  FROM meals m
  WHERE m.CategoryID = target_category_id
  AND m.Calories_cal < (max_daily_calories * 0.35)
  AND m.IsMealorSnack = 'Meal'
  ORDER BY RAND()
  LIMIT 7)
  
  UNION ALL
  
  (SELECT 
    m.MealName,
    'Dinner' AS MealTime,
    m.Calories_cal,
    m.Protein_g,
    m.Carbs_g,
    m.Fat_g
  FROM meals m
  WHERE m.CategoryID = target_category_id
  AND m.Calories_cal < (max_daily_calories * 0.4)
  AND m.IsMealorSnack = 'Meal'
  ORDER BY RAND()
  LIMIT 7)
  
  UNION ALL
  
  (SELECT 
    m.MealName,
    'Snack' AS MealTime,
    m.Calories_cal,
    m.Protein_g,
    m.Carbs_g,
    m.Fat_g
  FROM meals m
  WHERE m.CategoryID = target_category_id
  AND m.Calories_cal < (max_daily_calories * 0.15)
  AND m.IsMealorSnack = 'Snack'
  ORDER BY RAND()
  LIMIT 7);
END$$
DELIMITER ;


-- SELECT 
--     dc.CategoryName,
--     COUNT(*) AS TotalMeals
-- FROM meals m
-- JOIN diet_categories dc ON m.CategoryID = dc.CategoryID
-- GROUP BY dc.CategoryName
-- ORDER BY TotalMeals DESC;

-- -- More detailed breakdown by meal type (meal vs snack)
-- SELECT 
--     dc.CategoryName,
--     m.IsMealorSnack,
--     COUNT(*) AS Count
-- FROM meals m
-- JOIN diet_categories dc ON m.CategoryID = dc.CategoryID
-- GROUP BY dc.CategoryName, m.IsMealorSnack
-- ORDER BY dc.CategoryName, m.IsMealorSnack;

-- -- Breakdown of home-cooked vs store-bought by category
-- SELECT 
--     dc.CategoryName,
--     m.IsHomeCooked,
--     COUNT(*) AS Count
-- FROM meals m
-- JOIN diet_categories dc ON m.CategoryID = dc.CategoryID
-- GROUP BY dc.CategoryName, m.IsHomeCooked
-- ORDER BY dc.CategoryName, m.IsHomeCooked DESC;

-- -- Count total number of entries in the meals table
SELECT COUNT(*) AS TotalMeals FROM meals;

-- -- Count with breakdown by meal or snack
-- SELECT 
--     IsMealorSnack, 
--     COUNT(*) AS Count
-- FROM meals
-- GROUP BY IsMealorSnack;

-- Total count with percentage breakdown by category
SELECT 
    dc.CategoryName,
    COUNT(*) AS CategoryCount,
    ROUND((COUNT(*) / (SELECT COUNT(*) FROM meals)) * 100, 2) AS Percentage
FROM meals m
JOIN diet_categories dc ON m.CategoryID = dc.CategoryID
GROUP BY dc.CategoryName
ORDER BY CategoryCount DESC;

