<?php


if(!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

function sendJsonResponse($response) {
    header('Content-Type: application/json');
    echo json_encode($response);
}

require_once 'dbconnect.php';

$product_name = $_POST['product_name'];
$product_description = $_POST['product_description'];
$product_quantity = $_POST['product_quantity'];
$product_price = $_POST['product_price'];
$product_region = $_POST['product_region'];
$product_city = $_POST['product_city'];
$product_postcode = $_POST['product_postcode'];
$product_country = $_POST['product_country'];
$product_longitude = $_POST['product_longitude'];
$product_latitude = $_POST['product_latitude'];
$image1 = $_POST['image1'];
$image2 = $_POST['image2'];
$image3 = $_POST['image3'];
$image4 = $_POST['image4'];
$image5 = $_POST['image5'];
$images = array($image1, $image2, $image3, $image4, $image5);
$user_id = $_POST['user_id'];

echo 'Received POST data'; //DEBUG ONLY

if ($image4 === null) {
    $image4 = '';
}
if ($image5 === null) {
    $image5 = '';
}

$sql = "INSERT INTO `product_table` (`product_name`, `product_description`, `product_quantity`, `product_price`, `>
        VALUES ('$product_name', '$product_description', '$product_quantity', '$product_price', '$product_region',>";

echo 'Image' . $image1; //DEBUG PURPOSES ONLY
echo 'Executing SQL query'; //DEBUG PURPOSES ONLY

if ($connect->query($sql) === TRUE) {
  echo 'connected';
}
?>