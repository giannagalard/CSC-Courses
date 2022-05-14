<?php
// variable declaration
include 'db_connection.php';
$conn = OpenCon();

$status="";   
$msg=""; 
$city=""; 
if(isset($_POST['submit'])){ // if the submit button is clicked
    $city=$_POST['city']; // get the city from the form
    $url="http://api.openweathermap.org/data/2.5/weather?q=$city&appid=49c0bad2c7458f1c76bec9654081a661"; // create the url to get the weather data
    $ch=curl_init(); // initialize the curl
    curl_setopt($ch,CURLOPT_URL,$url); // set the url
    curl_setopt($ch,CURLOPT_RETURNTRANSFER,true); // return the data instead of printing it to the screen
    $result=curl_exec($ch); // execute the curl
    curl_close($ch); // close the curl
    $result=json_decode($result,true); // decode the json data
    $temp=$result['main']['temp']-273.15;
    $img=$result['weather'][0]['icon'];
    $query="INSERT INTO search_history (country_name, temperature, img) VALUES ('$city', '$temp', '$img')"; // insert the city and temperature into the database
    $db_result=mysqli_query($conn, $query); // execute the query
    $sql = "SELECT * FROM search_history order by search_id desc limit 10";
    $select_all = mysqli_query($conn, $sql);
    if($result['cod']==200){ // if the city is valid
        $status="yes"; // set the status to yes
    }else{ // if the city is not valid
        $msg=$result['message']; // display error
    }
}
CloseCon($conn);
?>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Weather App</title>
    <style> 
        /* import font and weather icons */
        @import url(https://fonts.googleapis.com/css?family=Roboto:300); 
        @import url(https://cdnjs.cloudflare.com/ajax/libs/weather-icons/2.0.9/css/weather-icons.min.css);

        body {
        background: #AEE0F5;
        font-family: 'Roboto', sans-serif;
        }

        .searchContainer {
        display: flex;
        justify-content: center;
        align-items: center;
        width: 100%;
        }

        .searchbar {
        width: 100%;
        position: relative;
        display: flex;
        justify-content: center;
        align-items: center;
        }

        .searchCity {
        width: 100%;
        border: 3px solid #6F6F6F;
        border-right: none;
        padding: 5px;
        height: 40px;
        border-radius: 5px 0 0 5px;
        outline: none;
        color: #6F6F6F;
        }

        .searchCity:focus {
        color: #6F6F6F;
        }

        .searchButton {
        justify-content: center;
        width: 80px;
        height:40px;
        border: 3px solid #6F6F6F;
        background: #FFB300;
        text-align: center;
        color: #ffff;
        border-radius: 0 5px 5px 0;
        cursor: pointer;
        }

      .city {
        font-style: bold;
        font-size: 30px;
        display:flex;
        justify-content: center;
        color: #FFB300;
      }

      .weatherIcon {
        display: flex;
        justify-content: center;
      }

      .weatherDesc {
        display: flex;
        justify-content: center;
        font-size: 20px;
      }

      .weatherTemp {
        display: flex;
        justify-content: center;
        font-size: 30px;
        font-style: bold;
      }

      .innerWidget {
        text-align: center;
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
      }

      .weatherWidget {
        justify-content: space-between;
        padding-left: 20px;
        padding-right: 10px;
        margin-top: 20px;
        width: 30%;
        display: flex;
        background: #fff;
        border-radius: 15px;
      }
      
      .searchText {
        font-size: 20px;
        font-style: bold;
        justify-content: center;
        margin-top: 20px;
        width: 100%;
        border-radius: 15px;
        display: flex;
        background: #fff;
      }

      .weatherContainer {
        padding: 5px;
        border-radius: 15px;
        width: 30%;
        background: #fff;
        display: flex;
        justify-content: center;
        flex-direction: column;
      }

      .cardContainer {
        display: flex;
        justify-content: center;
        width: 100%;
      }
      
    </style>
</head>
<body>
    <div class="searchContainer">
        <div class="searchBar">
         <form style="width:30%; display:flex;" method="POST">
            <input type="text" class="searchCity" placeholder="Enter city name" name="city" value="<?php echo $city?>"/>
            <input type="submit" value="Submit" class="searchButton" name="submit"/>
            <?php echo $msg?>
         </form>
      </div>
    </div>

    <?php if($status=="yes"){?>
    <div class = "cardContainer">
      <div class="weatherContainer">
          <div class="weatherData">
              <div class="city">
                  <?php echo $result['name'];?>
              </div>
          </div>
        <div class="weatherIcon">
              <!-- get the weather icon -->
              <img src="http://openweathermap.org/img/wn/<?php echo $result['weather'][0]['icon']?>@4x.png"/> 
          </div>
        <div class="weatherDesc">
                  <?php echo $result['weather'][0]['description'];?>
              </div>
        <div class = "weatherTemp"
              <div class="temp">
                  <?php echo $result['main']['temp']-273.15;?>°C
              </div>
          </div>
      </div>
      <div class="searchText">
        <p>Search History</p>
      </div>
      <?php
      if($select_all) {
        while($row = mysqli_fetch_array($select_all)) {
      ?>
      <div class = "cardContainer">
        <div class="weatherWidget">
          <div class="innerWidget">
            <h3><?php echo $row['country_name'];?></h3>
            <h3><?php echo $row['temperature'];?>°C</h3>
          </div>
          <img src="http://openweathermap.org/img/wn/<?php echo $row['img']?>@4x.png"/>
        </div>
      </div>
      <?php
        }
      } 
      ?>
    </div>
    <?php }else{?>
    <div class="error">
        <?php echo $msg;?>
    </div>
    <?php }?>
</body>
</html>