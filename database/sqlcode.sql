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

  -- Omnivore Meals
-- Carnivore meals (CategoryID = 1)
('Crispy Chilli Turkey Noodles', 520, 35, 40, 6, 2, 25, 5, 18, 75, 950, 70, 2.1,
 'Turkey mince, udon noodles, garlic, chili flakes, soy sauce, honey, spring onions, sesame oil',
 1, 'Contains soy and gluten', TRUE, 'Meal'),

('Spicy Lamb & Feta Meatballs', 620, 38, 12, 5, 2, 45, 18, 20, 110, 700, 220, 3.0,
 'Lamb mince, feta cheese, onion, garlic, chili flakes, parsley, egg, breadcrumbs, olive oil, tomato sauce',
 1, 'Contains dairy and gluten', TRUE, 'Meal'),

('Turkey, Spinach & Feta Burgers', 520, 40, 20, 3, 2, 30, 9, 18, 95, 600, 180, 2.5,
 'Turkey mince, spinach, feta, egg, garlic, breadcrumbs, olive oil, burger buns',
 1, 'Contains gluten, dairy, and egg', TRUE, 'Meal'),

('Spinach & Feta Burgers', 520, 40, 20, 3, 2, 30, 9, 18, 95, 600, 180, 2.5,
 'Turkey mince, spinach, feta, egg, garlic, breadcrumbs, olive oil, burger buns',
 1, 'Contains gluten, dairy, and egg', TRUE, 'Meal'),

('Grilled Ribeye Steak', 650, 55, 0, 0, 0, 50, 20, 30, 140, 90, 20, 3.5,
  'ribeye steak, salt, pepper', 1, 'GF, NF, No Fish', TRUE, 'Meal'),
  
('Baked Chicken Thighs', 400, 38, 0, 0, 0, 25, 7, 18, 120, 85, 15, 1.5,
  'chicken thighs, olive oil, garlic powder', 1, 'GF, NF, No Fish', TRUE, 'Meal'),
  
('Pork Belly Slices', 600, 30, 0, 0, 0, 55, 20, 35, 110, 70, 10, 1.8,
  'pork belly, salt, paprika', 1, 'GF, NF', TRUE, 'Meal'),
  
('Lamb Chops', 550, 40, 0, 0, 0, 45, 18, 27, 115, 95, 25, 3.2,
  'lamb chops, rosemary, salt, pepper', 1, 'GF, NF, No Fish', TRUE, 'Meal'),
  
('Beef Liver Fry', 320, 42, 3, 1, 0, 12, 4, 8, 400, 90, 30, 6.0,
  'beef liver, butter, salt, onion powder', 1, 'GF, NF, No Fish', TRUE, 'Meal'),
  
('Grilled Turkey Breast', 280, 48, 0, 0, 0, 6, 2, 4, 90, 75, 15, 1.0,
  'turkey breast, olive oil, black pepper', 1, 'GF, NF, No Fish', TRUE, 'Meal'),
  
('Duck Breast with Skin', 500, 35, 0, 0, 0, 40, 15, 25, 115, 100, 20, 2.5,
  'duck breast, thyme, salt', 1, 'GF, NF, No Fish', TRUE, 'Meal'),

('Meatballs (Beef Only)', 470, 38, 2, 0.5, 0, 32, 12, 20, 100, 85, 22, 2.8,
  'ground beef, egg, salt, pepper', 1, 'GF, NF, No Fish', TRUE, 'Meal'),

('Roasted Quail', 330, 30, 0, 0, 0, 22, 8, 14, 90, 60, 15, 2.2,
  'quail, butter, rosemary, pepper', 1, 'GF, NF, No Fish', TRUE, 'Meal'),
  
('Venison Steak', 400, 50, 0, 0, 0, 18, 5, 13, 95, 65, 20, 4.0,
  'venison steak, garlic powder, salt', 1, 'GF, NF, No Fish', TRUE, 'Meal'),

('Beef Short Ribs', 700, 45, 0, 0, 0, 60, 22, 38, 130, 120, 25, 3.0,
  'beef short ribs, salt, pepper', 1, 'GF, NF, No Fish', TRUE, 'Meal'),
  
('Grilled Chicken Wings', 450, 35, 0, 0, 0, 30, 10, 20, 110, 140, 18, 1.6,
  'chicken wings, paprika, salt', 1, 'GF, NF, No Fish', TRUE, 'Snack'),
  
('Roasted Duck Legs', 600, 38, 0, 0, 0, 50, 18, 32, 125, 105, 22, 2.7,
  'duck legs, garlic, thyme, olive oil', 1, 'GF, NF, No Fish', TRUE, 'Meal'),
  
