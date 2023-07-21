<?php 
include_once('dbconnect.php');

if(isset($_POST['product_id']) && isset($_POST['user_id'])) {
    $product_id = $_POST['product_id'];
    $user_id = $_POST['user_id'];
    $sql = "UPDATE `cart_table` SET `product_status`= 1 WHERE `product_id` = '$product_id' AND `user_id` = '$user_id'";
    $result = $connect->query($sql);
    if($result === TRUE) {
        $sql = "UPDATE `product_table` SET `product_quantity`= `product_quantity` - 1 WHERE `product_id` = '$product_id'";
        $result = $connect->query($sql);
        $response = array('status' => 'success', 'data' => null);
        sendJsonResponse($response);
    } else {
        $response = array('status' => 'failed', 'data' => null);
        sendJsonResponse($response);
    }
    //Now update the quantity
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>