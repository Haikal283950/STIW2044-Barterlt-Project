<?php 

include_once('dbconnect.php');

if (isset($_POST['product_id'])) {
    $sql = "SELECT `user_id` FROM `product_table` WHERE `product_id` = '" . $_POST['product_id'] . "'";
    
    $result = $connect->query($sql); 
    
    if ($result !== false && $result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $user_id = $row['user_id'];
        
        $userSql = "SELECT * FROM `barterlttable` WHERE `user_id` = '$user_id'";
        $userResult = $connect->query($userSql);
        
        $items = array(); // Initialize the $items array
        
        while ($userRow = $userResult->fetch_assoc()) {
            $user = array();
            $user['user_id'] = $userRow['user_id'];
            $user['username'] = $userRow['username'];
            $user['email'] = $userRow['email'];
            $user['password'] = $userRow['password'];
            $user['first_name'] = $userRow['firstname'];
            $user['last_name'] = $userRow['lastname'];
            $user['account_created'] = $userRow['account_created'];
            $items[] = $user;
        }
        
        sendJsonResponse($items);
    } else {
        sendJsonResponse(array()); 
    }
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}



?>