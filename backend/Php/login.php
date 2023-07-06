<?php 
if(!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$username = $_POST['username'];
$password = $_POST['password'];
// $username = 'haikaaal21';
// $password = 'Tangerang123!';
$sqllogin = "SELECT * FROM barterlttable WHERE username = '$username' AND password = '$password'";

$result = $connect->query($sqllogin);
if($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $userlist = array();
        $userlist['user_id'] = $row['user_id'];
        $userlist['username'] = $row['username'];
        $userlist['username'] = $row['email'];
        $userlist['password'] = $row['password'];
        $userlist['first_name'] = $row['firstname'];
        $userlist['last_name'] = $row['lastname'];
        $userlist['account_created'] = $row['account_created'];
        $response = array('status' => 'success', 'data' => $userlist);
        sendJsonResponse($response);
    }
} else {
    $response = array('status' => 'failed', 'data' => null);
}
$connect->close();

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>