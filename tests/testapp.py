from flask import Flask, render_template
import mysql.connector
from mysql.connector import Error

app = Flask(__name__)

# ─── Your MySQL credentials ─────────────────────────────────────────────
DB_CONFIG = {
    "host":     "localhost",
    "user":     "root",
    "password": "ISBS304",
    "database": "mealplans"
}

def fetch_filtered_meals():
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor(dictionary=True)
    query = """
      SELECT 
        MealName, 
        Calories_cal, 
        Protein_g, 
        Ingredients
      FROM meals
      WHERE Calories_cal > %s
        AND Protein_g   >= %s
    """
    cursor.execute(query, (400, 35))
    meals = cursor.fetchall()
    cursor.close()
    conn.close()
    return meals

@app.route('/filtered-meals')
def filtered_meals():
    meals = fetch_filtered_meals()
    return render_template('filtered_meals.html', meals=meals)

if __name__ == '__main__':
    app.run(debug=True)
