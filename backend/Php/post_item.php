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

if ($image4 === null) {
    $image4 = '';
}
if ($image5 === null) {
    $image5 = '';
}

$sql = "INSERT INTO `product_table` (`product_name`, `product_description`, `product_quantity`, `product_price`, `product_region`, `product_city`, `product_postcode`, `product_country`, `product_longitude`, `product_latitude`, `user_id`)
        VALUES ('$product_name', '$product_description', '$product_quantity', '$product_price', '$product_region', '$product_city', '$product_postcode', '$product_country', '$product_longitude', '$product_latitude', '$user_id')";

if ($connect->query($sql) === TRUE) {
    $filename = mysqli_insert_id($connect); 
    $response = array('status' => 'success', 'data' => null);
    
    foreach ($images as $key => $image) {
        if (!empty($image)) {
            $decoded_string = base64_decode($image);
            $image_path = '../assets/images/' . $filename . '_image' . ($key + 1) . '.png';
            
            if (file_put_contents($image_path, $decoded_string)) {
                $image_path = str_replace('..', '', $image_path);
                $image = $image_path;
                $sqlSetPath = "UPDATE `product_table` SET `image" . ($key + 1) . "` = '$image' WHERE `product_id` = '$filename'";
                $connect->query($sqlSetPath);
            }
        }
    }
    
    $response = array('status' => 'success', 'data' => null);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}


$connect->close(); // Use $connect instead of $conn
?>