('Pork Chops', 520, 40, 0, 0, 0, 40, 15, 25, 115, 90, 18, 2.0, 
  'pork chops, sage, salt', 1, 'GF, NF', TRUE, 'Meal'),

('Grilled Kangaroo Fillet', 360, 48, 0, 0, 0, 15, 5, 10, 90, 80, 20, 4.5,
  'kangaroo fillet, pepper, salt', 1, 'GF, NF, No Fish', TRUE, 'Meal'),
  
('Roast Goose', 700, 42, 0, 0, 0, 60, 22, 38, 130, 120, 30, 2.8,
  'goose, olive oil, rosemary', 1, 'GF, NF, No Fish', TRUE, 'Meal');


-- Vegan meals (CategoryID = 3)

INSERT INTO meals (
  MealName, Calories_cal, Protein_g, Carbs_g, Sugars_g, Fibers_g, 
  Fat_g, SatFat_g, UnsatFat_g, Cholesterol_mg, Sodium_mg, Calcium_mg, Iron_mg, 
  Ingredients, CategoryID, DietNotes, IsHomeCooked, IsMealorSnack
) VALUES
('Spicy Chickpea Buddha Bowl', 450, 18, 60, 8, 12, 16, 2, 12, 0, 420, 120, 5.5, 
 'Chickpeas, quinoa, sweet potato, kale, tahini, lemon juice, maple syrup, paprika, cumin, olive oil', 
 3, 'Contains sesame', TRUE, 'Meal'),
 
('Lentil Shepherd\'s Pie', 420, 16, 65, 10, 14, 10, 1, 8, 0, 480, 90, 6.0, 
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
 3, 'No common allergens', TRUE, 'Meal');

 
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
 4, 'Contains fish, gluten, egg and dairy', TRUE, 'Meal');

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

('Vegan Mushroom Tacos', 408, 18.5, 46.2, 6.3, 7.8, 1.4, 5.9, 0, 30, 706, 168, 1.6,
 'paneer, onion, zucchini, coriander, soy sauce, tempeh, yogurt, tomatoes, lentils, peanuts, pumpkin seeds',
 3, 'GF', TRUE, 'Meal'),

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
 'carrot, pumpkin seeds, avocado, cashews, bell pepper, cauliflower, lentils, sesame oil, ginger, coconut milk, eggplant, zucchini, eggs',
 3, 'NF', TRUE, 'Meal'),

('Herbed Couscous with Vegetables', 362, 17.9, 40.7, 9.7, 8.5, 4.2, 7.5, 0, 50, 549, 205, 2.9,
 'mushrooms, lemon juice, peanuts, quinoa, garlic, almonds, whole wheat tortillas, cottage cheese, pumpkin seeds, sunflower seeds, sesame oil, basil, spices, tempeh',
 'Vegetarian', 'NF', TRUE, 'Meal'),

  -- Vegetarian Meals
 ('Meal2', 520, 35, 40, 6, 2, 25, 5, 18, 75, 950, 70, 2.1,
 'Turkey mince, udon noodles, garlic, chili flakes, soy sauce, honey, spring onions, sesame oil',
 'Carnivore', 'Contains soy and gluten', TRUE, 'Meal'),
 2, 'NF', TRUE, 'Meal');

-- Insert the additional meals with descriptive names based on ingredients
INSERT INTO meals (
  MealName, Calories_cal, Protein_g, Carbs_g, Sugars_g, Fibers_g,
  Fat_g, SatFat_g, UnsatFat_g, Cholesterol_mg, Sodium_mg, Calcium_mg, Iron_mg,
  Ingredients, CategoryID, DietNotes, IsHomeCooked, IsMealorSnack
)
VALUES
('Spicy Honey Garlic Tofu Noodles', 520, 35, 40, 6, 2, 25, 5, 18, 75, 950, 70, 2.1,
 'Tofu, udon noodles, garlic, chili flakes, soy sauce, honey, spring onions, sesame oil',
 2, 'Contains soy and gluten', TRUE, 'Meal'),
 
('Mediterranean Tofu Feta Bake', 620, 38, 12, 5, 2, 45, 18, 20, 110, 700, 220, 3.0,
 'Tofu, feta cheese, onion, garlic, chili flakes, parsley, egg, breadcrumbs, olive oil, tomato sauce',
 2, 'Contains dairy and gluten', TRUE, 'Meal'),
 
