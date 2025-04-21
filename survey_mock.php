<?php
// Database connection settings
$host = "localhost";
$user = "root";        // replace with your MySQL username
$pass = "ISBS304";            // replace with your MySQL password
$dbname = "survey_db";

// Connect to the database
$conn = new mysqli($host, $user, $pass, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Handle form submission
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $answer = $_POST["answer"];
    
    // Prepare and bind
    $stmt = $conn->prepare("INSERT INTO survey_answers (answer) VALUES (?)");
    $stmt->bind_param("s", $answer);
    
    if ($stmt->execute()) {
        echo "<p>Thank you for your response!</p>";
    } else {
        echo "<p>Error: " . $stmt->error . "</p>";
    }

    $stmt->close();
}

$conn->close();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Simple Survey</title>
</head>
<body>
    <h1>Survey</h1>
    <form method="post" action="">
        <label for="answer">What's your favorite programming language?</label><br><br>
        <input type="text" name="answer" id="answer" required>
        <br><br>
        <button type="submit">Submit</button>
    </form>
</body>
</html>
