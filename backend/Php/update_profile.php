<?php
include_once('dbconnect.php');
if(isset($_POST['first_name']) && isset($_POST['last_name']) && isset($_POST['email'])) {
    $first_name = $_POST['first_name'];
    $last_name = $_POST['last_name'];
    $email = $_POST['email'];
    $user_id = $_POST['user_id'];
    $password = $_POST['password'];
    $sql = "UPDATE `barterlttable` SET `firstname`='$first_name',`lastname`='$last_name',`email`='$email' , `password`='$password' WHERE `user_id` = '$user_id'";
    $result = $connect->query($sql);
    if($result === TRUE) {
        $response = array('status' => 'success', 'data' => null);
        sendJsonResponse($response);
    } else {
        $response = array('status' => 'failed', 'data' => null);
        sendJsonResponse($response);
    }
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>