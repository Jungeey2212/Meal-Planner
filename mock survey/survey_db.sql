-- Create the table
CREATE TABLE recipes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  image_url TEXT,
  calories INT,
  protein DECIMAL(5,2),
  carbs DECIMAL(5,2),
  fat DECIMAL(5,2),
  ingredients TEXT,homenoeneksajdasjd
  instructions TEXT
);

-- Insert 2 sample recipes
INSERT INTO recipes (name, image_url, calories, protein, carbs, fat, ingredients, instructions) VALUES
('Grilled Chicken Salad', 'https://via.placeholder.com/200', 350, 30.00, 15.00, 18.00, 
 'Chicken breast, Lettuce, Tomato, Olive oil, Lemon juice', 
 'Grill the chicken, slice veggies, toss with dressing.'),

('Tofu Curry', 'https://via.placeholder.com/200', 400, 20.00, 30.00, 22.00, 
 'Tofu, Coconut milk, Curry paste, Spinach, Rice', 
 'Cook tofu, add curry paste, stir in coconut milk and simmer.');
