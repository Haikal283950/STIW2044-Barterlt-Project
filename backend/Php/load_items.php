<?php
header('Content-Type: application/json');

if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");
$results_per_page = 6;
$pageno = $_POST['pageno'];
$page_first_result = ($pageno - 1) * $results_per_page;

if (isset($_POST['user_id'])) {
    $user_id = $_POST['user_id'];
    if(isset($_POST['boolean_for_user'])) {
        $sqlloaditems = "SELECT * FROM `product_table` WHERE user_id <> '$user_id'";
    } else {
        $sqlloaditems = "SELECT * FROM `product_table` WHERE user_id = '$user_id'";
    }
} else if (isset($_POST['searched_item'])) {
    $searched_item = $_POST['searched_item'];
    $sqlloaditems = "SELECT * FROM `product_table` WHERE product_name LIKE '%$searched_item%'";
}

$result = $connect->query($sqlloaditems);
$number_of_results = $result->num_rows;
$number_of_pages = ceil($number_of_results / $results_per_page);
$sqlloaditems = $sqlloaditems . " LIMIT " . $page_first_result . ',' . $results_per_page;

$result = $connect->query($sqlloaditems);
if ($result->num_rows > 0) {
    $items = array();
    while ($row = $result->fetch_assoc()) {
        $item = array();
        $item['product_id'] = $row['product_id'];
        $item['product_name'] = $row['product_name'];
        $item['product_description'] = $row['product_description'];
        $item['product_quantity'] = $row['product_quantity'];
        $item['product_price'] = $row['product_price'];
        $item['product_region'] = $row['product_region'];
        $item['product_city'] = $row['product_city'];
        $item['product_postcode'] = $row['product_postcode'];
        $item['product_country'] = $row['product_country'];
        $item['product_longitude'] = $row['product_longitude'];
        $item['product_latitude'] = $row['product_latitude'];
        $item['image1'] = $row['image1'];
        $item['image2'] = $row['image2'];
        $item['image3'] = $row['image3'];
        if($row['image4'] != null) {
            $item['image4'] = $row['image4'];
        } else {
            $item['image4'] = '';
        }
        if($row['image5'] != null) {
            $item['image5'] = $row['image5'];
        } else {
            $item['image5'] = '';
        }
        $item['user_id'] = $row['user_id'];

        $items[] = $item;
    }
    $response = array('status' => 'success','data' => $items, 'number_of_pages' => $number_of_pages, 'pageno' => $pageno);
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
