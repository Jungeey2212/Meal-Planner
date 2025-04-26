CREATE DATABASE IF NOT EXISTS mealplans;

CREATE TABLE meals (
  NutritionID     INT             AUTO_INCREMENT PRIMARY KEY,
  MealName        VARCHAR(255)    NOT NULL,
  Calories_cal    INT             NULL,
  Protein_g		  DECIMAl(6,2)	  NOT NULL,
  Carbs_g		  DECIMAL(6.2)	  NOT NULL,
  Sugars_g        DECIMAL(6,2)    NULL,
  Fibers_g        DECIMAL(6,2)    NULL,
  Fat_g           DECIMAL(6,2)    NULL,
  SatFat_g        DECIMAL(6,2)    NULL,
  UnsatFat_g      DECIMAL(6,2)    NULL,
  Cholesterol_mg  INT             NULL,
  Sodium_mg       INT             NULL,
  Calcium_mg      INT             NULL,
  Iron_mg         DECIMAL(6,2)    NULL,
  Ingredients     TEXT            NULL,
  DietCategory    VARCHAR(100)    NULL,
  DietNotes       TEXT            NULL,
  IsHomeCooked    BOOLEAN         NOT NULL DEFAULT FALSE,
  IsMealorSnack   ENUM('Meal','Snack') NOT NULL
) 
ENGINE=InnoDB
DEFAULT CHARSET = utf8mb4;
SELECT * FROM meals;

INSERT INTO meals (
  MealName, Calories_cal, Protein_g, Carbs_g, Sugars_g, Fibers_g,
  Fat_g, SatFat_g, UnsatFat_g, Cholesterol_mg, Sodium_mg, Calcium_mg, Iron_mg,
  Ingredients, DietCategory, DietNotes, IsHomeCooked, IsMealorSnack
)
VALUES

  -- Omnivore Meals
('Crispy Chilli Turkey Noodles', 520, 35, 40, 6, 2, 25, 5, 18, 75, 950, 70, 2.1,
 'Turkey mince, udon noodles, garlic, chili flakes, soy sauce, honey, spring onions, sesame oil',
 'Carnivore', 'Contains soy and gluten', TRUE, 'Meal'),

('Spicy Lamb & Feta Meatballs', 620, 38, 12, 5, 2, 45, 18, 20, 110, 700, 220, 3.0,
 'Lamb mince, feta cheese, onion, garlic, chili flakes, parsley, egg, breadcrumbs, olive oil, tomato sauce',
 'Carnivore', 'Contains dairy and gluten', TRUE, 'Meal'),

('Tuna Sweetcorn Cakes', 400, 30, 20, 3, 2, 22, 4, 15, 70, 500, 60, 1.8,
 'Canned tuna, sweetcorn, egg, breadcrumbs, spring onions, lemon zest, olive oil, salt, pepper',
 'Pescatarian', 'Contains gluten and egg', TRUE, 'Meal'),

('Turkey, Spinach & Feta Burgers', 520, 40, 20, 3, 2, 30, 9, 18, 95, 600, 180, 2.5,
 'Turkey mince, spinach, feta, egg, garlic, breadcrumbs, olive oil, burger buns',
 'Carnivore', 'Contains gluten, dairy, and egg', TRUE, 'Meal'),

('Harissa Prawns with Couscous', 480, 35, 30, 2, 2, 22, 3, 15, 120, 500, 100, 1.9,
 'Prawns, couscous, harissa paste, lemon juice, coriander, olive oil, garlic',
 'Pescatarian', 'Contains shellfish and gluten', TRUE, 'Meal'),

('Baked Cod with Herby Crust', 410, 36, 10, 1, 1, 25, 4, 18, 70, 450, 80, 1.2,
 'Cod fillet, parsley, dill, lemon zest, breadcrumbs, olive oil, garlic',
 'Pescatarian', 'Contains gluten', TRUE, 'Meal'),

('Grilled Halloumi Salad', 407, 33.6, 52.8, 6.0, 7.4, 1.8, 15.2, 40, 421, 249, 249, 3.2,
  'milk, black beans, garlic, yogurt, herbs, cauliflower, cheese, lemon juice, sour cream',
  'Vegetarian', 'GF', TRUE, 'Meal'),

