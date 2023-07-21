-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 21, 2023 at 02:31 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `barterltdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `barterlttable`
--

CREATE TABLE `barterlttable` (
  `user_id` int(11) NOT NULL,
  `username` varchar(25) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(25) NOT NULL,
  `firstname` varchar(25) NOT NULL,
  `lastname` varchar(25) NOT NULL,
  `account_created` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `barterlttable`
--

INSERT INTO `barterlttable` (`user_id`, `username`, `email`, `password`, `firstname`, `lastname`, `account_created`) VALUES
(1, 'asep123', 'asep@gmail.com', 'AsepAsyique123!', 'Asep', 'Suep', '2023-05-21'),
(2, 'imadlovesfootball', 'if123@gmail.com', 'BarcaYeah1!', 'Imad', 'Hamid', '2023-05-21'),
(3, 'IkhsanScooter22', 'akhsan@gmail.com', 'Ikhsan21!', 'Ikhsan', 'Akhsan', '2023-05-21'),
(5, 'Haikal21', 'haikal21@gmail.com', 'Tangerang123!', 'Haikal Abas', 'Muhammad', '2023-05-21');

-- --------------------------------------------------------

--
-- Table structure for table `cart_table`
--

CREATE TABLE `cart_table` (
  `cart_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `product_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart_table`
--

INSERT INTO `cart_table` (`cart_id`, `user_id`, `product_id`, `seller_id`, `product_status`) VALUES
(10, 3, 4, 1, 0),
(11, 5, 2, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `product_table`
--

CREATE TABLE `product_table` (
  `product_id` int(10) NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `product_description` varchar(200) NOT NULL,
  `product_quantity` varchar(3) NOT NULL,
  `product_price` varchar(4) NOT NULL,
  `product_region` varchar(50) NOT NULL,
  `product_city` varchar(50) NOT NULL,
  `product_postcode` int(50) NOT NULL,
  `product_country` varchar(50) NOT NULL,
  `product_longitude` int(50) NOT NULL,
  `product_latitude` int(50) NOT NULL,
  `image1` varchar(250) NOT NULL,
  `image2` varchar(250) NOT NULL,
  `image3` varchar(250) NOT NULL,
  `image4` varchar(250) DEFAULT NULL,
  `image5` varchar(250) DEFAULT NULL,
  `user_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_table`
--

INSERT INTO `product_table` (`product_id`, `product_name`, `product_description`, `product_quantity`, `product_price`, `product_region`, `product_city`, `product_postcode`, `product_country`, `product_longitude`, `product_latitude`, `image1`, `image2`, `image3`, `image4`, `image5`, `user_id`) VALUES
(2, 'test', 'fe', '2', '55', 'Mississippi', 'Hattiesburg', 39401, 'United States', -89, 31, '/assets/images/2_image1.png', '/assets/images/2_image2.png', '/assets/images/2_image3.png', '/assets/images/2_image4.png', NULL, 1),
(3, 'Bookshelf', 'A sweet old bookshelf!', '1', '55', 'Mississippi', 'Hattiesburg', 39401, 'United States', -89, 31, '/assets/images/3_image1.png', '/assets/images/3_image2.png', '/assets/images/3_image3.png', NULL, NULL, 1),
(4, 'Television HD', 'Cool television with HDTV!', '15', '150', 'Mississippi', 'Hattiesburg', 39401, 'United States', -89, 31, '/assets/images/4_image1.png', '/assets/images/4_image2.png', '/assets/images/4_image3.png', NULL, NULL, 1),
(5, 'Couch', 'Couch, very cozy', '0', '500', 'Mississippi', 'Hattiesburg', 39401, 'United States', -89, 31, '/assets/images/5_image1.png', '/assets/images/5_image2.png', '/assets/images/5_image3.png', NULL, NULL, 1),
(6, 'Plastic dog', 'Plastic dog for sale!', '5', '25', 'Mississippi', 'Hattiesburg', 39401, 'United States', -89, 31, '/assets/images/6_image1.png', '/assets/images/6_image2.png', '/assets/images/6_image3.png', NULL, NULL, 1),
(7, 'Stove', 'A working stove!', '1', '2500', 'Mississippi', 'Hattiesburg', 39401, 'United States', -89, 31, '/assets/images/7_image1.png', '/assets/images/7_image2.png', '/assets/images/7_image3.png', NULL, NULL, 3),
(8, 'Rug', 'Brown leathery rug!', '4', '55', 'New Mexico', 'Albuquerque', 87121, 'United States', -107, 35, '/assets/images/8_image1.png', '/assets/images/8_image2.png', '/assets/images/8_image3.png', NULL, NULL, 3),
(9, 'Dining set', 'Dining set', '1', '1500', 'New Mexico', 'Albuquerque', 87121, 'United States', -107, 35, '/assets/images/9_image1.png', '/assets/images/9_image2.png', '/assets/images/9_image3.png', NULL, NULL, 3),
(11, 'Vintage Mug', 'Vintage Mug', '5', '15', 'New Mexico', 'Albuquerque', 87121, 'United States', -107, 35, '/assets/images/11_image1.png', '/assets/images/11_image2.png', '/assets/images/11_image3.png', NULL, NULL, 1),
(12, 'Vintage Mug', 'Vintage Mug', '25', '50', 'New Mexico', 'Albuquerque', 87121, 'United States', -107, 35, '/assets/images/12_image1.png', '/assets/images/12_image2.png', '/assets/images/12_image3.png', NULL, NULL, 5);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `barterlttable`
--
ALTER TABLE `barterlttable`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `cart_table`
--
ALTER TABLE `cart_table`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `seller_id` (`seller_id`);

--
-- Indexes for table `product_table`
--
ALTER TABLE `product_table`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `userProd_foreign` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `barterlttable`
--
ALTER TABLE `barterlttable`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `cart_table`
--
ALTER TABLE `cart_table`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `product_table`
--
ALTER TABLE `product_table`
  MODIFY `product_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart_table`
--
ALTER TABLE `cart_table`
  ADD CONSTRAINT `product_id` FOREIGN KEY (`product_id`) REFERENCES `product_table` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `seller_id` FOREIGN KEY (`seller_id`) REFERENCES `barterlttable` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `barterlttable` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_table`
--
ALTER TABLE `product_table`
  ADD CONSTRAINT `userProd_foreign` FOREIGN KEY (`user_id`) REFERENCES `barterlttable` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