('Plant Protein Sweetcorn Fritters', 400, 30, 20, 3, 2, 22, 4, 15, 70, 500, 60, 1.8,
 'Plant-based protein, sweetcorn, egg, breadcrumbs, spring onions, lemon zest, olive oil, salt, pepper',
 2, 'Contains gluten and egg', TRUE, 'Meal'),
 
('Harissa Tofu with Couscous', 480, 35, 30, 2, 2, 22, 3, 15, 120, 500, 100, 1.9,
 'Tofu, couscous, harissa paste, lemon juice, coriander, olive oil, garlic',
 2, 'Contains shellfish and gluten', TRUE, 'Meal'),
 
  ('Meal7', 410, 36, 10, 1, 1, 25, 4, 18, 70, 450, 80, 1.2,
 'Cod fillet, parsley, dill, lemon zest, breadcrumbs, olive oil, garlic',
 'Pescatarian', 'Contains gluten', TRUE, 'Meal'),
 
  ('Meal8', 407, 33.6, 52.8, 6.0, 7.4, 1.8, 15.2, 40, 421, 249, 249, 3.2,
  'milk, black beans, garlic, yogurt, herbs, cauliflower, cheese, lemon juice, sour cream',
  'Vegetarian', 'GF', TRUE, 'Meal'),
  
  ('Meal9', 464, 23.2, 32.6, 4.7, 8.1, 7.3, 12.4, 20, 0, 656, 179, 3.7,
    'bell pepper, chickpeas, mushrooms, almonds, ginger, olive oil, tomatoes, soy sauce, paneer, multigrain bread, garlic, carrot',
    'Vegetarian', 'Contains Dairy', TRUE, 'Meal'),
    
  ('Meal10', 526, 26.3, 58.6, 9.3, 7.6, 5.4, 8.6, 30, 0, 797, 186, 2.4,
 'cheese, quinoa, basil, mushrooms, onion, spinach, sunflower seeds, lemon juice',
 'Vegetarian', 'Contains Dairy', TRUE, 'Meal'),
 
  ('Meal11', 309, 29.7, 58.0, 4.7, 5.7, 1.7, 13.8, 0, 0, 320, 136, 2.2,
 'eggplant, sour cream, oats, cucumber, spices, tofu, broccoli, multigrain bread, olive oil, onion',
 'Vegetarian', 'Contains Gluten', TRUE, 'Meal'),
 
  ('Meal12', 388, 12.8, 38.5, 2.3, 4.0, 2.0, 9.7, 0, 50, 358, 54, 1.8,
 'pumpkin seeds, pasta, lentils, broccoli, paneer, chickpeas, almonds, bell pepper, whole wheat tortillas',
 'Vegetarian', 'Contains Gluten', TRUE, 'Meal'),
 
  ('Meal13', 366, 28.0, 49.5, 3.6, 5.9, 4.5, 9.2, 0, 30, 649, 116, 3.0,
 'coconut milk, sesame oil, black beans, mushrooms, cheese, lentils, parsley, cucumber, chickpeas, olive oil, pasta, milk, paneer, kale',
 'Vegetarian', 'Contains Gluten', TRUE, 'Meal'),
 
  ('Meal14', 528, 11.1, 52.4, 3.1, 5.7, 5.4, 9.6, 0, 20, 439, 117, 1.9,
 'avocado, basil, carrot, coriander, lemon juice, soy sauce, paneer, garlic, broccoli, pumpkin seeds, quinoa, cheese',
 'Vegetarian', 'Egg-Free', TRUE, 'Meal'),
 
  ('Meal15', 352, 24.3, 51.1, 3.0, 3.6, 4.1, 14.4, 0, 0, 561, 130, 2.7,
 'sunflower seeds, kale, cottage cheese, multigrain bread, avocado, whole wheat tortillas, tempeh, cheese, cauliflower, basil',
 'Vegetarian', 'Contains Gluten', TRUE, 'Meal'),
 
  ('Meal16', 303, 19.6, 47.7, 5.3, 8.6, 1.4, 19.9, 0, 40, 300, 142, 3.1,
 'cauliflower, milk, sesame oil, tomatoes, eggs, lentils, tempeh, tofu, olive oil, sour cream, cheese, whole wheat tortillas',
 'Vegetarian', 'NF', TRUE, 'Meal'),
 
  ('Meal17', 303, 12.6, 36.7, 8.4, 5.8, 5.5, 8.5, 0, 0, 433, 199, 1.9,
 'spices, soy sauce, sesame oil, yogurt, quinoa, zucchini, lentils, basil, cottage cheese, spinach, lemon juice',
 'Vegetarian', 'Egg-Free', TRUE, 'Meal'),
 
  ('Meal18', 519, 24.0, 48.2, 8.1, 9.9, 1.2, 8.8, 0, 60, 337, 188, 3.3,
 'broccoli, chickpeas, cashews, garlic, sesame oil, cottage cheese, avocado, sour cream, mushrooms, eggs, coriander, almonds, kale, whole wheat tortillas',
 'Vegetarian', 'GF', TRUE, 'Meal'),
 
  ('Meal19', 445, 11.8, 49.1, 7.0, 4.8, 4.2, 14.3, 0, 50, 378, 167, 2.3,
 'almonds, garlic, black beans, lentils, soy sauce, brown rice, lemon juice, oats, multigrain bread, cottage cheese, broccoli',
 'Vegetarian', 'Egg-Free', TRUE, 'Meal'),
 
  ('Meal20', 408, 18.5, 46.2, 6.3, 7.8, 1.4, 5.9, 0, 30, 706, 168, 1.6,
 'paneer, onion, zucchini, coriander, soy sauce, tempeh, yogurt, tomatoes, lentils, peanuts, pumpkin seeds',
 'Vegetarian', 'GF', TRUE, 'Meal'),
 
  ('Meal21', 392, 14.6, 59.2, 8.3, 5.1, 4.2, 0, 8.2, 30, 753, 70, 3.2,
 'cottage cheese, avocado, coconut milk, sour cream, oats, garlic, sesame oil, quinoa, coriander, milk, multigrain bread, spices, olive oil',
 'Vegetarian', 'GF', TRUE, 'Meal'),
 
  ('Meal22', 585, 16.1, 59.7, 7.9, 3.7, 5.2, 17.9, 0, 40, 330, 54, 1.6,
 'tofu, sunflower seeds, pumpkin seeds, parsley, cashews, whole wheat tortillas, oats, almonds, milk, avocado',
 'Vegetarian', 'NF', TRUE, 'Meal'),
 
  ('Meal23', 306, 33.0, 35.4, 3.0, 5.9, 6.5, 0, 16.3, 50, 349, 150, 1.3,
 'onion, carrot, sunflower seeds, broccoli, spinach, cheese, lentils, sweet potato, ginger',
 'Vegetarian', 'Egg-Free', TRUE, 'Meal'),
 
  ('Meal24', 491, 13.5, 39.2, 5.4, 7.2, 4.3, 7.8, 0, 40, 369, 217, 1.6,
 'carrot, pumpkin seeds, avocado, cashews, bell pepper, cauliflower, lentils, sesame oil, ginger, coconut milk, eggplant, zucchini, eggs',
 'Vegetarian', 'NF', TRUE, 'Meal'),
 
  ('Meal25', 362, 17.9, 40.7, 9.7, 8.5, 4.2, 7.5, 0, 50, 549, 205, 2.9,
 'mushrooms, lemon juice, peanuts, quinoa, garlic, almonds, whole wheat tortillas, cottage cheese, pumpkin seeds, sunflower seeds, sesame oil, basil, spices, tempeh',
 'Vegetarian', 'NF', TRUE, 'Meal'),

  -- Carnivore Meals 

