from flask import Flask, render_template, request
import mysql.connector

app = Flask(__name__)

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "ISBS304",
    "database": "mealplans"
}

def filter_meals(age, gender, weight, height, target):
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor(dictionary=True)

    bmi = float(weizght) / ((float(height)/100)**2)

    query = "SELECT * FROM meals WHERE 1=1"
    filters = []

    # Filter based on fitness target
    if target == "Lose weight":
        filters.append("Calories_cal <= 500 AND Protein_g >= 25")
    elif target in ["Gain muscle", "Bulking"]:
        filters.append("Protein_g >= 40")
    elif target == "Improve stamina":
        filters.append("Carbs_g >= 30")

    # Filter based on age
    if age == "12-18":
        filters.append("Calories_cal >= 500 AND Protein_g >= 25")
    elif age == "33-64":
        filters.append("Calories_cal <= 600 AND Fibers_g >= 5")
    elif age == "65+":
        filters.append("Calcium_mg >= 200 AND Protein_g >= 20")

    # Filter based on gender
    if gender == "Female":
        filters.append("Iron_mg >= 2")

    # Filter based on BMI
    if bmi < 18.5:
        filters.append("Calories_cal >= 600")
    elif 25 <= bmi < 30:
        filters.append("Calories_cal <= 600 AND Fat_g <= 20")
    elif bmi >= 30:
        filters.append("Calories_cal <= 500 AND Fat_g <= 15 AND Fibers_g >= 5")

    if filters:
        query += " AND " + " AND ".join(filters)

    cursor.execute(query)
    meals = cursor.fetchall()
    cursor.close()
    conn.close()
    return meals

@app.route('/submit-target')
def submit_target():
    age = request.args.get('ageRange')
    gender = request.args.get('gender')
    weight = request.args.get('weight')
    height = request.args.get('height')
    target = request.args.get('fitnessTarget')

    meals = filter_meals(age, gender, weight, height, target)
    return render_template('filtered_meals.html', meals=meals)

@app.route('/')
def show_form():
    return render_template('form1test.html')

if __name__ == '__main__':
    app.run(debug=True)