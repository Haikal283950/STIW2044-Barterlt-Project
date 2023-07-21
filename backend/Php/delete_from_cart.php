<?php
include_once('dbconnect.php');
if (isset($_POST['product_id']) && isset($_POST['user_id'])) {
    $product_id = $_POST['product_id'];
    $user_id = $_POST['user_id'];
    $sql = "DELETE FROM `cart_table` WHERE `product_id` = '$product_id' AND `user_id` = '$user_id'";
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