('Grilled Ribeye Steak', 650, 55, 0, 0, 0, 50, 20, 30, 140, 90, 20, 3.5,
  'ribeye steak, salt, pepper', 'Carnivore', 'GF, NF, No Fish', 'Yes', 'Meal'),
  
('Baked Chicken Thighs', 400, 38, 0, 0, 0, 25, 7, 18, 120, 85, 15, 1.5,
  'chicken thighs, olive oil, garlic powder', 'Carnivore', 'GF, NF, No Fish', 'Yes', 'Meal'),
  
('Pork Belly Slices', 600, 30, 0, 0, 0, 55, 20, 35, 110, 70, 10, 1.8,
  'pork belly, salt, paprika', 'Carnivore', 'GF, NF', 'Yes', 'Meal'),
  
('Lamb Chops', 550, 40, 0, 0, 0, 45, 18, 27, 115, 95, 25, 3.2,
  'lamb chops, rosemary, salt, pepper', 'Carnivore', 'GF, NF, No Fish', 'Yes', 'Meal'),
  
('Beef Liver Fry', 320, 42, 3, 1, 0, 12, 4, 8, 400, 90, 30, 6.0,
  'beef liver, butter, salt, onion powder', 'Carnivore', 'GF, NF, No Fish', 'Yes', 'Meal'),
  
('Grilled Turkey Breast', 280, 48, 0, 0, 0, 6, 2, 4, 90, 75, 15, 1.0,
  'turkey breast, olive oil, black pepper', 'Carnivore', 'GF, NF, No Fish', 'Yes', 'Meal'),
  
