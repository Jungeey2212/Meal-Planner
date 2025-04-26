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
 
 ('Turkey Udon', 520, 35, 40, 6, 2, 25, 5, 18, 75, 950, 70, 2.1,
 'Turkey mince, udon noodles, garlic, chili flakes, soy sauce, honey, spring onions, sesame oil',
 'Carnivore', 'Contains soy and gluten', TRUE, 'Meal'),
 
  ('Lamb and Feta Meatballs', 620, 38, 12, 5, 2, 45, 18, 20, 110, 700, 220, 3.0,
 'Lamb mince, feta cheese, onion, garlic, chili flakes, parsley, egg, breadcrumbs, olive oil, tomato sauce',
 'Carnivore', 'Contains dairy and gluten', TRUE, 'Meal'),
 
  ('Tuna Sweetcorn Cakes', 400, 30, 20, 3, 2, 22, 4, 15, 70, 500, 60, 1.8,
 'Canned tuna, sweetcorn, egg, breadcrumbs, spring onions, lemon zest, olive oil, salt, pepper',
 'Pescatarian', 'Contains gluten and egg', TRUE, 'Meal'),
 
  ('Spinach & Feta Burgers', 520, 40, 20, 3, 2, 30, 9, 18, 95, 600, 180, 2.5,
 'Turkey mince, spinach, feta, egg, garlic, breadcrumbs, olive oil, burger buns',
 'Carnivore', 'Contains gluten, dairy, and egg', TRUE, 'Meal'),
 
  ('Harissa Prawns with Couscous', 480, 35, 30, 2, 2, 22, 3, 15, 120, 500, 100, 1.9,
 'Prawns, couscous, harissa paste, lemon juice, coriander, olive oil, garlic',
 'Pescatarian', 'Contains shellfish and gluten', TRUE, 'Meal'),
 
  ('Herb Baked Cod', 410, 36, 10, 1, 1, 25, 4, 18, 70, 450, 80, 1.2,
 'Cod fillet, parsley, dill, lemon zest, breadcrumbs, olive oil, garlic',
 'Pescatarian', 'Contains gluten', TRUE, 'Meal'),
 
  ('Cauliflower Black Bean Stew', 407, 33.6, 52.8, 6.0, 7.4, 1.8, 15.2, 40, 421, 249, 249, 3.2,
  'milk, black beans, garlic, yogurt, herbs, cauliflower, cheese, lemon juice, sour cream',
  'Vegetarian', 'GF', TRUE, 'Meal'),
  
  ('Chickpea and Paneer Curry', 464, 23.2, 32.6, 4.7, 8.1, 7.3, 12.4, 20, 0, 656, 179, 3.7,
    'bell pepper, chickpeas, mushrooms, almonds, ginger, olive oil, tomatoes, soy sauce, paneer, multigrain bread, garlic, carrot',
    'Vegetarian', 'Contains Dairy', TRUE, 'Meal'),
    
  ('Spinach and Cheese Quiona Bake', 526, 26.3, 58.6, 9.3, 7.6, 5.4, 8.6, 30, 0, 797, 186, 2.4,
 'cheese, quinoa, basil, mushrooms, onion, spinach, sunflower seeds, lemon juice',
 'Vegetarian', 'Contains Dairy', TRUE, 'Meal'),
 
  ('Eggplant and Tofu Bake', 309, 29.7, 58.0, 4.7, 5.7, 1.7, 13.8, 0, 0, 320, 136, 2.2,
 'eggplant, sour cream, oats, cucumber, spices, tofu, broccoli, multigrain bread, olive oil, onion',
 'Vegetarian', 'Contains Gluten', TRUE, 'Meal'),
 
  ('Lentil and Paneer Wrap', 388, 12.8, 38.5, 2.3, 4.0, 2.0, 9.7, 0, 50, 358, 54, 1.8,
 'pumpkin seeds, pasta, lentils, broccoli, paneer, chickpeas, almonds, bell pepper, whole wheat tortillas',
 'Vegetarian', 'Contains Gluten', TRUE, 'Meal'),
 
  ('Coconut Curry Paste', 366, 28.0, 49.5, 3.6, 5.9, 4.5, 9.2, 0, 30, 649, 116, 3.0,
 'coconut milk, sesame oil, black beans, mushrooms, cheese, lentils, parsley, cucumber, chickpeas, olive oil, pasta, milk, paneer, kale',
 'Vegetarian', 'Contains Gluten', TRUE, 'Meal'),
 
  ('Quinoa and Paneer Avocado Salad', 528, 11.1, 52.4, 3.1, 5.7, 5.4, 9.6, 0, 20, 439, 117, 1.9,
 'avocado, basil, carrot, coriander, lemon juice, soy sauce, paneer, garlic, broccoli, pumpkin seeds, quinoa, cheese',
 'Vegetarian', 'Egg-Free', TRUE, 'Meal'),
 
  ('Cauliflower and Lentil Tacos', 352, 24.3, 51.1, 3.0, 3.6, 4.1, 14.4, 0, 0, 561, 130, 2.7,
 'avocado, basil, carrot, coriander, lemon juice, soy sauce, paneer, garlic, broccoli, pumpkin seeds, quinoa, cheese',
 'Vegetarian', 'Contains Gluten', TRUE, 'Meal'),
 
  ('Tempeh and Tofu Cauliflower Wraps', 303, 19.6, 47.7, 5.3, 8.6, 1.4, 19.9, 0, 40, 300, 142, 3.1,
 'cauliflower, milk, sesame oil, tomatoes, eggs, lentils, tempeh, tofu, olive oil, sour cream, cheese, whole wheat tortillas',
 'Vegetarian', 'NF', TRUE, 'Meal'),
 
  ('Quinoa and Lentil Stir-fry', 303, 12.6, 36.7, 8.4, 5.8, 5.5, 8.5, 0, 0, 433, 199, 1.9,
 'spices, soy sauce, sesame oil, yogurt, quinoa, zucchini, lentils, basil, cottage cheese, spinach, lemon juice',
 'Vegetarian', 'Egg-Free', TRUE, 'Meal'),
 
  ('Chickpea and Kale Veggie Wraps', 519, 24.0, 48.2, 8.1, 9.9, 1.2, 8.8, 0, 60, 337, 188, 3.3,
 'broccoli, chickpeas, cashews, garlic, sesame oil, cottage cheese, avocado, sour cream, mushrooms, eggs, coriander, almonds, kale, whole wheat tortillas',
 'Vegetarian', 'GF', TRUE, 'Meal'),
 
  ('Lentil and Blackbean Stir-fry', 445, 11.8, 49.1, 7.0, 4.8, 4.2, 14.3, 0, 50, 378, 167, 2.3,
 'almonds, garlic, black beans, lentils, soy sauce, brown rice, lemon juice, oats, multigrain bread, cottage cheese, broccoli',
 'Vegetarian', 'Egg-Free', TRUE, 'Meal'),
 
  ('Paneer and Tempeh Curry', 408, 18.5, 46.2, 6.3, 7.8, 1.4, 5.9, 0, 30, 706, 168, 1.6,
 'paneer, onion, zucchini, coriander, soy sauce, tempeh, yogurt, tomatoes, lentils, peanuts, pumpkin seeds',
 'Vegetarian', 'GF', TRUE, 'Meal'),
 
  ('Cottage Cheese and Avocado Quinoa Bowl', 392, 14.6, 59.2, 8.3, 5.1, 4.2, 0, 8.2, 30, 753, 70, 3.2,
 'cottage cheese, avocado, coconut milk, sour cream, oats, garlic, sesame oil, quinoa, coriander, milk, multigrain bread, spices, olive oil',
 'Vegetarian', 'GF', TRUE, 'Meal'),
 
  ('Seed-packed Tofu Wrap', 585, 16.1, 59.7, 7.9, 3.7, 5.2, 17.9, 0, 40, 330, 54, 1.6,
 'tofu, sunflower seeds, pumpkin seeds, parsley, cashews, whole wheat tortillas, oats, almonds, milk, avocado',
 'Vegetarian', 'NF', TRUE, 'Meal'),
 
  ('Sweet-Potato and Lentil Stew', 306, 33.0, 35.4, 3.0, 5.9, 6.5, 0, 16.3, 50, 349, 150, 1.3,
 'onion, carrot, sunflower seeds, broccoli, spinach, cheese, lentils, sweet potato, ginger',
 'Vegetarian', 'Egg-Free', TRUE, 'Meal'),
 
  ('Coconut Lentil and Vegetable Curry', 491, 13.5, 39.2, 5.4, 7.2, 4.3, 7.8, 0, 40, 369, 217, 1.6,
 'carrot, pumpkin seeds, avocado, cashews, bell pepper, cauliflower, lentils, sesame oil, ginger, coconut milk, eggplant, zucchini, eggs',
 'Vegetarian', 'NF', TRUE, 'Meal'),
 
  ('Mushroom and Tempeh Wraps', 362, 17.9, 40.7, 9.7, 8.5, 4.2, 7.5, 0, 50, 549, 205, 2.9,
 'mushrooms, lemon juice, peanuts, quinoa, garlic, almonds, whole wheat tortillas, cottage cheese, pumpkin seeds, sunflower seeds, sesame oil, basil, spices, tempeh',
 'Vegetarian', 'NF', TRUE, 'Meal');
 

 
 SELECT * FROM meals;
