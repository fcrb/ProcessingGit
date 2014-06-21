<?php

// load php-login components
require_once("php-login.php");

$login = new Login();

if ($login->isUserLoggedIn() == true) {
    // the user is logged in. you can do whatever you want here.
    // for demonstration purposes, we simply show the "you are logged in" view.
   $userName = $_SESSION['user_name'];
   $practice = $_GET['practice'];
   $time = $_GET['time'];
   $score = $_GET['score'];
	
	$db = new mysqli("localhost","mrblogin", "hCE-6Tx-FvB-FX2", "mrbenson_login");
	$sql="INSERT INTO practice (user_name, practice, score, time)
			VALUES ('$userName', '$practice', $score, $time)";
 echo $sql;
 echo '\n';
     if($db->query($sql)) {
     	echo "score saved";
     } else {
     	echo "save failed";
     }
    $db->close();
}