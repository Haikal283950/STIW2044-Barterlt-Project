<?php 
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "barterltdb";

$connect = new mysqli($servername, $username, $password, $dbname);
if ($connect->connect_error){
    die("Connection failed: " . $connect->connect_error);
} 
?> 