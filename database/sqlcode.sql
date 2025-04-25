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
 'Vegetarian', 'NF', TRUE, 'Meal');


-- Drop tables if they exist to avoid conflicts
DROP TABLE IF EXISTS MealNutrition;
DROP TABLE IF EXISTS Meals;
DROP TABLE IF EXISTS DietCategories;

-- Create DietCategories table
CREATE TABLE DietCategories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(20) NOT NULL
);

-- Create Meals table
CREATE TABLE Meals (
    MealID INT PRIMARY KEY,
    Ingredients TEXT NOT NULL,
    DietCategoryID INT,
    DietNotes TEXT,
    IsHomeCooked BOOLEAN NOT NULL,
    IsMealOrSnack VARCHAR(5) NOT NULL,
    FOREIGN KEY (DietCategoryID) REFERENCES DietCategories(CategoryID)
);

-- Create MealNutrition table
CREATE TABLE MealNutrition (
    NutritionID INT PRIMARY KEY,
    MealID INT NOT NULL,
    Calories_cal INT NOT NULL,
    Protein_g DECIMAL(5,2) NOT NULL,
    Carbs_g DECIMAL(5,2) NOT NULL,
    Sugars_g DECIMAL(5,2) NOT NULL,
    Fibers_g DECIMAL(5,2) NOT NULL,
    Fat_g DECIMAL(5,2) NOT NULL,
    SatFat_g DECIMAL(5,2) NOT NULL,
    UnsatFat_g DECIMAL(5,2) NOT NULL,
    Cholesterol_mg INT NOT NULL,
    Sodium_mg INT NOT NULL,
    Calcium_mg INT NOT NULL,
    Iron_mg DECIMAL(3,2) NOT NULL,
    VitaminA INT,
    VitaminC INT,
    FOREIGN KEY (MealID) REFERENCES Meals(MealID)
);

-- Insert diet categories
INSERT INTO DietCategories (CategoryID, CategoryName) VALUES
(1, 'Carnivore'),
(2, 'Vegetarian'),
(3, 'Pescatarian'),
(4, 'Vegan'),
(0, 'None');  -- For null category

-- Create indexes for performance
CREATE INDEX idx_meals_diet ON Meals(DietCategoryID);
CREATE INDEX idx_nutrition_meal ON MealNutrition(MealID);

-- Example queries

-- 1. Find meals that are high in protein (>30g) and low in carbs (<30g)
SELECT m.MealID, m.Ingredients, n.Protein_g, n.Carbs_g
FROM Meals m
JOIN MealNutrition n ON m.MealID = n.MealID
WHERE n.Protein_g > 30 AND n.Carbs_g < 30
ORDER BY n.Protein_g DESC;

-- 2. Get average nutritional values by diet category
SELECT 
    dc.CategoryName,
    COUNT(*) AS MealCount,
    ROUND(AVG(n.Calories_cal), 2) AS AvgCalories,
    ROUND(AVG(n.Protein_g), 2) AS AvgProtein,
    ROUND(AVG(n.Carbs_g), 2) AS AvgCarbs,
    ROUND(AVG(n.Fat_g), 2) AS AvgFat
FROM MealNutrition n
JOIN Meals m ON n.MealID = m.MealID
JOIN DietCategories dc ON m.DietCategoryID = dc.CategoryID
WHERE dc.CategoryID != 0
GROUP BY dc.CategoryName
ORDER BY AvgCalories DESC;

-- 3. Find meals that meet specific nutrition requirements (e.g., high fiber, low sodium)
SELECT m.MealID, m.Ingredients, n.Fibers_g, n.Sodium_mg
FROM Meals m
JOIN MealNutrition n ON m.MealID = n.MealID
WHERE n.Fibers_g > 8 AND n.Sodium_mg < 600
ORDER BY n.Fibers_g DESC;

-- 4. Get gluten-free meals sorted by protein content
SELECT m.MealID, m.Ingredients, m.DietNotes, n.Protein_g
FROM Meals m
JOIN MealNutrition n ON m.MealID = n.MealID
WHERE m.DietNotes LIKE '%Gluten-Free%'
ORDER BY n.Protein_g DESC
LIMIT 10;

-- Insert all meals (1-170)
INSERT INTO Meals (MealID, Ingredients, DietCategoryID, DietNotes, IsHomeCooked, IsMealOrSnack) VALUES
(1, 'Chicken thighs, onion, garlic, red bell pepper, black beans, quinoa', 1, 'Gluten-Free; Contains legumes', 1, 'Meal'),
(2, 'Tortillas, black beans, corn, red bell pepper, onion, tomato, avocado', 2, 'Contains dairy and gluten; Lacto-vegetarian', 1, 'Meal'),
(3, 'Sirloin steak, brown rice, black beans, corn, cheese, salsa', 1, 'Gluten-Free; Contains red meat', 1, 'Meal'),
(4, 'Chicken thighs, red bell peppers, red onion, garlic, spinach, almonds', 1, 'Gluten-Free; Contains nuts', 1, 'Meal'),
(5, 'Pork chops, honey, wholegrain mustard, new potatoes, green beans', 1, 'Gluten-Free; Contains pork', 1, 'Meal'),
(6, 'Chicken thighs, mushrooms, onion, garlic, chicken stock, sour cream', 1, 'Gluten-Free; Contains dairy', 1, 'Meal'),
(7, 'Chicken breast, chorizo, red peppers, onion, garlic, rice, tomatoes', 1, 'Contains pork; Not suitable for vegetarians/vegans', 1, 'Meal'),
(8, 'Salmon fillet, arborio rice, onion, garlic, vegetable stock, parmesan', 3, 'Gluten-Free; Contains dairy', 1, 'Meal'),
(9, 'Turkey mince, egg noodles, garlic, chili flakes, soy sauce, sesame oil', 1, 'Contains soy and gluten', 1, 'Meal'),
(10, 'Lamb mince, feta cheese, onion, garlic, chili flakes, mint, pitta bread', 1, 'Contains dairy and gluten', 1, 'Meal'),
(11, 'Canned tuna, sweetcorn, egg, breadcrumbs, spring onion, lemon juice', 3, 'Contains gluten and egg', 1, 'Meal'),
(12, 'Chicken breast, Greek yogurt, garlic, lemon, cucumber, mint, pitta bread', 1, 'Gluten-Free; Contains dairy', 1, 'Meal'),
(13, 'Salmon fillet, Cajun seasoning, corn, red onion, red pepper, lime, rice', 3, 'Gluten-Free; Dairy-Free', 1, 'Meal'),
(14, 'Turkey mince, spinach, feta, egg, garlic, breadcrumbs, burger buns', 1, 'Contains gluten, dairy, and egg', 1, 'Meal'),
(15, 'Chicken breast, lentils, carrot, celery, onion, garlic, vegetable stock', 1, 'Gluten-Free; High Fiber', 1, 'Meal'),
(16, 'Prawns, couscous, harissa paste, lemon juice, cucumber, mint, tomatoes', 3, 'Contains shellfish and gluten', 1, 'Meal'),
(17, 'Firm tofu, bell pepper, broccoli, garlic, soy sauce, sesame oil, rice', 4, 'Gluten-Free (if using tamari); Contains soy and sesame', 1, 'Meal'),
(18, 'Cod fillet, parsley, dill, lemon zest, breadcrumbs, new potatoes, peas', 3, 'Contains gluten', 1, 'Meal'),
(19, 'Cottage cheese, eggs, oats, banana, baking powder, berries, maple syrup', 2, 'Gluten-Free (if using GF oats); Contains dairy and eggs', 1, 'Meal'),
(20, 'NULL', 0, 'NULL', 0, 'NULL'),

