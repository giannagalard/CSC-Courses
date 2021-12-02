
<!-- ___ _              ___              
    / __| |__ _ ______ | __|__ _ _ _ __  
   | (__| / _` (_-<_-< | _/ _ \ '_| '  \ 
   \___|_\__,_/__/__/ |_|\___/_| |_|_|_| 

    Author: Gianna Galard  --> 
                                      
<!DOCTYPE html>

<?php
    include 'connect.php';
    session_start();
?>

<html>
<head>
    <meta name = "viewport" content = "width = device-width, initial-scale = 1.0">
    <link rel = "stylesheet" type = "text/css" href = "style.css">
    <title>Class Registration Form</title>
    <style>
    <?php 
    include 'style.css'; 
    ?>
    </style>
</head>
<body>
    <div class = "container">
            <h2>Class Registration Form</h2>
            <form action = "connect.php" method = "post"> 
            <div class="row100">
                <div class="col">
                    <div class="inputBox"> 
                        <input type="text" name="firstname" required="required">
                        <span class="text">First Name</span>
                        <span class="line"></span>
                    </div>
                </div>
            </div>
            <div class="row100">
                <div class="col">
                    <div class="inputBox">
                        <input type="text" name="lastname" required="required">
                        <span class="text">Last Name</span>
                        <span class="line"></span>
                    </div>
                </div>
                <div class="col">
                    <div class="inputBox">
                        <input type="text" name="emplid" required="required">
                        <span class="text">EMPLID</span>
                        <span class="line"></span>
                    </div>
                </div>
            </div>
            <div class="row100">
                <div class="col">
                    <div class="inputBox textarea">
                        <textarea name="courses"></textarea>
                        <span class="text">Course Names in comma seperated list (ex: CSC315, CSC424) </span>
                        <span class="line"></span>
                    </div>
                </div>
            </div>
            <div class="row100">
                <div class="col">
                    <input type="submit" value="Enroll">
                </div>
            </div>

    </div>
</form>
</body>
</html>