('Sweet Potato & Black Bean Tacos', 464, 23.2, 32.6, 4.7, 8.1, 7.3, 12.4, 20, 0, 656, 179, 3.7,
    'bell pepper, chickpeas, mushrooms, almonds, ginger, olive oil, tomatoes, soy sauce, paneer, multigrain bread, garlic, carrot',
    'Vegetarian', 'Contains Dairy', TRUE, 'Meal'),

('Eggplant Parmesan', 526, 26.3, 58.6, 9.3, 7.6, 5.4, 8.6, 30, 0, 797, 186, 2.4,
 'cheese, quinoa, basil, mushrooms, onion, spinach, sunflower seeds, lemon juice',
 'Vegetarian', 'Contains Dairy', TRUE, 'Meal'),

('Vegetarian Burrito Bowl', 309, 29.7, 58.0, 4.7, 5.7, 1.7, 13.8, 0, 0, 320, 136, 2.2,
 'eggplant, sour cream, oats, cucumber, spices, tofu, broccoli, multigrain bread, olive oil, onion',
 'Vegetarian', 'Contains Gluten', TRUE, 'Meal'),

('Paneer Butter Masala', 388, 12.8, 38.5, 2.3, 4.0, 2.0, 9.7, 0, 50, 358, 54, 1.8,
 'pumpkin seeds, pasta, lentils, broccoli, paneer, chickpeas, almonds, bell pepper, whole wheat tortillas',
 'Vegetarian', 'Contains Gluten', TRUE, 'Meal'),

('Vegetarian Chili', 366, 28.0, 49.5, 3.6, 5.9, 4.5, 9.2, 0, 30, 649, 116, 3.0,
 'coconut milk, sesame oil, black beans, mushrooms, cheese, lentils, parsley, cucumber, chickpeas, olive oil, pasta, milk, paneer, kale',
 'Vegetarian', 'Contains Gluten', TRUE, 'Meal'),

('Tofu Scramble Breakfast Bowl', 528, 11.1, 52.4, 3.1, 5.7, 5.4, 9.6, 0, 20, 439, 117, 1.9,
 'avocado, basil, carrot, coriander, lemon juice, soy sauce, paneer, garlic, broccoli, pumpkin seeds, quinoa, cheese',
 'Vegetarian', 'Egg-Free', TRUE, 'Meal'),

('Vegetable Biryani', 352, 24.3, 51.1, 3.0, 3.6, 4.1, 14.4, 0, 0, 561, 130, 2.7,
 'sunflower seeds, kale, cottage cheese, multigrain bread, avocado, whole wheat tortillas, tempeh, cheese, cauliflower, basil',
 'Vegetarian', 'Contains Gluten', TRUE, 'Meal'),

('Chickpea & Spinach Stew', 303, 19.6, 47.7, 5.3, 8.6, 1.4, 19.9, 0, 40, 300, 142, 3.1,
 'cauliflower, milk, sesame oil, tomatoes, eggs, lentils, tempeh, tofu, olive oil, sour cream, cheese, whole wheat tortillas',
 'Vegetarian', 'NF', TRUE, 'Meal'),

('Miso Ramen with Tofu', 303, 12.6, 36.7, 8.4, 5.8, 5.5, 8.5, 0, 0, 433, 199, 1.9,
 'spices, soy sauce, sesame oil, yogurt, quinoa, zucchini, lentils, basil, cottage cheese, spinach, lemon juice',
 'Vegetarian', 'Egg-Free', TRUE, 'Meal'),

('Veggie Tikka Masala', 519, 24.0, 48.2, 8.1, 9.9, 1.2, 8.8, 0, 60, 337, 188, 3.3,
 'broccoli, chickpeas, cashews, garlic, sesame oil, cottage cheese, avocado, sour cream, mushrooms, eggs, coriander, almonds, kale, whole wheat tortillas',
 'Vegetarian', 'GF', TRUE, 'Meal'),

('Peanut Butter Banana Oatmeal', 445, 11.8, 49.1, 7.0, 4.8, 4.2, 14.3, 0, 50, 378, 167, 2.3,
 'almonds, garlic, black beans, lentils, soy sauce, brown rice, lemon juice, oats, multigrain bread, cottage cheese, broccoli',
 'Vegetarian', 'Egg-Free', TRUE, 'Meal'),

