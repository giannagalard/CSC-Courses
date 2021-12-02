<!DOCTYPE html>

<?php
// check if the form has been submitted
if($_SERVER["REQUEST_METHOD"] == "POST"){ 
     $fname = $_POST['firstname']; 
     $lname = $_POST['lastname']; 
     $emplid = $_POST['emplid']; 
     $courses = $_POST['courses'];
     // connect to the database
     $db = pg_connect("host=localhost port=5432 dbname=postgres user=postgres password=root"); 
     // insert the data into the database 
     $query = "INSERT INTO enrollment (firstname, lastname, emplid, courses) VALUES ('$fname', '$lname', '$emplid', '$courses')"; 
     // execute the query
     $result = pg_query($db, $query); 

    //  echo "Thank you for enrolling to ". $courses . ", see you next semester!"; 
} ?>

<!-- make output look somewhat pretty -->
<html>
<head>
    <meta name = "viewport" content = "width = device-width, initial-scale = 1.0">
    <link rel = "stylesheet" type = "text/css" href = "style.css">
    <title>Class Registration Form</title>
</head>
<body>
    <div class = "courseoutput">
        <?php 
        // output course registered
        if($_SERVER["REQUEST_METHOD"] == "POST"){ 
            echo "Thank you for enrolling to ". $courses . ", see you next semester!"; 
        }
        ?>
    </div>
</body>
</html>