('Duck Breast with Skin', 500, 35, 0, 0, 0, 40, 15, 25, 115, 100, 20, 2.5,
  'duck breast, thyme, salt', 'Carnivore', 'GF, NF, No Fish', 'Yes', 'Meal'),
  
('Tuna Steak Seared', 400, 50, 0, 0, 0, 18, 5, 13, 70, 60, 20, 2.0,
  'tuna steak, sesame oil, salt', 'Carnivore', 'GF, NF, No Pork', 'Yes', 'Meal'),
  
('Meatballs (Beef Only)', 470, 38, 2, 0.5, 0, 32, 12, 20, 100, 85, 22, 2.8,
  'ground beef, egg, salt, pepper', 'Carnivore', 'GF, NF, No Fish', 'Yes', 'Meal'),
  
('Pan-fried Salmon', 450, 42, 0, 0, 0, 30, 8, 22, 95, 85, 20, 1.5,
  'salmon fillet, lemon, butter, salt', 'Carnivore', 'GF, NF, No Pork', 'Yes', 'Meal'),
  
('Roasted Quail', 330, 30, 0, 0, 0, 22, 8, 14, 90, 60, 15, 2.2,
  'quail, butter, rosemary, pepper', 'Carnivore', 'GF, NF, No Fish', 'Yes', 'Meal'),
  
('Venison Steak', 400, 50, 0, 0, 0, 18, 5, 13, 95, 65, 20, 4.0,
  'venison steak, garlic powder, salt', 'Carnivore', 'GF, NF, No Fish', 'Yes', 'Meal'),
  
('Sardines Grilled', 300, 34, 0, 0, 0, 18, 6, 12, 80, 350, 25, 2.5,
  'sardines, olive oil, lemon', 'Carnivore', 'GF, NF, No Pork', 'Yes', 'Meal'),
  
('Beef Short Ribs', 700, 45, 0, 0, 0, 60, 22, 38, 130, 120, 25, 3.0,
  'beef short ribs, salt, pepper', 'Carnivore', 'GF, NF, No Fish', 'Yes', 'Meal'),
  
('Grilled Chicken Wings', 450, 35, 0, 0, 0, 30, 10, 20, 110, 140, 18, 1.6,
  'chicken wings, paprika, salt', 'Carnivore', 'GF, NF, No Fish', 'Yes', 'Snack'),
  
('Roasted Duck Legs', 600, 38, 0, 0, 0, 50, 18, 32, 125, 105, 22, 2.7,
  'duck legs, garlic, thyme, olive oil', 'Carnivore', 'GF, NF, No Fish', 'Yes', 'Meal'),
  
('Pork Chops', 520, 40, 0, 0, 0, 40, 15, 25, 115, 90, 18, 2.0, 
  'pork chops, sage, salt', 'Carnivore', 'GF, NF', 'Yes', 'Meal'),
  
('Smoked Salmon', 350, 32, 1, 0.5, 0, 20, 6, 14, 70, 400, 22, 1.2,
  'smoked salmon, dill, salt', 'Carnivore', 'GF, NF, No Pork', 'No', 'Snack'),
  
('Grilled Kangaroo Fillet', 360, 48, 0, 0, 0, 15, 5, 10, 90, 80, 20, 4.5,
  'kangaroo fillet, pepper, salt', 'Carnivore', 'GF, NF, No Fish', 'Yes', 'Meal'),
  
('Roast Goose', 700, 42, 0, 0, 0, 60, 22, 38, 130, 120, 30, 2.8,
  'goose, olive oil, rosemary', 'Carnivore', 'GF, NF, No Fish', 'Yes', 'Meal'),
 
-- Snacks Mixed Diets 

('Trail Mix', 163, 5, 12, 6, 3, 12, 2, 10, 0, 5, 34, 1.2, 
  'Almonds, cashews, walnuts, dried cranberries, dark chocolate chips', 'Vegetarian', 'GF, NF', 'No', 'Snack'),
  
('Hummus with Carrot Sticks', 210, 7, 23, 5, 6, 11, 1.5, 9.5, 0, 375, 45, 1.8, 'Chickpeas, tahini, lemon juice, garlic, olive oil, carrots', 'Vegan', 'GF', 'Yes', 'Snack'),
  
('Greek Yogurt with Honey', 180, 17, 18, 17, 0, 4.5, 3, 1.5, 15, 65, 200, 0.1, 'Greek yogurt, honey, cinnamon', 'Vegetarian', 'GF', 'No', 'Snack'),
  