('Vegan Mushroom Tacos', 408, 18.5, 46.2, 6.3, 7.8, 1.4, 5.9, 0, 30, 706, 168, 1.6,
 'paneer, onion, zucchini, coriander, soy sauce, tempeh, yogurt, tomatoes, lentils, peanuts, pumpkin seeds',
 'Vegetarian', 'GF', TRUE, 'Meal'),

('Vegetarian Sushi Rolls', 392, 14.6, 59.2, 8.3, 5.1, 4.2, 0, 8.2, 30, 753, 70, 3.2,
 'cottage cheese, avocado, coconut milk, sour cream, oats, garlic, sesame oil, quinoa, coriander, milk, multigrain bread, spices, olive oil',
 'Vegetarian', 'GF', TRUE, 'Meal'),

('Vegetable Gyoza', 585, 16.1, 59.7, 7.9, 3.7, 5.2, 17.9, 0, 40, 330, 54, 1.6,
 'tofu, sunflower seeds, pumpkin seeds, parsley, cashews, whole wheat tortillas, oats, almonds, milk, avocado',
 'Vegetarian', 'NF', TRUE, 'Meal'),

('Curried Pumpkin Soup', 306, 33.0, 35.4, 3.0, 5.9, 6.5, 0, 16.3, 50, 349, 150, 1.3,
 'onion, carrot, sunflower seeds, broccoli, spinach, cheese, lentils, sweet potato, ginger',
 'Vegetarian', 'Egg-Free', TRUE, 'Meal'),

('Three Bean Salad', 491, 13.5, 39.2, 5.4, 7.2, 4.3, 7.8, 0, 40, 369, 217, 1.6,
 'carrot, pumpkin seeds, avocado, cashews, bell pepper, cauliflower, lentils, sesame oil, ginger, coconut milk, eggplant, zucchini, eggs',
 'Vegetarian', 'NF', TRUE, 'Meal'),

('Herbed Couscous with Vegetables', 362, 17.9, 40.7, 9.7, 8.5, 4.2, 7.5, 0, 50, 549, 205, 2.9,
 'mushrooms, lemon juice, peanuts, quinoa, garlic, almonds, whole wheat tortillas, cottage cheese, pumpkin seeds, sunflower seeds, sesame oil, basil, spices, tempeh',
 'Vegetarian', 'NF', TRUE, 'Meal'),

  -- Vegetarian Meals
 ('Meal2', 520, 35, 40, 6, 2, 25, 5, 18, 75, 950, 70, 2.1,
 'Turkey mince, udon noodles, garlic, chili flakes, soy sauce, honey, spring onions, sesame oil',
 'Carnivore', 'Contains soy and gluten', TRUE, 'Meal'),
 
  ('Meal3', 620, 38, 12, 5, 2, 45, 18, 20, 110, 700, 220, 3.0,
 'Lamb mince, feta cheese, onion, garlic, chili flakes, parsley, egg, breadcrumbs, olive oil, tomato sauce',
 'Carnivore', 'Contains dairy and gluten', TRUE, 'Meal'),
 
  ('Meal4', 400, 30, 20, 3, 2, 22, 4, 15, 70, 500, 60, 1.8,
 'Canned tuna, sweetcorn, egg, breadcrumbs, spring onions, lemon zest, olive oil, salt, pepper',
 'Pescatarian', 'Contains gluten and egg', TRUE, 'Meal'),
 
  ('Spinach & Feta Burgers', 520, 40, 20, 3, 2, 30, 9, 18, 95, 600, 180, 2.5,
 'Turkey mince, spinach, feta, egg, garlic, breadcrumbs, olive oil, burger buns',
 'Carnivore', 'Contains gluten, dairy, and egg', TRUE, 'Meal'),
 
  ('Meal6', 480, 35, 30, 2, 2, 22, 3, 15, 120, 500, 100, 1.9,
 'Prawns, couscous, harissa paste, lemon juice, coriander, olive oil, garlic',
 'Pescatarian', 'Contains shellfish and gluten', TRUE, 'Meal'),
 
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
