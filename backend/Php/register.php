<?php 
if(!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$first_name = $_POST['first_name'];
$last_name = $_POST['last_name'];
$email = $_POST['email'];
$password = $_POST['password'];
$username = $_POST['username'];

$sqlinsert = "INSERT INTO `barterlttable`(`username`, `email`, `password`, `firstname`, `lastname`) VALUES ('$username','$email','$password','$first_name','$last_name');";

if ($connect->query($sqlinsert) === TRUE) {
    # code...
    $response = array('status' => 'success', 'data' => null);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>