('Rice Cakes with Avocado', 145, 3, 17, 0, 4, 8, 1, 7, 0, 105, 12, 0.4, 'Rice cakes, avocado, salt, pepper, lemon juice', 'Vegan', 'GF', 'Yes', 'Snack'),

('Edamame', 122, 11, 10, 2, 5, 5, 0.5, 4.5, 0, 9, 60, 2.3, 'Soybeans, sea salt', 'Vegan', 'GF', 'No', 'Snack'),

  ('Beef Jerky', 116, 13, 7, 6, 0, 3, 1.5, 1.5, 25, 470, 5, 1.5, 
  'Beef, salt, sugar, spices, smoke flavor', 'Omnivore', 'GF, No Pork', 'No', 'Snack'),

  ('Crispy Roasted Chickpeas', 120, 6, 16, 1, 4, 3, 0.5, 2.5, 0, 170, 43, 1.1,
  'Chickpeas, olive oil, cumin, paprika, salt', 'Vegan', 'GF', 'Yes', 'Snack'),

  ('Cheese and Crackers', 220, 8, 20, 2, 1, 13, 7, 6, 30, 400, 200, 0.6,
  'Cheddar cheese, whole grain crackers', 'Vegetarian', 'No', 'No', 'Snack'),

  ('Fruit Leather', 80, 0, 20, 12, 1, 0, 0, 0, 0, 10, 10, 0.3,
  'Pureed fruits, honey', 'Vegan', 'GF', 'Yes', 'Snack'),

  ('Kale Chips', 110, 3, 11, 0, 2, 7, 1, 6, 0, 180, 90, 1.7,
  'Kale, olive oil, nutritional yeast, salt', 'Vegan', 'GF', 'Yes', 'Snack'),

  ('Peanut Butter Apple Slices', 190, 5, 22, 15, 4, 10, 2, 8, 0, 75, 20, 0.5,
  'Apple, peanut butter', 'Vegan', 'No Fish', 'Yes', 'Snack'),

  ('Seaweed Snacks', 30, 1, 3, 0, 1, 2, 0, 2, 0, 120, 15, 0.7,
  'Seaweed, sesame oil, salt', 'Vegan', 'GF', 'No', 'Snack'),

  ('Protein Shake', 160, 20, 7, 3, 1, 3, 1, 2, 5, 120, 250, 1.0,
  'Whey protein, milk, banana, ice', 'Vegetarian', 'GF', 'Yes', 'Snack'),

  ('Popcorn', 100, 3, 20, 0, 4, 2, 0.5, 1.5, 0, 200, 3, 0.9,
  'Popcorn kernels, olive oil, salt', 'Vegan', 'GF', 'Yes', 'Snack'),

  ('Hard-Boiled Egg', 78, 6, 1, 0, 0, 5, 1.5, 3.5, 212, 62, 25, 0.6,
  'Egg', 'Vegetarian', 'GF, No Fish, No Pork', 'Yes', 'Snack'),

  ('Chocolate Protein Ball', 110, 7, 11, 5, 3, 5, 1.5, 3.5, 0, 35, 35, 2.1,
  'Dates, protein powder, cocoa powder, almond butter, chia seeds', 'Vegan', 'GF', 'Yes', 'Snack'),

  ('Veggie Chips', 140, 2, 16, 2, 3, 7, 0.5, 6.5, 0, 220, 30, 1.3,
  'Sweet potatoes, beets, carrots, olive oil, sea salt', 'Vegan', 'GF', 'No', 'Snack'),

  ('Chia Pudding', 170, 6, 15, 8, 8, 10, 1, 9, 0, 45, 180, 2.2,
  'Chia seeds, almond milk, honey, vanilla, berries', 'Vegan', 'GF, NF', 'Yes', 'Snack'),

  ('Tuna Salad Cucumber Boats', 140, 15, 4, 2, 1, 7, 1, 6, 30, 350, 20, 0.9,
  'Tuna, Greek yogurt, dill, cucumber, lemon juice', 'Pescatarian', 'GF, No Pork', 'Yes', 'Snack'),

  ('Chocolate Covered Almonds', 200, 5, 15, 10, 4, 15, 4, 11, 5, 10, 80, 1.1,
  'Almonds, dark chocolate, cocoa powder', 'Vegetarian', 'GF', 'No', 'Snack'),

  ('Roasted Pumpkin Seeds', 126, 5, 5, 0, 3, 10, 2, 8, 0, 5, 20, 2.5,
  'Pumpkin seeds, olive oil, salt, paprika', 'Vegan', 'GF', 'Yes', 'Snack'),

  ('Veggie Sticks with Guacamole', 160, 2, 14, 3, 7, 11, 2, 9, 0, 250, 30, 0.8,
  'Avocado, lime juice, onion, tomato, cilantro, bell peppers, carrots, celery', 'Vegan', 'GF', 'Yes', 'Snack'),

  ('Cottage Cheese with Pineapple', 140, 14, 11, 10, 1, 3, 2, 1, 15, 430, 100, 0.3,
  'Cottage cheese, pineapple chunks', 'Vegetarian', 'GF', 'No', 'Snack'),

  ('Protein Bar', 220, 20, 23, 14, 7, 7, 2.5, 4.5, 10, 190, 50, 3.6,
  'Protein blend, dates, nuts, chocolate chips', 'Vegetarian', 'No', 'No', 'Snack'),
  
  ('Stuffed Grape Leaves', 160, 3, 20, 1, 4, 8, 1, 7, 0, 320, 45, 1.5,
  'Grape leaves, rice, herbs, olive oil, lemon juice', 'Vegan', 'GF', 'No', 'Snack'),

  ('Chocolate Banana Smoothie', 200, 5, 35, 20, 5, 4, 2, 2, 5, 70, 200, 1.2,
  'Banana, cocoa powder, milk, honey, ice', 'Vegetarian', 'GF', 'Yes', 'Snack'),

  ('Smoked Salmon Rice Cakes', 130, 10, 13, 0, 1, 5, 1, 4, 10, 350, 15, 0.5,
  'Rice cakes, smoked salmon, cream cheese, dill', 'Pescatarian', 'GF, No Pork', 'No', 'Snack'),

  ('Deviled Eggs', 145, 6, 1, 0, 0, 13, 3, 10, 215, 150, 30, 0.6,
  'Eggs, mayonnaise, mustard, paprika, salt', 'Vegetarian', 'GF, No Fish, No Pork', 'Yes', 'Snack'),

  ('Fruit and Nut Bar', 185, 4, 21, 15, 3, 10, 1, 9, 0, 5, 25, 1.0,
  'Dates, almonds, cashews, dried apricots', 'Vegan', 'GF', 'No', 'Snack'),

  ('Tzatziki with Pita', 180, 6, 20, 3, 2, 8, 4, 4, 10, 340, 120, 1.2,
  'Greek yogurt, cucumber, garlic, dill, olive oil, pita bread', 'Vegetarian', 'No', 'Yes', 'Snack'),

  ('Buffalo Cauliflower Bites', 120, 3, 17, 3, 4, 5, 1, 4, 0, 380, 25, 0.7,
  'Cauliflower, flour, buffalo sauce, garlic powder', 'Vegan', 'No', 'Yes', 'Snack'),

  ('Avocado Chocolate Mousse', 180, 3, 19, 12, 8, 12, 3, 9, 0, 5, 20, 1.8,
  'Avocado, cocoa powder, maple syrup, almond milk, vanilla', 'Vegan', 'GF', 'Yes', 'Snack'),

  ('Coconut Date Rolls', 150, 1, 26, 24, 3, 6, 5, 1, 0, 15, 15, 0.4,
  'Dates, shredded coconut, almonds', 'Vegan', 'GF', 'Yes', 'Snack'),

  ('Mini Caprese Skewers', 110, 7, 2, 1, 0, 9, 4, 5, 15, 170, 200, 0.3,
  'Cherry tomatoes, fresh mozzarella, basil, olive oil, balsamic glaze', 'Vegetarian', 'GF, No Fish, No Pork', 'Yes', 'Snack'),

  ('Biltong', 90, 16, 1, 0, 0, 2, 1, 1, 30, 420, 10, 2.3,
  'Beef, vinegar, salt, spices', 'Omnivore', 'GF, No Pork', 'No', 'Snack'),

  ('Energy Balls', 135, 3, 18, 13, 2, 6, 1, 5, 0, 3, 30, 1.2,
  'Oats, peanut butter, honey, chia seeds, chocolate chips', 'Vegetarian', 'No', 'Yes', 'Snack'),

  ('Cucumber Sushi Rolls', 80, 3, 15, 2, 2, 0.5, 0, 0.5, 0, 320, 15, 0.9,
  'Cucumber, rice, nori, avocado, carrot, rice vinegar', 'Vegan', 'GF', 'Yes', 'Snack'),

  ('Feta and Watermelon Cubes', 130, 5, 13, 11, 1, 7, 5, 2, 25, 260, 150, 0.4,
  'Watermelon, feta cheese, mint leaves', 'Vegetarian', 'GF', 'Yes', 'Snack'),

  ('Wasabi Peas', 120, 5, 19, 2, 2, 2, 0, 2, 0, 240, 20, 1.0,
  'Green peas, starch, wasabi, salt', 'Vegan', 'GF', 'No', 'Snack'),

  ('Almond Flour Crackers', 150, 6, 10, 1, 3, 11, 1, 10, 0, 180, 60, 1.2,
  'Almond flour, flaxseed, olive oil, herbs, salt', 'Vegan', 'GF', 'Yes', 'Snack'),

  ('Olives and Cheese', 140, 7, 2, 0, 1, 12, 5, 7, 15, 560, 180, 0.5,
  'Kalamata olives, feta cheese, olive oil, herbs', 'Vegetarian', 'GF', 'No', 'Snack'),

  ('Lentil Chips', 130, 5, 18, 1, 3, 4, 0.5, 3.5, 0, 170, 20, 1.8,
  'Lentil flour, potato starch, sunflower oil, salt', 'Vegan', 'GF', 'No', 'Snack'),

  ('Turkey Roll-Ups', 120, 15, 2, 1, 0, 6, 2, 4, 35, 450, 20, 0.8,
  'Turkey slices, cream cheese, bell peppers, spinach', 'Omnivore', 'GF, No Pork', 'Yes', 'Snack'),

  ('Frozen Yogurt Bark', 110, 6, 15, 12, 1, 2, 1, 1, 5, 40, 150, 0.2,
  'Greek yogurt, honey, berries, dark chocolate chips', 'Vegetarian', 'GF', 'Yes', 'Snack'),

  ('Roasted Seaweed Tuna Wraps', 95, 12, 3, 0, 1, 4, 0.5, 3.5, 15, 280, 15, 1.0,
  'Seaweed sheets, tuna, avocado, cucumber, sesame seeds', 'Pescatarian', 'GF, No Pork', 'Yes', 'Snack'),

  ('Flaxseed Crackers', 140, 5, 6, 0, 5, 11, 1, 10, 0, 120, 40, 1.6,
  'Flaxseeds, chia seeds, sunflower seeds, herbs, salt', 'Vegan', 'GF', 'Yes', 'Snack'),

  ('Jackfruit Jerky', 70, 1, 15, 8, 3, 0, 0, 0, 0, 320, 30, 1.2,
  'Jackfruit, soy sauce, maple syrup, liquid smoke, spices', 'Vegan', 'No', 'No', 'Snack'),

  ('Chocolate Ricotta Dip', 160, 10, 13, 11, 1, 7, 4, 3, 25, 45, 150, 0.3,
  'Ricotta cheese, cocoa powder, honey, vanilla, strawberries', 'Vegetarian', 'GF', 'Yes', 'Snack'),

  ('Baked Plantain Chips', 150, 1, 29, 12, 3, 5, 2, 3, 0, 120, 5, 0.6,
  'Plantains, coconut oil, cinnamon, salt', 'Vegan', 'GF', 'Yes', 'Snack'),

  ('Mini Frittata Bites', 130, 10, 3, 1, 0, 9, 3, 6, 185, 210, 100, 1.0,
  'Eggs, spinach, bell peppers, cheese, onions', 'Vegetarian', 'GF, No Fish, No Pork', 'Yes', 'Snack');
 
 SELECT * FROM meals;

('Lemon Herb Tofu Cutlets', 410, 36, 10, 1, 1, 25, 4, 18, 70, 450, 80, 1.2,
 'Tofu fillet, parsley, dill, lemon zest, breadcrumbs, olive oil, garlic',
 2, 'Contains gluten', TRUE, 'Meal');

-- Insert remaining duplicates (8-25) - similar pattern would continue

-- Insert all snacks
INSERT INTO meals (
  MealName, Calories_cal, Protein_g, Carbs_g, Sugars_g, Fibers_g,
  Fat_g, SatFat_g, UnsatFat_g, Cholesterol_mg, Sodium_mg, Calcium_mg, Iron_mg,
  Ingredients, CategoryID, DietNotes, IsHomeCooked, IsMealorSnack
)
VALUES
-- Mixed diet snacks
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
  'Eggs, spinach, bell peppers, cheese, onions', 2, 'GF, No Fish, No Pork', TRUE, 'Snack')

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

-- Create stored procedure for meal planning
DELIMITER $$
-- Create stored procedure for finding meals by ingredient
DELIMITER $
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
END$
DELIMITER ;

-- Create stored procedure for weekly meal planning
DELIMITER $
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
END$
DELIMITER ;