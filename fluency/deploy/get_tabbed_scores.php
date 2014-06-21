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
	
	$mysqli = new mysqli("localhost","mrblogin", "hCE-6Tx-FvB-FX2", "mrbenson_login");
	/* check connection */
	if (mysqli_connect_errno()) {
    	printf("Connect failed: %s\n", mysqli_connect_error());
    	exit();
	}
	$query="SELECT practice, score, time, date(time_stamp), time(time_stamp)
			FROM practice 
			WHERE user_name = '$userName' 
			ORDER BY practice, time_stamp";
	if ($stmt = $mysqli->prepare($query)) {
		$stmt->execute();
		$stmt->bind_result($practice, $score, $duration, $date, $time);
		printf("practice\tscore\tduration\tdate\ttime\n");
		while($stmt->fetch()) {
        	printf("%s\t%s\t%s\t%s\t%s\n"
        		, $practice, $score, $duration, $date, $time);
    	}
	    $stmt->close();
	}

    $mysqli->close();
}