(21 , 'Ground turkey, bell peppers, onion, garlic, tomato sauce, spices, brown rice', 1, 'Gluten-Free; High protein', 1, 'Meal'),
(22, 'Quinoa, roasted chickpeas, cucumber, cherry tomatoes, red onion, feta, olive oil, lemon juice', 2, 'Contains dairy and gluten; High in fiber', 1, 'Meal'),
(23, 'Cod, lemon, dill, asparagus, baby potatoes, olive oil, garlic', 3, 'Gluten-Free; High in omega-3', 1, 'Meal'),
(24, 'Tofu, broccoli, carrots, snap peas, brown rice, soy sauce, sesame oil, ginger', 4, 'Contains soy and gluten', 1, 'Meal'),
(25, 'Grilled chicken, sweet potato, kale, olive oil, garlic, herbs', 1, 'Gluten-Free; High fiber', 1, 'Meal'),
(26, 'Shrimp, garlic, butter, white wine, parsley, linguine pasta', 3, 'Contains gluten and dairy', 1, 'Meal'),
(27, 'Lentil soup, carrots, celery, onion, tomato, spinach, herbs', 4, 'Gluten-Free; High in fiber and protein', 1, 'Meal'),
(28, 'Black bean burger, whole wheat bun, lettuce, tomato, avocado, red onion', 2, 'Contains gluten; High fiber', 1, 'Meal'),
(29, 'Baked salmon, quinoa, roasted brussels sprouts, lemon, dill', 3, 'Gluten-Free; High in omega-3', 1, 'Meal'),
(30, 'Roast beef, mashed potatoes, gravy, roasted carrots, green beans', 1, 'Contains gluten and dairy', 1, 'Meal'),
(31, 'Greek yogurt, berries, honey, granola, nuts', 2, 'Contains dairy and gluten; Contains nuts', 1, 'Snack'),
(32, 'Hummus, carrot sticks, cucumber slices, bell pepper strips', 4, 'Gluten-Free; Contains legumes', 1, 'Snack'),
(33, 'Whole grain toast, avocado, cherry tomatoes, red pepper flakes, olive oil', 4, 'Contains gluten; High fiber', 1, 'Snack'),
(34, 'Grilled chicken salad, mixed greens, cucumber, tomato, balsamic vinaigrette', 1, 'Gluten-Free; Low carb', 1, 'Meal'),
(35, 'Turkey and avocado wrap, whole grain tortilla, lettuce, tomato', 1, 'Contains gluten', 1, 'Meal'),
(36, 'Beef stir-fry, bell peppers, broccoli, snow peas, brown rice, soy sauce', 1, 'Contains gluten and soy', 1, 'Meal'),
(37, 'Veggie burger, whole wheat bun, lettuce, tomato, pickles, vegan mayo', 4, 'Contains gluten; Contains soy', 0, 'Meal'),
(38, 'Greek salad, cucumber, tomato, red onion, feta cheese, kalamata olives, olive oil', 2, 'Gluten-Free; Contains dairy', 1, 'Meal'),
(39, 'Chicken fajitas, bell peppers, onions, corn tortillas, guacamole, salsa', 1, 'Gluten-Free; Contains avocado', 1, 'Meal'),
(40, 'Tuna sandwich, whole grain bread, lettuce, tomato, mayo', 3, 'Contains gluten and egg', 1, 'Meal'),
(41, 'Vegetable soup, carrots, celery, onion, potatoes, green beans, tomatoes', 4, 'Gluten-Free; High fiber', 1, 'Meal'),
(42, 'Meatballs, tomato sauce, whole wheat spaghetti, parmesan cheese', 1, 'Contains gluten and dairy', 1, 'Meal'),
(43, 'Baked tilapia, roasted sweet potatoes, steamed broccoli, lemon', 3, 'Gluten-Free; High fiber', 1, 'Meal'),
(44, 'Egg salad, whole grain crackers, mixed greens', 2, 'Contains gluten and egg', 1, 'Snack'),
(45, 'Fruit smoothie, banana, berries, yogurt, almond milk, protein powder', 2, 'Gluten-Free; Contains dairy', 1, 'Snack'),
(46, 'Chicken noodle soup, carrots, celery, onion, egg noodles', 1, 'Contains gluten and egg', 1, 'Meal'),
(47, 'Bean and cheese quesadilla, whole wheat tortilla, salsa', 2, 'Contains gluten and dairy; Contains legumes', 1, 'Meal'),
(48, 'Pork tenderloin, mashed sweet potatoes, roasted asparagus, garlic, herbs', 1, 'Gluten-Free; Contains pork', 1, 'Meal'),
(49, 'Vegetable curry, chickpeas, coconut milk, mixed vegetables, brown rice', 4, 'Gluten-Free; Contains legumes', 1, 'Meal'),
(50, 'Turkey and cheese roll-ups, lettuce, tomato, mustard', 1, 'Gluten-Free; Contains dairy', 1, 'Snack'),
(51, 'Chicken Caesar salad, romaine lettuce, parmesan, croutons, Caesar dressing', 1, 'Contains gluten, dairy, and egg', 1, 'Meal'),
(52, 'Beef and vegetable stew, potatoes, carrots, onions, celery, peas', 1, 'Gluten-Free; High fiber', 1, 'Meal'),
(53, 'Falafel, pita bread, tahini sauce, lettuce, tomato, cucumber', 2, 'Contains gluten and sesame; Contains legumes', 1, 'Meal'),
(54, 'Mushroom and spinach frittata, eggs, onions, cheese', 2, 'Gluten-Free; Contains dairy and egg', 1, 'Meal'),
(55, 'Grilled steak, roasted potatoes, grilled zucchini, garlic butter', 1, 'Gluten-Free; Contains dairy', 1, 'Meal'),
(56, 'Cauliflower rice stir-fry, tofu, mixed vegetables, soy sauce, sesame oil', 4, 'Gluten-Free; Contains soy', 1, 'Meal'),
(57, 'Baked cod, mashed cauliflower, roasted brussels sprouts, lemon, garlic', 3, 'Gluten-Free; Low carb', 1, 'Meal'),
(58, 'Turkey chili, beans, tomatoes, onions, bell peppers, spices', 1, 'Gluten-Free; Contains legumes', 1, 'Meal'),
(59, 'Lentil and vegetable stew, carrots, celery, onion, tomatoes, spinach', 4, 'Gluten-Free; High fiber and protein', 1, 'Meal'),
(60, 'Caprese sandwich, whole grain bread, mozzarella, tomato, basil, balsamic glaze', 2, 'Contains gluten and dairy', 1, 'Meal'),
(61, 'Peanut butter and banana sandwich, whole grain bread', 4, 'Contains gluten and nuts', 1, 'Snack'),
(62, 'Trail mix, nuts, dried fruit, dark chocolate', 4, 'Gluten-Free; Contains nuts', 0, 'Snack'),
(63, 'Chicken and vegetable kebabs, bell peppers, onions, zucchini, olive oil, herbs', 1, 'Gluten-Free; Low carb', 1, 'Meal'),
(64, 'Mediterranean bowl, quinoa, chickpeas, cucumber, tomato, feta, olives, tzatziki', 2, 'Contains dairy; Contains legumes', 1, 'Meal'),
(65, 'Sushi roll, salmon, avocado, cucumber, rice, nori', 3, 'Contains gluten (soy sauce)', 0, 'Meal'),
(66, 'Buffalo chicken wrap, whole wheat tortilla, lettuce, tomato, blue cheese', 1, 'Contains gluten and dairy', 1, 'Meal'),
(67, 'Peanut butter and apple slices', 4, 'Gluten-Free; Contains nuts', 1, 'Snack'),
(68, 'Cottage cheese, pineapple chunks, honey', 2, 'Gluten-Free; Contains dairy', 1, 'Snack'),
(69, 'Edamame, sea salt', 4, 'Gluten-Free; Contains soy', 0, 'Snack'),
(70, 'Beef tacos, corn tortillas, lettuce, tomato, cheese, salsa', 1, 'Gluten-Free; Contains dairy', 1, 'Meal'),
(71, 'Mushroom risotto, arborio rice, parmesan cheese, garlic, onion', 2, 'Contains dairy; Contains gluten', 1, 'Meal'),
(72, 'Black bean and sweet potato enchiladas, corn tortillas, cheese, enchilada sauce', 2, 'Gluten-Free; Contains dairy and legumes', 1, 'Meal'),
(73, 'Chicken marsala, mushrooms, marsala wine, onion, garlic, parsley', 1, 'Contains gluten', 1, 'Meal'),
(74, 'Shrimp scampi, linguine pasta, garlic, butter, white wine, parsley', 3, 'Contains gluten and dairy', 1, 'Meal'),
(75, 'Eggplant parmesan, tomato sauce, mozzarella, basil, breadcrumbs', 2, 'Contains gluten and dairy', 1, 'Meal'),
(76, 'Beef stew, carrots, potatoes, onions, celery, garlic, rosemary', 1, 'Gluten-Free', 1, 'Meal'),
(77, 'Lemon pepper tilapia, quinoa, roasted broccoli', 3, 'Gluten-Free', 1, 'Meal'),
(78, 'Baked chicken, sweet potato, green beans, olive oil, herbs', 1, 'Gluten-Free; High fiber', 1, 'Meal'),
(79, 'Rice and beans, bell peppers, onions, garlic, cumin, cilantro', 4, 'Gluten-Free; Contains legumes', 1, 'Meal'),
(80, 'Grilled cheese sandwich, whole grain bread, cheddar cheese, tomato', 2, 'Contains gluten and dairy', 1, 'Meal'),
(81, 'Chicken quesadilla, flour tortilla, bell peppers, onions, cheese', 1, 'Contains gluten and dairy', 1, 'Meal'),
(82, 'Tofu stir-fry, brown rice, bell peppers, broccoli, carrots, soy sauce', 4, 'Contains gluten and soy', 1, 'Meal'),
(83, 'Beef and broccoli, brown rice, garlic, ginger, soy sauce', 1, 'Contains gluten', 1, 'Meal'),
(84, 'Veggie pizza, whole wheat crust, tomato sauce, bell peppers, mushrooms, onions, cheese', 2, 'Contains gluten and dairy', 0, 'Meal'),
(85, 'Tuna melt, whole grain bread, tuna, mayo, cheese', 3, 'Contains gluten, dairy, and egg', 1, 'Meal'),
(86, 'Buffalo cauliflower bites, hot sauce, flour, garlic powder', 4, 'Contains gluten', 1, 'Snack'),
(87, 'Chicken parmesan, spaghetti, tomato sauce, mozzarella, parmesan', 1, 'Contains gluten and dairy', 1, 'Meal'),
(88, 'Beef burger, whole wheat bun, lettuce, tomato, onion, pickles', 1, 'Contains gluten', 1, 'Meal'),
(89, 'Salmon cakes, quinoa, mixed green salad, lemon vinaigrette', 3, 'Contains gluten and egg', 1, 'Meal'),
(90, 'Egg fried rice, peas, carrots, onions, garlic, soy sauce', 2, 'Contains gluten, egg, and soy', 1, 'Meal'),
(91, 'Chicken enchiladas, corn tortillas, enchilada sauce, cheese, onions', 1, 'Gluten-Free; Contains dairy', 1, 'Meal'),
(92, 'Tuna salad, mixed greens, olives, tomatoes, cucumber, olive oil', 3, 'Gluten-Free; High protein', 1, 'Meal'),
(93, 'Beef stroganoff, mushrooms, onions, sour cream, egg noodles', 1, 'Contains gluten and dairy', 1, 'Meal'),
(94, 'Baked ziti, tomato sauce, ricotta, mozzarella, parmesan', 2, 'Contains gluten and dairy', 1, 'Meal'),
(95, 'Shrimp and grits, bell peppers, onions, garlic, cheese', 3, 'Contains dairy; Contains gluten', 1, 'Meal'),
(96, 'Chicken tortilla soup, tomatoes, corn, black beans, tortilla chips', 1, 'Contains gluten; Contains legumes', 1, 'Meal'),
(97, 'Ratatouille, eggplant, zucchini, bell peppers, tomatoes, onions, garlic', 4, 'Gluten-Free; High fiber', 1, 'Meal'),
(98, 'Meatloaf, mashed potatoes, green beans, gravy', 1, 'Contains gluten, dairy, and egg', 1, 'Meal'),
(99, 'Vegetable lasagna, zucchini, spinach, ricotta, mozzarella, tomato sauce', 2, 'Contains gluten and dairy', 1, 'Meal'),
(100, 'Chicken and rice soup, carrots, celery, onions, garlic', 1, 'Gluten-Free', 1, 'Meal'),
(101, 'Lamb curry, rice, potatoes, carrots, onions, garlic, ginger, spices', 1, 'Gluten-Free', 1, 'Meal'),
(102, 'Spaghetti carbonara, bacon, eggs, parmesan, black pepper', 1, 'Contains gluten, dairy, and egg', 1, 'Meal'),
(103, 'Spinach and feta stuffed chicken, quinoa, roasted vegetables', 1, 'Gluten-Free; Contains dairy', 1, 'Meal'),
(104, 'Pork chops, applesauce, roasted potatoes, green beans', 1, 'Gluten-Free; Contains pork', 1, 'Meal'),
(105, 'Bean burrito, flour tortilla, refried beans, rice, cheese, salsa', 2, 'Contains gluten and dairy; Contains legumes', 0, 'Meal'),
(106, 'Turkey and cranberry wrap, whole wheat tortilla, lettuce', 1, 'Contains gluten', 1, 'Meal'),
(107, 'Butternut squash soup, onions, garlic, vegetable broth, cream', 2, 'Gluten-Free; Contains dairy', 1, 'Meal'),
(108, 'Baked chicken wings, buffalo sauce, celery, carrot sticks, blue cheese dressing', 1, 'Gluten-Free; Contains dairy', 1, 'Meal'),
(109, 'Coconut curry lentils, mixed vegetables, brown rice', 4, 'Gluten-Free; Contains legumes', 1, 'Meal'),
(110, 'Grilled fish tacos, corn tortillas, cabbage slaw, lime crema', 3, 'Gluten-Free; Contains dairy', 1, 'Meal'),
(111, 'Bbq pulled pork, whole wheat bun, coleslaw', 1, 'Contains gluten; Contains pork', 1, 'Meal'),
(112, 'Minestrone soup, beans, pasta, mixed vegetables, tomato broth', 2, 'Contains gluten; Contains legumes', 1, 'Meal'),
(113, 'Ahi tuna poke bowl, brown rice, avocado, cucumber, seaweed, soy sauce', 3, 'Contains gluten and soy', 0, 'Meal'),
(114, 'Chicken and dumplings, carrots, celery, onions, peas', 1, 'Contains gluten and dairy', 1, 'Meal'),
(115, 'Chickpea salad sandwich, whole grain bread, mayo, celery, onion', 4, 'Contains gluten; Contains legumes', 1, 'Meal'),
(116, 'Beef stir-fry, rice noodles, bell peppers, snap peas, carrots, soy sauce', 1, 'Contains gluten', 1, 'Meal'),
(117, 'Spinach and mushroom quiche, pie crust, eggs, cheese', 2, 'Contains gluten, dairy, and egg', 1, 'Meal'),
(118, 'Baked mahi-mahi, wild rice, roasted asparagus, lemon', 3, 'Gluten-Free', 1, 'Meal'),
(119, 'Turkey meatballs, whole wheat pasta, tomato sauce, parmesan', 1, 'Contains gluten and dairy', 1, 'Meal'),
(120, 'Vegan chili, beans, tomatoes, bell peppers, onions, spices', 4, 'Gluten-Free; Contains legumes', 1, 'Meal'),
(121, 'Steak salad, mixed greens, cherry tomatoes, blue cheese, balsamic vinaigrette', 1, 'Gluten-Free; Contains dairy', 1, 'Meal'),
(122, 'Shakshuka, eggs, tomatoes, bell peppers, onions, garlic, spices', 2, 'Gluten-Free; Contains egg', 1, 'Meal'),
(123, 'Grilled shrimp skewers, quinoa, grilled vegetables', 3, 'Gluten-Free', 1, 'Meal'),
(124, 'Roast turkey, stuffing, mashed potatoes, green beans, cranberry sauce', 1, 'Contains gluten and dairy', 1, 'Meal'),
(125, 'Black bean and corn salad, bell peppers, red onion, cilantro, lime juice', 4, 'Gluten-Free; Contains legumes', 1, 'Snack'),
(126, 'Chicken lettuce wraps, water chestnuts, carrots, mushrooms, soy sauce', 1, 'Gluten-Free; Contains soy', 1, 'Meal'),
(127, 'Pasta primavera, whole wheat pasta, mixed vegetables, garlic, olive oil', 4, 'Contains gluten', 1, 'Meal'),
(128, 'Stuffed bell peppers, ground beef, rice, tomatoes, onions, cheese', 1, 'Gluten-Free; Contains dairy', 1, 'Meal'),
(129, 'Lobster mac and cheese, elbow pasta, cheddar, gruyere', 3, 'Contains gluten and dairy', 1, 'Meal'),
(130, 'Pumpkin soup, onions, garlic, vegetable broth, cream', 2, 'Gluten-Free; Contains dairy', 1, 'Meal'),
(131, 'Chicken pot pie, carrots, peas, onions, pie crust', 1, 'Contains gluten and dairy', 1, 'Meal'),
(132, 'Three bean salad, green beans, kidney beans, chickpeas, red onion, vinaigrette', 4, 'Gluten-Free; Contains legumes', 1, 'Snack'),
(133, 'Grilled pork chops, roasted potatoes, green beans, applesauce', 1, 'Gluten-Free; Contains pork', 1, 'Meal'),
(134, 'Mushroom barley soup, carrots, celery, onions, garlic', 4, 'Contains gluten; High fiber', 1, 'Meal'),
(135, 'Tuna casserole, egg noodles, peas, cream of mushroom soup, cheese', 3, 'Contains gluten, dairy, and egg', 1, 'Meal'),
(136, 'Chicken shawarma, pita bread, lettuce, tomato, cucumber, yogurt sauce', 1, 'Contains gluten and dairy', 1, 'Meal'),
(137, 'Sweet potato and black bean enchiladas, corn tortillas, cheese, enchilada sauce', 2, 'Gluten-Free; Contains dairy and legumes', 1, 'Meal'),
(138, 'Beef kabobs, bell peppers, onions, mushrooms, olive oil, herbs', 1, 'Gluten-Free', 1, 'Meal'),
(139, 'Spinach and artichoke dip, whole grain crackers', 2, 'Contains gluten and dairy', 1, 'Snack'),
(140, 'Shrimp and vegetable stir-fry, brown rice, broccoli, carrots, snap peas, soy sauce', 3, 'Contains gluten', 1, 'Meal'),
(141, 'Stuffed acorn squash, quinoa, cranberries, pecans, maple syrup', 4, 'Gluten-Free; Contains nuts', 1, 'Meal'),
(142, 'Chicken and veggie bowl, brown rice, broccoli, carrots, bell peppers, teriyaki sauce', 1, 'Contains gluten and soy', 1, 'Meal'),
(143, 'Reuben sandwich, rye bread, corned beef, sauerkraut, swiss cheese, thousand island', 1, 'Contains gluten and dairy', 1, 'Meal'),
(144, 'Farro bowl, mixed vegetables, feta cheese, olive oil, lemon juice', 2, 'Contains gluten and dairy', 1, 'Meal'),
(145, 'Clam chowder, potatoes, celery, onions, bacon, cream', 3, 'Contains gluten, dairy, and pork', 1, 'Meal'),
(146, 'Buffalo chicken salad, romaine lettuce, celery, carrots, blue cheese', 1, 'Gluten-Free; Contains dairy', 1, 'Meal'),
(147, 'Vegetable stir-fry, tofu, mixed vegetables, brown rice, teriyaki sauce', 4, 'Contains gluten and soy', 1, 'Meal'),
(148, 'Beef lettuce wraps, water chestnuts, carrots, mushrooms, soy sauce', 1, 'Gluten-Free; Contains soy', 1, 'Meal'),
(149, 'Spinach and strawberry salad, walnuts, feta cheese, balsamic vinaigrette', 2, 'Gluten-Free; Contains dairy and nuts', 1, 'Meal'),
(150, 'Tuna niçoise salad, potatoes, green beans, olives, eggs, vinaigrette', 3, 'Gluten-Free; Contains egg', 1, 'Meal'),
(151, 'Chicken piccata, capers, lemon, white wine, pasta', 1, 'Contains gluten', 1, 'Meal'),
(152, 'Roasted vegetable quinoa bowl, sweet potatoes, broccoli, chickpeas, tahini', 4, 'Gluten-Free; Contains sesame and legumes', 1, 'Meal'),
(153, 'Beef tacos, corn tortillas, lettuce, tomato, cheese, guacamole', 1, 'Gluten-Free; Contains dairy', 1, 'Meal'),
(154, 'Egg drop soup, green onions, corn, carrots', 2, 'Gluten-Free; Contains egg', 1, 'Meal'),
(155, 'Crab cakes, mixed green salad, remoulade sauce', 3, 'Contains gluten, egg, and shellfish', 1, 'Meal'),
(156, 'Chicken alfredo, fettuccine pasta, heavy cream, parmesan cheese', 1, 'Contains gluten and dairy', 1, 'Meal'),
(157, 'Mediterranean chickpea salad, cucumber, tomato, red onion, feta, olives', 2, 'Gluten-Free; Contains dairy and legumes', 1, 'Meal'),
(158, 'Beef and vegetable kabobs, bell peppers, onions, mushrooms, olive oil', 1, 'Gluten-Free', 1, 'Meal'),
(159, 'Vegetable frittata, eggs, bell peppers, spinach, onions, cheese', 2, 'Gluten-Free; Contains dairy and egg', 1, 'Meal'),
(160, 'Smoked salmon bagel, cream cheese, capers, red onion', 3, 'Contains gluten and dairy', 0, 'Meal'),
(161, 'Chicken and broccoli stir-fry, brown rice, garlic, ginger, soy sauce', 1, 'Contains gluten', 1, 'Meal'),
(162, 'Stuffed mushrooms, breadcrumbs, parmesan, garlic, herbs', 2, 'Contains gluten and dairy', 1, 'Snack'),
(163, 'Tilapia fish tacos, corn tortillas, cabbage slaw, lime crema', 3, 'Gluten-Free; Contains dairy', 1, 'Meal'),
(164, 'Beef lasagna, ground beef, tomato sauce, ricotta, mozzarella', 1, 'Contains gluten and dairy', 1, 'Meal'),
(165, 'Lentil and vegetable curry, coconut milk, spices, brown rice', 4, 'Gluten-Free; Contains legumes', 1, 'Meal'),
(166, 'Grilled chicken kabobs, bell peppers, onions, mushrooms, olive oil', 1, 'Gluten-Free', 1, 'Meal'),
(167, 'Caprese salad, tomatoes, fresh mozzarella, basil, balsamic glaze', 2, 'Gluten-Free; Contains dairy', 1, 'Snack'),
(168, 'Shrimp pasta, tomatoes, garlic, white wine, parsley', 3, 'Contains gluten', 1, 'Meal'),
(169, 'Beef and bean chili, onions, bell peppers, tomatoes, spices', 1, 'Gluten-Free; Contains legumes', 1, 'Meal'),
(170, 'Quinoa stuffed peppers, black beans, corn, tomatoes, cheese', 2, 'Gluten-Free; Contains dairy and legumes', 1, 'Meal');

