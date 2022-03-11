<!DOCTYPE html>
<html>
    <body>
        <?php
        // string variable $name
        $name = "Gianna Galard";

        // integer variable $credits
        $credits = 22;

        // float variable $gpa
        $gpa = 3.6;


        // display welcome message
        echo "Welcome to my page, $name!<br>";

        // var dump variables and print them
        echo var_dump($name);
        echo "<br>";
        echo var_dump($credits);
        echo "<br>";
        echo var_dump($gpa);
        echo "<br>";

        // checking if credits is greater than or equal to 12
        if ($credits >= 12) {
            // display message
            echo "You are a full time student !<br>";
        }
        else {
            // display message
            echo "You are a part time student !<br>";
        }

        // print stats
        echo $_SERVER['PHP_SELF'];
        echo "<br>";
        echo $_SERVER['SERVER_NAME'];
        echo "<br>";
        echo $_SERVER['HTTP_HOST'];
        echo "<br>";
        echo $_SERVER['HTTP_REFERER'];
        echo "<br>";
        echo $_SERVER['HTTP_USER_AGENT'];
        echo "<br>";
        echo $_SERVER['SCRIPT_NAME'];
        ?>
    </body>
</html>