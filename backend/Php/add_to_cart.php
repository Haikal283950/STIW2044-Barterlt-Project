<?php
    include_once("dbconnect.php");

    if(empty($_POST['product_id']) || empty($_POST['user_id'] || empty($_POST['seller_id']))) {
        $response = array('status' => 'failed', 'data' => null);
        sendJsonResponse($response);
        die();
    } else {
        $product_id = $_POST['product_id'];
        $user_id = $_POST['user_id'];
        $seller_id = $_POST['seller_id'];
        $sql = "INSERT INTO `cart_table` (`product_id`, `user_id`, `seller_id`, `product_status`) VALUES ('$product_id', '$user_id', '$seller_id', 0)";
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