INSERT INTO MealNutrition
  (NutritionID, MealID, Calories_cal, Protein_g, Carbs_g, Sugars_g, Fibers_g, Fat_g, SatFat_g, UnsatFat_g, Cholesterol_mg, Sodium_mg, Calcium_mg, Iron_mg, VitaminA, VitaminC)
VALUES
(1, 1, 600, 45.00, 35.00, 8.00, 7.00, 25.00, 5.00, 18.00, 120, 800, 100, 4.00, NULL, NULL),
(2, 2, 550, 20.00, 50.00, 10.00, 10.00, 20.00, 8.00, 10.00, 25, 600, 200, 3.00, NULL, NULL),
(3, 3, 700, 40.00, 45.00, 5.00, 8.00, 35.00, 10.00, 20.00, 90, 500, 80, 5.00, NULL, NULL),
(4, 4, 650, 35.00, 10.00, 5.00, 3.00, 50.00, 10.00, 35.00, 120, 400, 60, 2.50, NULL, NULL),
(5, 5, 550, 45.00, 25.00, 8.00, 3.00, 30.00, 10.00, 15.00, 100, 500, 40, 2.00, NULL, NULL),
(6, 6, 520, 42.00, 10.00, 4.00, 2.00, 35.00, 10.00, 20.00, 120, 700, 120, 2.20, NULL, NULL),
(7, 7, 630, 38.00, 50.00, 5.00, 4.00, 30.00, 10.00, 18.00, 95, 950, 100, 3.50, NULL, NULL),
(8, 8, 580, 40.00, 35.00, 3.00, 2.00, 30.00, 6.00, 20.00, 80, 600, 180, 2.30, NULL, NULL),
(9, 9, 520, 35.00, 40.00, 5.00, 2.00, 25.00, 5.00, 18.00, 75, 950, 70, 2.10, NULL, NULL),
(10, 10, 620, 38.00, 12.00, 5.00, 2.00, 45.00, 18.00, 20.00, 110, 700, 220, 3.00, NULL, NULL),
(11, 11, 400, 30.00, 20.00, 3.00, 2.00, 22.00, 4.00, 15.00, 70, 500, 60, 1.80, NULL, NULL),
(12, 12, 500, 45.00, 6.00, 4.00, 1.00, 30.00, 8.00, 18.00, 90, 400, 150, 1.60, NULL, NULL),
(13, 13, 540, 38.00, 15.00, 6.00, 3.00, 35.00, 6.00, 25.00, 80, 400, 90, 2.20, NULL, NULL),
(14, 14, 520, 40.00, 20.00, 3.00, 2.00, 30.00, 9.00, 18.00, 95, 600, 180, 2.50, NULL, NULL),
(15, 15, 450, 42.00, 25.00, 6.00, 7.00, 18.00, 3.00, 12.00, 80, 700, 70, 3.80, NULL, NULL),
(16, 16, 480, 35.00, 30.00, 2.00, 2.00, 22.00, 3.00, 15.00, 120, 500, 100, 1.90, NULL, NULL),
(17, 17, 490, 28.00, 18.00, 5.00, 5.00, 35.00, 6.00, 25.00, 0, 600, 220, 3.20, NULL, NULL),
(18, 18, 410, 36.00, 10.00, 1.00, 1.00, 25.00, 4.00, 18.00, 70, 450, 80, 1.20, NULL, NULL),
(19, 19, 450, 28.00, 30.00, 8.00, 4.00, 25.00, 6.00, 15.00, 160, 400, 180, 2.00, NULL, NULL),
(20, 20, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 0.00, NULL, NULL),
(21, 21, 520, 38.00, 42.00, 6.00, 5.00, 22.00, 4.50, 17.50, 85, 650, 80, 3.50, 1200, 80),
(22, 22, 480, 18.00, 65.00, 8.00, 12.00, 18.00, 4.50, 13.50, 25, 580, 220, 4.20, 950, 45),
(23, 23, 380, 32.00, 28.00, 3.00, 4.00, 15.00, 2.00, 13.00, 70, 420, 60, 1.80, 800, 35),
(24, 24, 450, 22.00, 55.00, 6.00, 8.00, 15.00, 2.50, 12.50, 0, 750, 200, 4.50, 1500, 65),
(25, 25, 480, 40.00, 30.00, 8.00, 6.00, 20.00, 3.50, 16.50, 95, 420, 120, 3.20, 2200, 90),
(26, 26, 550, 32.00, 60.00, 3.00, 3.00, 18.00, 8.00, 10.00, 180, 680, 80, 2.50, 400, 15),
(27, 27, 320, 18.00, 45.00, 8.00, 12.00, 8.00, 1.00, 7.00, 0, 580, 100, 4.80, 1800, 25),
(28, 28, 420, 15.00, 50.00, 5.00, 12.00, 18.00, 2.50, 15.50, 0, 550, 100, 3.50, 800, 20),
(29, 29, 520, 42.00, 35.00, 3.00, 6.00, 22.00, 4.00, 18.00, 90, 480, 150, 3.80, 650, 75),
(30, 30, 650, 45.00, 40.00, 8.00, 6.00, 32.00, 12.00, 20.00, 110, 850, 100, 4.50, 1200, 35),
(31, 31, 380, 15.00, 45.00, 25.00, 5.00, 12.00, 3.50, 8.50, 15, 120, 250, 2.00, 150, 35),
(32, 32, 280, 10.00, 30.00, 6.00, 8.00, 14.00, 2.00, 12.00, 0, 350, 80, 2.50, 1500, 120),
(33, 33, 320, 8.00, 35.00, 4.00, 8.00, 18.00, 2.50, 15.50, 0, 250, 40, 2.00, 400, 25),
(34, 34, 380, 35.00, 15.00, 6.00, 4.00, 18.00, 3.00, 15.00, 85, 450, 100, 2.50, 1200, 45),
(35, 35, 450, 28.00, 40.00, 4.00, 8.00, 22.00, 3.50, 18.50, 65, 620, 80, 3.00, 600, 20),
(36, 36, 520, 35.00, 45.00, 5.00, 7.00, 20.00, 6.00, 14.00, 85, 850, 80, 4.50, 1000, 90),
(37, 37, 380, 12.00, 48.00, 6.00, 7.00, 16.00, 1.50, 14.50, 0, 580, 100, 3.50, 700, 15),
(38, 38, 320, 12.00, 12.00, 6.00, 4.00, 25.00, 8.00, 17.00, 35, 850, 250, 2.00, 850, 55),
(39, 39, 520, 38.00, 40.00, 6.00, 8.00, 22.00, 4.50, 17.50, 90, 780, 100, 3.50, 1000, 120),
(40, 40, 420, 28.00, 35.00, 4.00, 5.00, 18.00, 3.00, 15.00, 55, 680, 80, 2.50, 450, 10),
(41, 41, 250, 8.00, 40.00, 8.00, 8.00, 6.00, 1.00, 5.00, 0, 750, 80, 2.50, 1800, 40),
(42, 42, 580, 32.00, 60.00, 8.00, 6.00, 22.00, 8.00, 14.00, 85, 850, 180, 4.00, 800, 25),
(43, 43, 420, 35.00, 35.00, 8.00, 6.00, 12.00, 2.50, 9.50, 85, 350, 100, 2.00, 1800, 120),
(44, 44, 380, 18.00, 28.00, 3.00, 4.00, 22.00, 4.50, 17.50, 380, 550, 80, 2.50, 800, 15),
(45, 45, 320, 20.00, 40.00, 25.00, 5.00, 8.00, 2.00, 6.00, 10, 150, 350, 1.50, 200, 50),
(46, 46, 350, 28.00, 35.00, 6.00, 3.00, 10.00, 2.50, 7.50, 85, 1200, 60, 2.00, 900, 15),
(47, 47, 450, 18.00, 45.00, 3.00, 8.00, 20.00, 8.00, 12.00, 35, 780, 350, 3.50, 600, 10),
(48, 48, 520, 40.00, 35.00, 10.00, 6.00, 20.00, 5.00, 15.00, 100, 580, 100, 3.50, 1500, 25),
(49, 49, 450, 15.00, 60.00, 8.00, 12.00, 16.00, 8.00, 8.00, 0, 680, 120, 4.00, 1800, 60),
(50, 50, 280, 25.00, 8.00, 3.00, 2.00, 18.00, 6.00, 12.00, 65, 850, 250, 1.50, 700, 15),
(51, 51, 420, 32.00, 15.00, 2.00, 3.00, 28.00, 6.00, 22.00, 85, 950, 200, 2.50, 1500, 35),
(52, 52, 450, 35.00, 40.00, 8.00, 8.00, 15.00, 5.00, 10.00, 85, 780, 80, 4.50, 1800, 30),
(53, 53, 520, 18.00, 65.00, 5.00, 10.00, 22.00, 3.00, 19.00, 0, 750, 120, 4.00, 800, 25),
(54, 54, 380, 22.00, 8.00, 3.00, 2.00, 28.00, 10.00, 18.00, 420, 450, 280, 3.50, 1800, 15),
(55, 55, 650, 45.00, 40.00, 4.00, 5.00, 35.00, 15.00, 20.00, 110, 680, 60, 5.00, 600, 20),
(56, 56, 320, 18.00, 25.00, 6.00, 8.00, 16.00, 2.50, 13.50, 0, 750, 200, 3.50, 1500, 80),
(57, 57, 320, 32.00, 20.00, 4.00, 8.00, 14.00, 2.50, 11.50, 85, 520, 100, 2.00, 600, 100),
(58, 58, 420, 35.00, 40.00, 8.00, 10.00, 12.00, 3.00, 9.00, 85, 780, 100, 4.50, 1500, 65),
(59, 59, 350, 18.00, 50.00, 8.00, 12.00, 8.00, 1.00, 7.00, 0, 650, 100, 5.00, 2000, 30),
(60, 60, 450, 20.00, 45.00, 6.00, 5.00, 20.00, 8.00, 12.00, 35, 580, 350, 3.00, 800, 25),
(61, 61, 420, 15.00, 55.00, 18.00, 6.00, 16.00, 3.00, 13.00, 0, 380, 60, 2.50, 100, 10),
(62, 62, 350, 12.00, 30.00, 22.00, 6.00, 20.00, 4.00, 16.00, 0, 150, 100, 2.50, 150, 1),
(63, 63, 380, 35.00, 15.00, 6.00, 4.00, 20.00, 3.50, 16.50, 85, 550, 60, 2.50, 1200, 90),
(64, 64, 520, 20.00, 65.00, 6.00, 12.00, 20.00, 6.00, 14.00, 15, 780, 250, 4.50, 800, 35),
(65, 65, 380, 15.00, 50.00, 2.00, 4.00, 12.00, 2.00, 10.00, 35, 650, 40, 1.50, 150, 5),
(66, 66, 520, 35.00, 40.00, 4.00, 4.00, 25.00, 8.00, 17.00, 95, 1200, 220, 3.00, 600, 15),
(67, 67, 250, 8.00, 25.00, 18.00, 5.00, 12.00, 2.50, 9.50, 0, 150, 40, 1.00, 100, 8),
(68, 68, 280, 25.00, 30.00, 25.00, 2.00, 5.00, 3.00, 2.00, 15, 450, 150, 0.50, 200, 60),
(69, 69, 180, 18.00, 15.00, 2.00, 8.00, 8.00, 1.00, 7.00, 0, 320, 100, 3.50, 200, 15),
(70, 70, 480, 30.00, 40.00, 5.00, 6.00, 22.00, 8.00, 14.00, 85, 850, 250, 3.50, 800, 20),
(71, 71, 520, 15.00, 65.00, 3.00, 3.00, 18.00, 8.00, 10.00, 25, 750, 220, 2.00, 100, 5),
(72, 72, 520, 18.00, 70.00, 10.00, 12.00, 18.00, 6.00, 12.00, 25, 950, 350, 4.50, 1800, 35),
(73, 73, 450, 35.00, 15.00, 4.00, 2.00, 28.00, 6.00, 22.00, 95, 680, 60, 2.50, 100, 10),
(74, 74, 580, 30.00, 60.00, 3.00, 3.00, 22.00, 10.00, 12.00, 180, 780, 80, 2.50, 400, 15),
(75, 75, 480, 18.00, 40.00, 8.00, 6.00, 28.00, 10.00, 18.00, 35, 850, 400, 2.50, 600, 25),
(76, 76, 480, 35.00, 40.00, 8.00, 6.00, 18.00, 6.00, 12.00, 85, 850, 80, 4.50, 1800, 30),
(77, 77, 420, 35.00, 40.00, 2.00, 6.00, 12.00, 2.00, 10.00, 85, 550, 80, 2.00, 600, 100),
(78, 78, 480, 40.00, 35.00, 10.00, 6.00, 16.00, 3.00, 13.00, 95, 450, 80, 2.50, 1800, 20),
(79, 79, 450, 15.00, 75.00, 4.00, 10.00, 8.00, 1.00, 7.00, 0, 450, 80, 4.50, 600, 45),
(80, 80, 480, 20.00, 40.00, 4.00, 5.00, 28.00, 16.00, 12.00, 80, 850, 400, 2.50, 800, 10),
(81, 81, 550, 35.00, 40.00, 4.00, 4.00, 28.00, 10.00, 18.00, 95, 950, 350, 2.50, 800, 30),
(82, 82, 420, 20.00, 60.00, 6.00, 8.00, 12.00, 1.50, 10.50, 0, 850, 200, 4.00, 1500, 80),
(83, 83, 550, 35.00, 55.00, 4.00, 6.00, 22.00, 8.00, 14.00, 85, 950, 80, 4.50, 800, 70),
(84, 84, 580, 22.00, 70.00, 8.00, 6.00, 22.00, 10.00, 12.00, 35, 950, 350, 3.50, 800, 35),
(85, 85, 480, 32.00, 35.00, 4.00, 5.00, 22.00, 8.00, 14.00, 85, 850, 300, 3.00, 400, 1),
(86, 86, 250, 8.00, 40.00, 2.00, 4.00, 8.00, 1.00, 7.00, 0, 850, 40, 1.50, 100, 70),
(87, 87, 650, 45.00, 60.00, 8.00, 4.00, 22.00, 8.00, 14.00, 120, 950, 350, 3.50, 800, 25),
(88, 88, 580, 35.00, 40.00, 6.00, 5.00, 30.00, 12.00, 18.00, 95, 850, 100, 4.50, 800, 15),
(89, 89, 450, 30.00, 40.00, 3.00, 6.00, 18.00, 4.00, 14.00, 120, 650, 120, 3.00, 800, 40),
(90, 90, 480, 18.00, 70.00, 4.00, 4.00, 16.00, 3.50, 12.50, 210, 880, 60, 3.00, 800, 20),
(91, 91, 580, 38.00, 50.00, 6.00, 6.00, 25.00, 8.00, 17.00, 95, 1100, 350, 3.50, 800, 15),
(92, 92, 320, 30.00, 10.00, 4.00, 4.00, 18.00, 3.00, 15.00, 45, 550, 80, 2.50, 1200, 35),
(93, 93, 620, 35.00, 60.00, 6.00, 4.00, 28.00, 12.00, 16.00, 120, 780, 120, 4.50, 400, 10),
(94, 94, 580, 28.00, 60.00, 8.00, 4.00, 25.00, 12.00, 13.00, 80, 950, 450, 3.00, 800, 25),
(95, 95, 520, 28.00, 55.00, 3.00, 3.00, 20.00, 8.00, 12.00, 180, 850, 200, 2.50, 800, 30),
(96, 96, 380, 28.00, 45.00, 8.00, 8.00, 10.00, 2.50, 7.50, 85, 950, 100, 3.50, 1200, 30),
(97, 97, 250, 6.00, 35.00, 12.00, 10.00, 10.00, 1.50, 8.50, 0, 450, 80, 2.50, 1500, 80),
(98, 98, 650, 40.00, 45.00, 6.00, 5.00, 35.00, 12.00, 23.00, 120, 980, 100, 4.50, 1000, 15),
(99, 99, 520, 25.00, 40.00, 8.00, 6.00, 28.00, 12.00, 16.00, 80, 850, 450, 3.00, 2000, 35),
(100, 100, 320, 25.00, 40.00, 4.00, 3.00, 8.00, 2.00, 6.00, 85, 980, 60, 2.00, 900, 15),
(101, 101, 650, 35.00, 60.00, 6.00, 5.00, 28.00, 12.00, 16.00, 95, 850, 100, 4.50, 1000, 35),
(102, 102, 620, 25.00, 60.00, 3.00, 3.00, 32.00, 12.00, 20.00, 210, 950, 200, 3.00, 400, 0),
(103, 103, 520, 45.00, 35.00, 4.00, 6.00, 20.00, 6.00, 14.00, 120, 680, 250, 3.50, 2000, 35),
(104, 104, 580, 40.00, 45.00, 15.00, 6.00, 25.00, 8.00, 17.00, 95, 750, 80, 3.00, 800, 20),
(105, 105, 550, 20.00, 80.00, 5.00, 12.00, 18.00, 6.00, 12.00, 25, 950, 200, 4.50, 600, 15),
(106, 106, 420, 28.00, 50.00, 15.00, 5.00, 12.00, 2.50, 9.50, 65, 750, 60, 2.50, 800, 5),
(107, 107, 280, 5.00, 40.00, 10.00, 8.00, 12.00, 8.00, 4.00, 35, 650, 120, 1.50, 2000, 30),
(108, 108, 550, 40.00, 10.00, 2.00, 3.00, 40.00, 12.00, 28.00, 180, 1200, 120, 2.50, 800, 10),
(109, 109, 450, 18.00, 65.00, 6.00, 12.00, 15.00, 8.00, 7.00, 0, 680, 100, 6.00, 1500, 35),
(110, 110, 420, 30.00, 40.00, 4.00, 6.00, 16.00, 3.50, 12.50, 85, 680, 150, 2.00, 800, 25),
(111, 111, 580, 35.00, 50.00, 15.00, 5.00, 25.00, 8.00, 17.00, 95, 980, 100, 3.50, 400, 15),
(112, 112, 320, 12.00, 50.00, 8.00, 10.00, 6.00, 1.00, 5.00, 0, 850, 100, 3.50, 1500, 35),
(113, 113, 450, 28.00, 55.00, 3.00, 6.00, 15.00, 2.50, 12.50, 65, 780, 60, 2.50, 600, 15),
(114, 114, 580, 35.00, 60.00, 6.00, 4.00, 22.00, 6.00, 16.00, 120, 980, 80, 3.00, 1000, 15),
(115, 115, 450, 15.00, 60.00, 6.00, 10.00, 18.00, 2.50, 15.50, 0, 680, 100, 4.00, 400, 10),
(116, 116, 550, 35.00, 60.00, 6.00, 4.00, 20.00, 6.00, 14.00, 85, 950, 60, 4.50, 1000, 70),
(117, 117, 520, 20.00, 35.00, 3.00, 3.00, 35.00, 15.00, 20.00, 250, 750, 300, 3.00, 2000, 15),
(118, 118, 420, 35.00, 40.00, 2.00, 5.00, 12.00, 2.00, 10.00, 120, 450, 60, 2.50, 600, 20),
(119, 119, 520, 35.00, 60.00, 8.00, 6.00, 16.00, 4.00, 12.00, 120, 850, 180, 4.00, 800, 25),
(120, 120, 350, 15.00, 60.00, 10.00, 15.00, 6.00, 1.00, 5.00, 0, 850, 100, 5.00, 1500, 60),
(121, 121, 450, 35.00, 10.00, 6.00, 3.00, 30.00, 10.00, 20.00, 85, 680, 200, 4.00, 1200, 35),
(122, 122, 380, 20.00, 20.00, 10.00, 5.00, 25.00, 6.00, 19.00, 420, 650, 100, 3.50, 1500, 80),
(123, 123, 420, 35.00, 40.00, 4.00, 6.00, 12.00, 2.00, 10.00, 180, 680, 100, 3.00, 800, 35),
(124, 124, 650, 45.00, 65.00, 15.00, 6.00, 22.00, 6.00, 16.00, 120, 1200, 100, 4.00, 1000, 30),
(125, 125, 280, 10.00, 50.00, 8.00, 12.00, 6.00, 1.00, 5.00, 0, 450, 60, 3.00, 800, 80),
(126, 126, 320, 30.00, 20.00, 4.00, 3.00, 14.00, 3.00, 11.00, 85, 950, 40, 2.00, 800, 15),
(127, 127, 450, 15.00, 70.00, 6.00, 8.00, 15.00, 2.00, 13.00, 0, 450, 100, 3.50, 1200, 45),
(128, 128, 450, 28.00, 35.00, 6.00, 5.00, 22.00, 8.00, 14.00, 85, 680, 200, 3.50, 1500, 120),
(129, 129, 680, 35.00, 65.00, 4.00, 3.00, 30.00, 18.00, 12.00, 150, 950, 400, 2.50, 600, 5),
(130, 130, 250, 5.00, 30.00, 12.00, 6.00, 12.00, 8.00, 4.00, 35, 580, 120, 2.00, 2500, 25),
(131, 131, 620, 30.00, 55.00, 6.00, 4.00, 32.00, 12.00, 20.00, 95, 980, 80, 3.00, 1000, 15),
(132, 132, 280, 12.00, 45.00, 6.00, 12.00, 8.00, 1.00, 7.00, 0, 450, 100, 4.00, 600, 20),
(133, 133, 580, 40.00, 45.00, 15.00, 6.00, 25.00, 8.00, 17.00, 95, 750, 80, 3.00, 800, 20),
(134, 134, 320, 10.00, 60.00, 4.00, 12.00, 6.00, 1.00, 5.00, 0, 680, 60, 3.00, 1000, 15),
(135, 135, 580, 35.00, 55.00, 6.00, 4.00, 22.00, 8.00, 14.00, 95, 1100, 250, 3.00, 800, 15),
(136, 136, 520, 35.00, 50.00, 4.00, 4.00, 20.00, 4.00, 16.00, 85, 850, 150, 3.00, 800, 20),
(137, 137, 520, 18.00, 70.00, 10.00, 12.00, 18.00, 6.00, 12.00, 25, 950, 350, 4.50, 1800, 35),
(138, 138, 420, 35.00, 15.00, 6.00, 3.00, 25.00, 8.00, 17.00, 95, 550, 60, 4.00, 800, 80),
(139, 139, 450, 15.00, 35.00, 2.00, 4.00, 30.00, 12.00, 18.00, 35, 950, 300, 2.50, 1500, 15),
(140, 140, 420, 30.00, 55.00, 4.00, 6.00, 10.00, 1.50, 8.50, 180, 950, 100, 3.00, 1000, 80),
(141, 141, 450, 10.00, 75.00, 20.00, 8.00, 12.00, 1.50, 10.50, 0, 120, 100, 3.50, 1500, 25),
(142, 142, 480, 35.00, 60.00, 12.00, 6.00, 12.00, 2.50, 9.50, 85, 950, 80, 3.00, 1000, 80),
(143, 143, 580, 30.00, 40.00, 6.00, 4.00, 35.00, 12.00, 23.00, 85, 1800, 350, 4.00, 600, 15),
(144, 144, 450, 15.00, 65.00, 4.00, 10.00, 15.00, 4.00, 11.00, 25, 550, 200, 4.00, 1000, 35),
(145, 145, 450, 20.00, 40.00, 4.00, 3.00, 25.00, 12.00, 13.00, 65, 1200, 150, 2.50, 600, 10),
(146, 146, 380, 35.00, 10.00, 4.00, 3.00, 25.00, 8.00, 17.00, 95, 1200, 200, 2.00, 1500, 35),
(147, 147, 420, 20.00, 60.00, 12.00, 8.00, 12.00, 1.50, 10.50, 0, 950, 200, 4.00, 1500, 80),
(148, 148, 350, 30.00, 15.00, 4.00, 3.00, 20.00, 6.00, 14.00, 85, 950, 40, 3.50, 800, 15),
(149, 149, 320, 10.00, 25.00, 15.00, 5.00, 20.00, 5.00, 15.00, 25, 450, 200, 2.50, 1500, 60),
(150, 150, 380, 28.00, 30.00, 3.00, 5.00, 18.00, 3.00, 15.00, 210, 550, 80, 3.00, 800, 35),
(151, 151, 520, 35.00, 50.00, 2.00, 3.00, 20.00, 4.00, 16.00, 95, 850, 80, 2.50, 400, 15),
(152, 152, 450, 15.00, 65.00, 8.00, 12.00, 15.00, 2.00, 13.00, 0, 450, 120, 4.50, 1800, 80),
(153, 153, 520, 30.00, 40.00, 5.00, 7.00, 28.00, 10.00, 18.00, 85, 850, 250, 3.50, 800, 20),
(154, 154, 180, 10.00, 25.00, 3.00, 2.00, 5.00, 1.50, 3.50, 210, 950, 40, 1.50, 800, 15),
(155, 155, 480, 30.00, 30.00, 3.00, 3.00, 28.00, 5.00, 23.00, 180, 950, 150, 2.00, 1000, 20),
(156, 156, 650, 35.00, 60.00, 4.00, 3.00, 30.00, 18.00, 12.00, 120, 850, 350, 2.50, 600, 5),
(157, 157, 350, 12.00, 40.00, 6.00, 10.00, 18.00, 4.00, 14.00, 15, 750, 200, 3.50, 800, 35),
(158, 158, 420, 35.00, 15.00, 6.00, 3.00, 25.00, 8.00, 17.00, 95, 550, 60, 4.00, 800, 80),
(159, 159, 380, 20.00, 10.00, 4.00, 3.00, 28.00, 10.00, 18.00, 420, 550, 250, 2.50, 1800, 40),
(160, 160, 450, 22.00, 50.00, 6.00, 2.00, 18.00, 8.00, 10.00, 65, 950, 120, 2.00, 600, 5),
(161, 161, 480, 35.00, 55.00, 3.00, 6.00, 12.00, 2.50, 9.50, 85, 950, 80, 3.00, 800, 100),
(162, 162, 280, 12.00, 20.00, 2.00, 3.00, 18.00, 6.00, 12.00, 25, 550, 200, 2.00, 400, 5),
(163, 163, 420, 30.00, 40.00, 4.00, 6.00, 16.00, 3.50, 12.50, 85, 680, 150, 2.00, 800, 25),
(164, 164, 620, 35.00, 50.00, 8.00, 4.00, 32.00, 15.00, 17.00, 120, 950, 400, 4.50, 800, 25),
(165, 165, 450, 18.00, 65.00, 6.00, 12.00, 15.00, 8.00, 7.00, 0, 680, 100, 6.00, 1500, 35),
(166, 166, 380, 35.00, 15.00, 6.00, 3.00, 20.00, 3.50, 16.50, 85, 550, 60, 2.50, 800, 80),
(167, 167, 320, 15.00, 10.00, 6.00, 2.00, 25.00, 8.00, 17.00, 35, 450, 350, 1.00, 800, 25),
(168, 168, 520, 30.00, 60.00, 6.00, 3.00, 16.00, 2.50, 13.50, 180, 750, 80, 3.00, 800, 25),
(169, 169, 420, 30.00, 40.00, 8.00, 12.00, 16.00, 6.00, 10.00, 85, 850, 100, 5.00, 1200, 45),
(170, 170, 420, 18.00, 55.00, 6.00, 10.00, 15.00, 6.00, 9.00, 25, 580, 200, 4.00, 1500, 120);





