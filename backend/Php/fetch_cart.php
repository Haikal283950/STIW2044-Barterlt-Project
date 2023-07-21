<?php

function sendJsonResponse($sentArray){
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

include_once('dbconnect.php');
// Make a php array
$user_ids = array();
$items = array();
if (empty($_POST['user_id'])) {
    sendJsonResponse(array('status' => 'EMPTY POST', 'data' => null));
    die();
} else {
    $user_id = $_POST['user_id'];
    $sql = "SELECT * FROM `cart_table` WHERE user_id = '$user_id' AND product_status = 0";
    $result = $connect->query($sql);
    // Fill in the arrays with the data from the database
    while ($row = $result->fetch_assoc()) {
        $user_ids[] = $row['product_id'];
    }
    foreach ($user_ids as $user_id) {
        $newSQL = "SELECT * FROM `product_table` WHERE product_id = '$user_id'";
        $newResult = $connect->query($newSQL);
        if ($newResult) {
            while ($newRow = $newResult->fetch_assoc()) {
                $item = array();
                $item['product_id'] = $newRow['product_id']; // Use $newRow instead of $row
                $item['product_name'] = $newRow['product_name'];
                $item['product_description'] = $newRow['product_description'];
                $item['product_quantity'] = $newRow['product_quantity'];
                $item['product_price'] = $newRow['product_price'];
                $item['product_region'] = $newRow['product_region'];
                $item['product_city'] = $newRow['product_city'];
                $item['product_postcode'] = $newRow['product_postcode'];
                $item['product_country'] = $newRow['product_country'];
                $item['product_longitude'] = $newRow['product_longitude'];
                $item['product_latitude'] = $newRow['product_latitude'];
                $item['image1'] = $newRow['image1'];
                $item['image2'] = $newRow['image2'];
                $item['image3'] = $newRow['image3'];
                if ($newRow['image4'] != null) {
                    $item['image4'] = $newRow['image4'];
                } else {
                    $item['image4'] = '';
                }
                if ($newRow['image5'] != null) {
                    $item['image5'] = $newRow['image5'];
                } else {
                    $item['image5'] = '';
                }
                $item['user_id'] = $newRow['user_id'];
                $items[] = $item;
            }
        }
    }
    sendJsonResponse(array('status' => 'success', 'data' => $items));
    $connect->close();
}
?>
