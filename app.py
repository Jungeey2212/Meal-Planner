from flask import Flask, render_template
import mysql.connector

app = Flask(__name__)

def get_db_connection():
    return mysql.connector.connect(
        host='localhost',
        user='root',
        password='ISBS304',
        database='mealplans'
    )

@app.route('/')
def show_nutrition():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM mealnutrition WHERE NutritionID = %s", (1,))
    row = cursor.fetchone()
    cursor.close()
    conn.close()

    if not row:
        return "No record found for NutritionID = 1", 404

    return render_template('nutrition.html', nutrition=row)

if __name__ == '__main__':
    app.run(debug=True)
