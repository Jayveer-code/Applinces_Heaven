-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 16, 2026 at 07:44 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ah`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add categories', 7, 'add_categories'),
(26, 'Can change categories', 7, 'change_categories'),
(27, 'Can delete categories', 7, 'delete_categories'),
(28, 'Can view categories', 7, 'view_categories'),
(29, 'Can add filter_ price', 8, 'add_filter_price'),
(30, 'Can change filter_ price', 8, 'change_filter_price'),
(31, 'Can delete filter_ price', 8, 'delete_filter_price'),
(32, 'Can view filter_ price', 8, 'view_filter_price'),
(33, 'Can add sub categories', 9, 'add_subcategories'),
(34, 'Can change sub categories', 9, 'change_subcategories'),
(35, 'Can delete sub categories', 9, 'delete_subcategories'),
(36, 'Can view sub categories', 9, 'view_subcategories'),
(37, 'Can add product', 10, 'add_product'),
(38, 'Can change product', 10, 'change_product'),
(39, 'Can delete product', 10, 'delete_product'),
(40, 'Can view product', 10, 'view_product'),
(41, 'Can add images', 11, 'add_images'),
(42, 'Can change images', 11, 'change_images'),
(43, 'Can delete images', 11, 'delete_images'),
(44, 'Can view images', 11, 'view_images'),
(45, 'Can add profile', 12, 'add_profile'),
(46, 'Can change profile', 12, 'change_profile'),
(47, 'Can delete profile', 12, 'delete_profile'),
(48, 'Can view profile', 12, 'view_profile'),
(49, 'Can add contact_us', 13, 'add_contact_us'),
(50, 'Can change contact_us', 13, 'change_contact_us'),
(51, 'Can delete contact_us', 13, 'delete_contact_us'),
(52, 'Can view contact_us', 13, 'view_contact_us'),
(53, 'Can add order', 14, 'add_order'),
(54, 'Can change order', 14, 'change_order'),
(55, 'Can delete order', 14, 'delete_order'),
(56, 'Can view order', 14, 'view_order'),
(57, 'Can add orderitem', 15, 'add_orderitem'),
(58, 'Can change orderitem', 15, 'change_orderitem'),
(59, 'Can delete orderitem', 15, 'delete_orderitem'),
(60, 'Can view orderitem', 15, 'view_orderitem'),
(61, 'Can add email otp', 16, 'add_emailotp'),
(62, 'Can change email otp', 16, 'change_emailotp'),
(63, 'Can delete email otp', 16, 'delete_emailotp'),
(64, 'Can view email otp', 16, 'view_emailotp'),
(65, 'Can add review', 17, 'add_review'),
(66, 'Can change review', 17, 'change_review'),
(67, 'Can delete review', 17, 'delete_review'),
(68, 'Can view review', 17, 'view_review'),
(69, 'Can add wishlist', 18, 'add_wishlist'),
(70, 'Can change wishlist', 18, 'change_wishlist'),
(71, 'Can delete wishlist', 18, 'delete_wishlist'),
(72, 'Can view wishlist', 18, 'view_wishlist'),
(73, 'Can add order status history', 19, 'add_orderstatushistory'),
(74, 'Can change order status history', 19, 'change_orderstatushistory'),
(75, 'Can delete order status history', 19, 'delete_orderstatushistory'),
(76, 'Can view order status history', 19, 'view_orderstatushistory'),
(77, 'Can add coupon', 20, 'add_coupon'),
(78, 'Can change coupon', 20, 'change_coupon'),
(79, 'Can delete coupon', 20, 'delete_coupon'),
(80, 'Can view coupon', 20, 'view_coupon'),
(81, 'Can add user activity', 21, 'add_useractivity'),
(82, 'Can change user activity', 21, 'change_useractivity'),
(83, 'Can delete user activity', 21, 'delete_useractivity'),
(84, 'Can view user activity', 21, 'view_useractivity');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$720000$Ueb3SzjF9aQYuGaRZBVSJM$+XQRXi2EfdWVTFg7vJrBvM47XxNMn70ZATfgCQSnp9c=', '2026-04-18 06:35:42.404430', 1, 'admin', '', '', '', 1, 1, '2024-03-18 15:03:55.408898'),
(2, 'pbkdf2_sha256$720000$XyDcSspkwifHRY5DgCnqDG$KjL4M7QRj4tIFQ+7B8rjLKE78vE2WC6lR9aG9N6T8cM=', '2026-04-17 17:30:12.810793', 0, 'sujal', 'sujal', 'sharma', 'sujal78sharma@gmail.com', 0, 1, '2024-03-18 15:04:45.966593'),
(3, 'pbkdf2_sha256$720000$yJ9V5Tin87bCndN9AKRC9A$0b//cuRe7ur6HMNH+22xDA6YjGdRAmGgLJs7rtaHI9w=', '2025-12-25 03:59:01.808467', 0, 'sujit', 'sujit', 'patel', 'sujit@gmail.com', 0, 1, '2024-03-19 04:45:39.863572'),
(4, 'pbkdf2_sha256$720000$z9FCtkHgwyzLK5tP9345f5$BV4RQyW/O9UOzp0J2GDQhamoBpNPncN6MT7clZuwCpU=', '2024-04-17 04:37:35.911746', 0, 'jayveer', 'jayveer', 'chavda', 'jayu@gmail.com', 0, 1, '2024-03-19 04:47:11.441864'),
(6, 'pbkdf2_sha256$720000$fVLFoqiuZLNj8o7Xb4k8eZ$E1jQFiODBwhhA0fVf/ItGQ51H+4Ldu5kda8ljAvPA8U=', NULL, 0, 'sujit1', 'sujit', 'patel', 'sujal78sharma@gmail.com', 0, 1, '2024-04-27 04:40:58.301671'),
(7, 'pbkdf2_sha256$720000$QMk8allT7fax0dGxztAJej$iKgtPeUROyp7yAhDTr3A69KV6s0biHNYQIZUD8JFyVU=', '2024-04-27 05:22:37.489948', 0, 'harsh', 'harsh', 'patel', 'sujal78sharma@gmail.com', 0, 1, '2024-04-27 05:22:16.083067');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2024-03-18 15:06:14.252683', '1', 'Kitchen Appliances', 1, '[{\"added\": {}}]', 7, 1),
(2, '2024-03-18 15:06:21.470115', '2', 'Home Comfort Appliances', 1, '[{\"added\": {}}]', 7, 1),
(3, '2024-03-18 15:06:28.002283', '3', 'Laundry Appliances', 1, '[{\"added\": {}}]', 7, 1),
(4, '2024-03-18 15:06:38.014098', '4', 'Entertainment Appliances', 1, '[{\"added\": {}}]', 7, 1),
(5, '2024-03-18 15:06:45.062023', '5', 'Watches', 1, '[{\"added\": {}}]', 7, 1),
(6, '2024-03-18 15:06:54.351519', '6', 'Mobiles & Accessories', 1, '[{\"added\": {}}]', 7, 1),
(7, '2024-03-18 15:07:12.645264', '1', 'Refrigerators', 1, '[{\"added\": {}}]', 9, 1),
(8, '2024-03-18 15:07:28.490754', '2', 'Microwave Ovens', 1, '[{\"added\": {}}]', 9, 1),
(9, '2024-03-18 15:07:34.003748', '3', 'Coffee Makers', 1, '[{\"added\": {}}]', 9, 1),
(10, '2024-03-18 15:07:40.847974', '4', 'Air Conditioners', 1, '[{\"added\": {}}]', 9, 1),
(11, '2024-03-18 15:07:52.124699', '5', 'Fans', 1, '[{\"added\": {}}]', 9, 1),
(12, '2024-03-18 15:08:04.312657', '6', 'Air Purifiers', 1, '[{\"added\": {}}]', 9, 1),
(13, '2024-03-18 15:08:11.438132', '7', 'Laundry Appliances', 1, '[{\"added\": {}}]', 9, 1),
(14, '2024-03-18 15:08:17.691491', '8', 'Washing Machines', 1, '[{\"added\": {}}]', 9, 1),
(15, '2024-03-18 15:08:23.601219', '9', 'Irons', 1, '[{\"added\": {}}]', 9, 1),
(16, '2024-03-18 15:08:29.959330', '10', 'Televisions', 1, '[{\"added\": {}}]', 9, 1),
(17, '2024-03-18 15:08:36.873307', '11', 'Home Theater Systems', 1, '[{\"added\": {}}]', 9, 1),
(18, '2024-03-18 15:08:43.940979', '12', 'Gaming Consoles', 1, '[{\"added\": {}}]', 9, 1),
(19, '2024-03-18 15:08:50.194757', '13', 'Smartwatches', 1, '[{\"added\": {}}]', 9, 1),
(20, '2024-03-18 15:08:55.374973', '14', 'Fitness Trackers', 1, '[{\"added\": {}}]', 9, 1),
(21, '2024-03-18 15:09:01.928249', '15', 'Traditional Watches', 1, '[{\"added\": {}}]', 9, 1),
(22, '2024-03-18 15:09:09.896625', '16', 'Mobiles', 1, '[{\"added\": {}}]', 9, 1),
(23, '2024-03-18 15:09:16.033138', '17', 'Headphones/Earphones', 1, '[{\"added\": {}}]', 9, 1),
(24, '2024-03-18 15:09:22.205412', '18', 'Bluetooth Speakers', 1, '[{\"added\": {}}]', 9, 1),
(25, '2024-03-18 15:09:49.524005', '1', '1000 to 10000', 1, '[{\"added\": {}}]', 8, 1),
(26, '2024-03-18 15:09:52.963513', '2', '10000 to 20000', 1, '[{\"added\": {}}]', 8, 1),
(27, '2024-03-18 15:09:56.269193', '3', '20000 to 30000', 1, '[{\"added\": {}}]', 8, 1),
(28, '2024-03-18 15:09:59.682694', '4', '30000 to 40000', 1, '[{\"added\": {}}]', 8, 1),
(29, '2024-03-18 15:10:03.127352', '5', '40000 to 50000', 1, '[{\"added\": {}}]', 8, 1),
(30, '2024-03-18 15:10:06.922505', '6', 'More than 50000', 1, '[{\"added\": {}}]', 8, 1),
(31, '2024-03-18 15:12:07.668899', '1', 'OnePlus 108 cm (43 inches) Y Series 4K Ultra HD Smart Android LED TV 43Y1S Pro (Black)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (1)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (2)\"}}]', 10, 1),
(32, '2024-03-18 15:14:17.788843', '2', 'Pigeon by Stovekraft Amaze Plus Electric Kettle (14289) with Stainless Steel Body, 1.5 l', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (3)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (4)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (5)\"}}]', 10, 1),
(33, '2024-03-18 15:16:01.457875', '3', 'Phoenix', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (6)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (7)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (8)\"}}]', 10, 1),
(34, '2024-03-18 15:17:12.962183', '4', 'Gladiator', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (9)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (10)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (11)\"}}]', 10, 1),
(35, '2024-03-18 15:19:48.167576', '5', 'Apple iPhone 13 (128GB) - Starlight', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (12)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (13)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (14)\"}}]', 10, 1),
(36, '2024-03-18 15:22:06.499234', '6', 'Apple iPhone 14 Plus (512 GB) - Blue', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (15)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (16)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (17)\"}}]', 10, 1),
(37, '2024-03-18 15:24:25.581567', '7', 'ASUS Vivobook 15, Intel Core i3-1220P 12th Gen, 15.6\" (39.62 cm) FHD, Thin and Laptop (8GB/512GB SSD', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (18)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (19)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (20)\"}}]', 10, 1),
(38, '2024-03-18 15:26:46.405072', '8', 'Philips HD6975/00 Digital Oven Toaster Grill, 25 Litre OTG, 1500 Watt with Opti Temp Technology, Cha', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (21)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (22)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (23)\"}}]', 10, 1),
(39, '2024-03-19 07:04:56.866067', '19', 'Laptop', 1, '[{\"added\": {}}]', 9, 1),
(40, '2024-03-19 07:05:02.646533', '7', 'ASUS Vivobook 15, Intel Core i3-1220P 12th Gen, 15.6\" (39.62 cm) FHD, Thin and Laptop (8GB/512GB SSD', 2, '[{\"changed\": {\"fields\": [\"Subcategories\"]}}]', 10, 1),
(41, '2024-03-26 05:46:50.164009', '13', 'sujal', 3, '', 14, 1),
(42, '2024-03-26 05:46:50.169009', '12', 'sujal', 3, '', 14, 1),
(43, '2024-03-26 05:46:50.172009', '11', 'sujal', 3, '', 14, 1),
(44, '2024-03-26 05:46:50.174010', '10', 'sujal', 3, '', 14, 1),
(45, '2024-03-26 05:46:50.176009', '9', 'sujal', 3, '', 14, 1),
(46, '2024-03-26 05:46:50.178010', '8', 'sujal', 3, '', 14, 1),
(47, '2024-03-26 05:46:50.183011', '7', 'sujal', 3, '', 14, 1),
(48, '2024-03-26 05:46:50.186010', '6', 'sujal', 3, '', 14, 1),
(49, '2024-03-26 05:46:50.188010', '5', 'sujal', 3, '', 14, 1),
(50, '2024-03-26 05:46:50.190009', '4', 'sujal', 3, '', 14, 1),
(51, '2024-03-26 05:46:50.192009', '3', 'sujal', 3, '', 14, 1),
(52, '2024-03-26 05:46:50.194010', '2', 'sujal', 3, '', 14, 1),
(53, '2024-03-26 05:46:50.196009', '1', 'sujal', 3, '', 14, 1),
(54, '2024-03-26 05:54:10.588598', '18', 'sujal', 3, '', 14, 1),
(55, '2024-03-26 05:54:10.592512', '17', 'sujal', 3, '', 14, 1),
(56, '2024-03-26 05:54:10.595509', '16', 'sujal', 3, '', 14, 1),
(57, '2024-03-26 05:54:10.598752', '15', 'sujal', 3, '', 14, 1),
(58, '2024-03-26 05:54:10.600656', '14', 'sujal', 3, '', 14, 1),
(59, '2024-03-27 06:39:21.697939', '24', 'sujal', 3, '', 14, 1),
(60, '2024-03-27 06:39:21.702934', '23', 'sujit', 3, '', 14, 1),
(61, '2024-03-27 06:39:21.704933', '22', 'sujal', 3, '', 14, 1),
(62, '2024-03-27 06:39:21.706936', '21', 'sujal', 3, '', 14, 1),
(63, '2024-03-27 06:39:21.707934', '20', 'sujal', 3, '', 14, 1),
(64, '2024-03-27 06:39:21.710935', '19', 'sujal', 3, '', 14, 1),
(65, '2024-03-27 06:46:48.068685', '25', 'sujal', 2, '[{\"changed\": {\"fields\": [\"Address\", \"Paid\"]}}]', 14, 1),
(66, '2024-03-27 06:56:00.654234', '27', 'sujal', 2, '[{\"changed\": {\"fields\": [\"Address\", \"Paid\"]}}]', 14, 1),
(67, '2024-04-20 06:06:43.577058', '9', 'boAt Rockerz 450 Bluetooth On Ear Headphones with Mic, Upto 15 Hours Playback, 40MM Drivers, Padded', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (24)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (25)\"}}]', 10, 1),
(68, '2024-04-20 06:08:43.823952', '9', 'boAt Rockerz 450 Bluetooth On Ear Headphones with Mic, Upto 15 Hours Playback, 40MM Drivers, Padded', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}, {\"changed\": {\"name\": \"images\", \"object\": \"images object (25)\", \"fields\": [\"Image\"]}}]', 10, 1),
(69, '2024-04-20 06:10:21.009670', '10', 'boAt Airdopes 121v2 in-Ear True Wireless Earbuds with Upto 14 Hours Playback, 8MM Drivers, Battery I', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (26)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (27)\"}}]', 10, 1),
(70, '2024-04-20 06:15:01.078249', '1', 'Refrigerators', 3, '', 9, 1),
(71, '2024-04-20 06:15:08.325907', '20', 'Grinder', 1, '[{\"added\": {}}]', 9, 1),
(72, '2024-04-20 06:17:12.578282', '11', 'Butterfly Rhino Plus Table Top Wet Grinder 2Litre, (Grey) 150W, 230V, AC 50Hz,Plastic', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (28)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (29)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (30)\"}}]', 10, 1),
(73, '2024-04-20 06:19:50.927139', '12', 'Morphy Richards New Europa Coffee Making Machine|800W Espresso & Cappuccino Coffee Machine For Home|', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (31)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (32)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (33)\"}}]', 10, 1),
(74, '2024-04-20 06:21:47.921112', '13', 'Lloyd 1.2 Ton 5 Star Inverter Split AC (5 in 1 Convertible, 100% Copper, Anti-Viral + PM 2.5 Filter,', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (34)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (35)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (36)\"}}]', 10, 1),
(75, '2024-04-20 06:23:49.341099', '14', 'atomberg Aris Starlight 1200mm Ceiling Fans with Underlight, IoT and Remote Control | Smart Fan wit', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (37)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (38)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (39)\"}}]', 10, 1),
(76, '2024-04-20 06:25:18.305272', '15', 'atomberg Renesa 1200mm BLDC Motor 5 Star Rated Sleek Ceiling Fans with Remote | Upto 65% Energy Savi', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (40)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (41)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (42)\"}}]', 10, 1),
(77, '2024-04-20 06:27:46.106327', '16', 'AIRTH Air Purifier For AC, Coated HEPA AC Filter, Proven Protection From PM2.5 PM10 Viruses and Alle', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (43)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (44)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (45)\"}}]', 10, 1),
(78, '2024-04-20 06:43:49.463277', '10', 'boAt Airdopes 121v2 in-Ear True Wireless Earbuds with Upto 14 Hours Playback, 8MM Drivers, Battery I', 2, '[{\"changed\": {\"fields\": [\"Categories\"]}}]', 10, 1),
(79, '2024-04-20 06:43:56.673627', '9', 'boAt Rockerz 450 Bluetooth On Ear Headphones with Mic, Upto 15 Hours Playback, 40MM Drivers, Padded', 2, '[{\"changed\": {\"fields\": [\"Categories\"]}}]', 10, 1),
(80, '2024-04-26 16:31:58.168864', '17', 'Panasonic 20L Solo Microwave Oven (NN-SM25JBFDG,Black)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (46)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (47)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (48)\"}}]', 10, 1),
(81, '2024-04-26 16:34:53.800429', '18', 'FULMINARE Air Purifiers for Bedroom, H13 True HEPA Air Filter, Quiet Air Cleaner With Night Light,Po', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (49)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (50)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (51)\"}}]', 10, 1),
(82, '2024-04-26 16:37:31.418050', '19', 'LG 7 Kg 5 Star Wind Jet Dry Semi-Automatic Top Loading Washing Machine (P7020NGAZ, Dark Gray, Rat Aw', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (52)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (53)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (54)\"}}]', 10, 1),
(83, '2024-04-26 16:39:33.791728', '20', 'Godrej 6.5 Kg 5 Star I-Wash Technology for Automatic One Touch Wash Fully-Automatic Top Load Washing', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (55)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (56)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (57)\"}}]', 10, 1),
(84, '2024-04-26 16:41:46.806302', '21', 'Samsung 8 kg, 5 star, Eco Bubble Technology, AI Control, Wi-Fi, Fully-Automatic Front Load Washing M', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (58)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (59)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (60)\"}}]', 10, 1),
(85, '2024-04-26 16:42:13.249913', '21', 'Samsung 8 kg, 5 star, Eco Bubble Technology, AI Control, Wi-Fi, Fully-Automatic Front Load Washing M', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 10, 1),
(86, '2024-04-26 16:45:33.616535', '22', 'Bajaj DX-6 1000W Dry Iron with Advance Soleplate and Anti-bacterial German Coating Technology, White', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (61)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (62)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (63)\"}}]', 10, 1),
(87, '2024-04-26 16:47:39.953628', '23', 'Havells Plastic Dazzle 1100W Dry Iron Press German Technology Non Sick Coated Sole Plate & 2 Yrs War', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (64)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (65)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (66)\"}}]', 10, 1),
(88, '2024-04-26 16:48:11.828078', '22', 'Bajaj DX-6 1000W Dry Iron with Advance Soleplate and Anti-bacterial German Coating Technology, White', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 10, 1),
(89, '2024-04-26 16:48:29.113152', '22', 'Bajaj DX-6 1000W Dry Iron with Advance Soleplate and Anti-bacterial German Coating Technology, White', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 10, 1),
(90, '2024-04-26 16:51:53.209467', '24', 'GSH USB Wireless Console Game Stick Video Game Console Built-in 3000 Classic Games 8 Bit Mini Retro', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (67)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (68)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (69)\"}}]', 10, 1),
(91, '2024-04-26 16:54:39.284021', '25', 'Buy Now Prmium 4K HD Video Game Console for Girls/Boys/Men/Women/Unisex Wireless Video Game with 64', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (70)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (71)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (72)\"}}]', 10, 1),
(92, '2024-04-26 16:57:05.008761', '26', 'TRONICA Super King 40W 5.1 Bluetooth Home Theater System with FM/PenDrive/Sd Card/Mobile/Aux Support', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (73)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (74)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (75)\"}}]', 10, 1),
(93, '2024-04-26 17:00:35.836722', '16', 'AIRTH Air Purifier For AC, Coated HEPA AC Filter, Proven Protection From PM2.5 PM10 Viruses and Alle', 2, '[{\"changed\": {\"fields\": [\"Filter price\"]}}]', 10, 1),
(94, '2024-04-26 17:07:21.470091', '27', 'LOUIS DEVIN Silicone Strap Analog Wrist Watch for Men (Black/Blue/Red) | LD-BK054', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (76)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (77)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (78)\"}}]', 10, 1),
(95, '2024-04-26 17:09:25.655334', '28', 'SKMEI Men\'s Watch New Wheels Rolling Creative Fashion Che Youhui League Fans Butterfly Double Snap G', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (79)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (80)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (81)\"}}]', 10, 1),
(96, '2024-04-26 17:11:59.378292', '29', 'Fire-Boltt Ninja Call Pro Plus 1.83\" Smart Watch with Bluetooth Calling, AI Voice Assistance, 100 Sp', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (82)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (83)\"}}, {\"added\": {\"name\": \"images\", \"object\": \"images object (84)\"}}]', 10, 1),
(97, '2026-03-15 15:57:56.039897', '56', 'sujal', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 14, 1),
(98, '2026-03-15 15:57:56.044095', '55', 'sujal', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 14, 1),
(99, '2026-03-15 15:57:56.046107', '54', 'sujal', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 14, 1),
(100, '2026-03-15 16:08:17.787758', '67', 'sujal', 3, '', 14, 1),
(101, '2026-03-15 16:08:17.790215', '66', 'sujal', 3, '', 14, 1),
(102, '2026-03-15 16:08:17.792121', '65', 'sujal', 3, '', 14, 1),
(103, '2026-03-15 16:08:17.794154', '64', 'sujal', 3, '', 14, 1),
(104, '2026-03-15 16:08:17.796737', '63', 'sujal', 3, '', 14, 1),
(105, '2026-03-15 16:08:17.797747', '62', 'sujal', 3, '', 14, 1),
(106, '2026-03-15 16:08:17.799923', '61', 'sujal', 3, '', 14, 1),
(107, '2026-03-15 16:08:17.802169', '60', 'sujal', 3, '', 14, 1),
(108, '2026-03-15 16:08:17.804171', '59', 'sujal', 3, '', 14, 1),
(109, '2026-03-15 16:15:12.842197', '57', 'sujal', 2, '[{\"changed\": {\"fields\": [\"Delivery date\"]}}]', 14, 1),
(110, '2026-03-15 16:18:03.402771', '57', 'sujal', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 14, 1),
(111, '2026-03-15 16:20:19.856017', '57', 'sujal', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 14, 1),
(112, '2026-03-15 16:20:29.707088', '57', 'sujal', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 14, 1),
(113, '2026-04-02 03:43:42.571103', '1', 'DIWALI20 (10% OFF)', 1, '[{\"added\": {}}]', 20, 1),
(114, '2026-04-02 03:55:45.926833', '29', 'Fire-Boltt Ninja Call Pro Plus 1.83\" Smart Watch with Bluetooth Calling, AI Voice Assistance, 100 Sp', 2, '[{\"changed\": {\"fields\": [\"Discount percentage\", \"Offer expiry\"]}}]', 10, 1),
(115, '2026-04-02 04:00:25.555509', '3', 'Phoenix', 2, '[{\"changed\": {\"fields\": [\"Discount percentage\", \"Offer expiry\"]}}]', 10, 1),
(116, '2026-04-02 04:00:25.557511', '1', 'OnePlus 108 cm (43 inches) Y Series 4K Ultra HD Smart Android LED TV 43Y1S Pro (Black)', 2, '[{\"changed\": {\"fields\": [\"Discount percentage\", \"Offer expiry\"]}}]', 10, 1);

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session'),
(7, 'store', 'categories'),
(13, 'store', 'contact_us'),
(20, 'store', 'coupon'),
(16, 'store', 'emailotp'),
(8, 'store', 'filter_price'),
(11, 'store', 'images'),
(14, 'store', 'order'),
(15, 'store', 'orderitem'),
(19, 'store', 'orderstatushistory'),
(10, 'store', 'product'),
(12, 'store', 'profile'),
(17, 'store', 'review'),
(9, 'store', 'subcategories'),
(21, 'store', 'useractivity'),
(18, 'store', 'wishlist');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2024-03-18 15:03:40.496069'),
(2, 'auth', '0001_initial', '2024-03-18 15:03:40.822744'),
(3, 'admin', '0001_initial', '2024-03-18 15:03:40.909742'),
(4, 'admin', '0002_logentry_remove_auto_add', '2024-03-18 15:03:40.930748'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2024-03-18 15:03:40.936747'),
(6, 'contenttypes', '0002_remove_content_type_name', '2024-03-18 15:03:40.982746'),
(7, 'auth', '0002_alter_permission_name_max_length', '2024-03-18 15:03:41.032191'),
(8, 'auth', '0003_alter_user_email_max_length', '2024-03-18 15:03:41.042869'),
(9, 'auth', '0004_alter_user_username_opts', '2024-03-18 15:03:41.048490'),
(10, 'auth', '0005_alter_user_last_login_null', '2024-03-18 15:03:41.077714'),
(11, 'auth', '0006_require_contenttypes_0002', '2024-03-18 15:03:41.080225'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2024-03-18 15:03:41.084530'),
(13, 'auth', '0008_alter_user_username_max_length', '2024-03-18 15:03:41.093726'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2024-03-18 15:03:41.103901'),
(15, 'auth', '0010_alter_group_name_max_length', '2024-03-18 15:03:41.112917'),
(16, 'auth', '0011_update_proxy_permissions', '2024-03-18 15:03:41.118308'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2024-03-18 15:03:41.124602'),
(18, 'sessions', '0001_initial', '2024-03-18 15:03:41.147444'),
(19, 'store', '0001_initial', '2024-03-18 15:03:41.168547'),
(20, 'store', '0002_product', '2024-03-18 15:03:41.284868'),
(21, 'store', '0003_images', '2024-03-18 15:03:41.328472'),
(22, 'store', '0004_alter_product_unique_id', '2024-03-18 15:03:41.332471'),
(23, 'store', '0005_product_created_date', '2024-03-18 15:03:41.341718'),
(24, 'store', '0006_profile', '2024-03-18 15:03:41.394326'),
(25, 'store', '0007_contact_us', '2024-03-18 15:03:41.403363'),
(26, 'store', '0008_order_orderitem', '2024-03-23 06:18:26.362676'),
(27, 'store', '0009_order_amount', '2024-03-23 06:18:26.377827'),
(28, 'store', '0010_order_paid_order_payment_id', '2024-03-23 06:22:24.394843'),
(29, 'store', '0011_remove_order_profile', '2024-03-25 12:14:25.156351'),
(30, 'store', '0012_rename_date_order_dateofbirth', '2024-03-25 13:08:15.870300'),
(31, 'store', '0013_rename_firstname_orderitem_price', '2024-03-26 04:07:16.596643'),
(32, 'store', '0014_order_payment_method', '2024-04-11 04:39:19.706404'),
(33, 'store', '0015_rename_dateofbirth_order_orderdate', '2024-04-26 11:36:01.039709'),
(34, 'store', '0016_emailotp', '2026-03-15 13:35:15.733437'),
(35, 'store', '0017_review', '2026-03-15 14:18:33.465737'),
(36, 'store', '0018_review_image', '2026-03-15 14:29:11.738459'),
(37, 'store', '0019_wishlist', '2026-03-15 14:32:06.121203'),
(38, 'store', '0020_order_status', '2026-03-15 15:53:53.774636'),
(39, 'store', '0021_order_delivery_date_order_is_cancelled_and_more', '2026-03-15 16:11:22.315963'),
(40, 'store', '0022_coupon_product_discount_percentage_and_more', '2026-04-02 03:36:04.847651'),
(41, 'store', '0023_useractivity', '2026-04-05 12:36:08.273136'),
(42, 'store', '0024_product_stock', '2026-04-17 17:05:06.207622');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('1n1px5k1ix3scfhs6oxlf0kugaiuhe74', '.eJx9kctu2zAQRX9lwJUNqDIfenoX161TpEUNyEkRoIAxImmLiUSqEtWgCPzvpdqgaBfphouZO3fOHT6TI06-OU6jHo5GkTXhJPq7VqN81HZuqAe0ZxdLZ_1g6niWxC_dMf7klG43L9p_DBocmzB9EllWlApTLZPkVLNEY0IpYkprJeq0KFNMCkFPSHUuszpRKE6MirSQNS_yLA-mEgdP1s8kn5_Ze-blEekHpybpf-HnEbHY6bDwqrqt4M58d7Vzj8DSCD5Yr1t46wYNRrxhnNM9MO4b2GkbBUWcfSWwEGWccZDdEt5fbyM4NMYCWgUfsfeuh0Wx26xSxncbqKptoPo2ofXG_yBrNqMYOS8XRVnSmNLQNx2e59Kq08rgyuqncdViz-KH_kwuEWH_ScP-pPls9b6dRmC0CGywSAQYKxs9LuEeqjCsR0hu4Lb1A8L1FqouHAuurBqcCezvtnC4g0Tcswr2g4PFpg1_tXwNn_OyLF_HD2fUR_3loOWN_B3jcvkJo1Wzlg:1uLxjZ:COfCrAKWqnDa01hb0MGnecPtwJSMKS-6-wxWv4JhGfs', '2025-06-16 05:29:17.062909'),
('5toco5fd0o3o8x1rgera7y9wwwuoe4lw', '.eJxVjDsOwjAQBe_iGlnrjT-Ykj5nsNY_HEC2FCcV4u5gKQW0b2beiznat-L2nla3RHZhgp1-N0_hkeoA8U711nhodVsXz4fCD9r53GJ6Xg_376BQL6NWmEkjyBTPAizYKaKaAH3IlrQwBDYLqQRN0SB4mxPar-w1QDBCGvb-AMhWNvk:1w22cp:Ws79xIuJcvIOnpw3e9nOJFYW9yV_z7arCHOjLghRS24', '2026-03-30 07:44:31.174701'),
('75s504z72wp0y0qen0srbze8lfhi0qw6', '.eJx9j1FPwjAUhf9K0ydJyGjXbmy8STCaoJEE0PC03LUdG24dtl3QEP67HRKjD_JyH-6593znHHEGnSuzziqTVRJPcIiHv3c5iDele0HuQG_bQLTamSoP-pPgotrgqZWqnl5u_xiUYEv_XbA4TlIJkRKcFznlCjghABHJJcujJI2AJ4wUQNRYxDmXwApKWJSIPEzG8dibCjAOT46Y9qP37vOGQ7w3reyEO8enQ6yhUR74rNWi7iyiJEGiQTecoUqLUtkB2qClf1YW8Tla184AepihZePt0a2Wpq0kerybodUL4mxDl2hhWnQzrX27gY_x3oF2lfs8w_amEj0tDNM0DQjxetXAtl-NGiUrGGl1sCOnapWp15UScxHs9lt8GmJ-pQb_qXFfg3dxrfmPTNk1sG1oFq9XHwfKvrmn0xf7kp1d:1rvUpP:56K-LN3SDPGp1x5oXAvNNFgRtCghUWvhNrigQdoIKhw', '2024-04-27 04:17:23.926520'),
('ayayfn776i4ng7vtjseuhhk6w834vtfk', 'eyJ1c2VyX2lkIjozfQ:1w8VlB:qguZSJ_knlJrQFbREQSzm1H1FFwocupRbFxERRKjkdU', '2026-04-17 04:03:53.399666'),
('d1dz3l83s4ih2xk0fc80mnyvtnv5rzco', 'eyJ1c2VyX2lkIjoyfQ:1w1mXX:d3JVUaNZjjTawXhcb7bI4SsTBQHHWtMYxbh2mphB8KQ', '2026-03-29 14:33:59.777787'),
('dc5i9uk5mmzot3u2deqpqas6g27gzwkv', '.eJxVjDkOwyAUBe9CHSFsVrtMnzOg_1mCkwgkwJXlu8eWXCTtm3mzEQtrT3ZtodrFk5mM5Pa7Ibh3yCfwL8jPQl3JvS5IT4VetNFH8eFzv9y_QIKWjnfkSpnJgwxOiIiDCCAYA5AMPUdpJgnCcBaBBe0UCg88DoxL43A0Wukj6qB2Mm_7_gUwDztC:1rxLpB:AdoawzDb2qxmeK6xA0Y1LWFnJXGgw2XXFZs69-vMNM0', '2024-05-02 07:04:49.388610'),
('gkcwino7kpts8fcp9u0livhkp87qy0db', '.eJx9kt9vmzAQx_-VE0-JlJEYDIS-FbVapmxapPTH8oSMOYIbYzMwzbIq__tMlzbNQ3mxTr67730_Z784KetMmXYtNqnInSvHcyYf7zLGd6j6RP7E1Fa7XCvTiMztS9xTtnV_6Bxlcqq9EChZW_bdpKA8C-MZBjwrckIoRrEN0feCkIdBGCGNEeeY-wWNIowoiTLKkPPY4z4trChnjXGuXpygP3rt3q83cepG5x03r_aDiaNYhXbgdV1LBLEqtUIgPoyIN_-ajOELrA1rpNiWxmr-7pgywhxOQoL3rTSmcezOZjYvKrbtr6YV5oJNFe7baU3S-8WDiJLWfaq3znHikAFH5N3RT4Ur2bVAZnPgFYyoD0LxEtsxbGBtm7EFuoR7aRoGixtYVxYYrlXeaJHD99sbuHsA6m_IGlaNhlEi7b7HFxD-GcLz4iEIgxJTfLxDvuRvGN4AhveOsRJb1Aqyg12kfsZdwwrrsmJ_EV7xbiVy-0M4LNEY-wQjQr15PIa9MGW_e6Ektq2NECUkOj9MgLgByAsQcgYJhjC4LgpM97J73n1bvnH4Axz-maPUqMSfz8aSwfXtGUnDx-jXYmP-Tz0e_wHxCQps:1rnbwO:ymWnJ3swI-NMwJD-pYvlgip_2_M6IoTevHUsRib6KGs', '2024-04-05 10:16:00.562937'),
('gll0rk2qqa77s6q0nt8env11xabkovl0', '.eJxVjMsKwjAQRf8lawmTycu4dO83hMnLVKWBpl2J_66BInR7zrn3zbaeFz8ldsET87St1f8JE-zAAsVnnodID5rvjcc2r8sU-Ej4bju_tZRf1709HFTqdaw1FjIIKqezAAdOJtQSMMTiyAhL4IpQWpBMFiG4ktH94mAAohXKss8Xa3w6wA:1wDzJ4:r5X9_tQkY6dcb2eBFpJZEanv0noi_1HdjZQnzjdTETw', '2026-05-02 06:37:30.928237'),
('h0v1fy3h32r3s7guynpw3sp4f7x4df1p', '.eJxVjDkOwyAUBe9CHSFsVrtMnzOg_1mCkwgkwJXlu8eWXCTtm3mzEQtrT3ZtodrFk5mM5Pa7Ibh3yCfwL8jPQl3JvS5IT4VetNFH8eFzv9y_QIKWjnfkSpnJgwxOiIiDCCAYA5AMPUdpJgnCcBaBBe0UCg88DoxL43A0Wukj6qB2Mm_7_gUwDztC:1rulZm:lDo9MUGxMlzNgT6ffQ7xmC9JGZX80cCyMeN1stQXpq4', '2024-04-25 03:58:14.590471'),
('j3bao8nfc1evm1hg0rrnmognkdgl9nm4', '.eJxVjDkOwyAUBe9CHSFsVrtMnzOg_1mCkwgkwJXlu8eWXCTtm3mzEQtrT3ZtodrFk5mM5Pa7Ibh3yCfwL8jPQl3JvS5IT4VetNFH8eFzv9y_QIKWjnfkSpnJgwxOiIiDCCAYA5AMPUdpJgnCcBaBBe0UCg88DoxL43A0Wukj6qB2Mm_7_gUwDztC:1ryCOO:yHjTKBtsSluznvHREfZESOH2gxKJRHpmkyiMB1TJrJA', '2024-05-04 15:12:40.531313'),
('k4g7w25qxmko7c2dnt3443ivgwkfk57o', '.eJxVT19rwjAQ_ypHnxSkJmm1xreJg4EbE3QbPpU0udq4NnVJyhjid18CfdheDu5-f--WlGLwTTk4tKVWyTqhyezvrRLyE00E1EWYc5_K3nirqzRS0hF16UuvsN2M3H8GjXBNVC9YLZaM5KhWlHDCM8UWGWGVrLlY0kIQXtN8QUWmCkYqXiPjgVwtCZEFzYtgKoX1yfoWGoYRvWNfOkuutleD9OW4GtFhCHw1uG8HB5SsQHYwyTPQRjbopnCCQxCjg3wHb623Ap62cOiCPTwYZXut4PlxC8d3yLMTPcDe9jDZtOG7aajxNQjjtf8Zs7WMaYxxzlNCAq47cY6neYdKi7nBbzf32GKJH0eUO5lerufkfr__AiYEdxE:1s0agF:CneUF67s6rBs0bea3Kpv5TXunW1_7gv_GkKTFA5__0E', '2024-05-11 05:32:59.391611'),
('koaxsgj05dw7h6wr7z9p4vhraih71n87', '.eJxVjDsOgzAQBe_iOrKw17-lTJ8zoPV6CSQRSHwqxN0DEkXSvpk3m2poXbpmnWVq-qJqZdXtd8vEbxlOUF40PEfN47BMfdanoi8668dY5HO_3L9AR3N3vFEoQ8wlRfbJoGsjepEEFgHbqgTLEQNANBYdWSBmyNIm9C5UoRg-okzToupt378RWzqy:1rmtLc:7z2RizZLrqa2f40fMywhRKiXh642N8DNK6ZyEotp5nI', '2024-04-03 10:39:04.436219'),
('l1sx5sywb1l3cfckmjs60brtk39egn13', '.eJxVT09rwjAU_yqPnBSkpm1aW28TBwM3Jug2PJXX5NXGtalLU8YQv_tS8bBd3uH3_11YgYOri6EnW2jFlixis79YifKTzEioE5pjF8jOOKvLYJQEd7YPXjpFzequ_RdQY197dxWnaZYrTEgKUZWhIBScIya8VHGZZHmCIot5hZwWMi2FwrgKeZxksoyyRbrwoRKtY8sLC8czZo97oxk7204N0t3mhzNmsCVf-Gpo2ww9hDwD2cJExKCNrKmfwgF23kw9iA28Nc4iPK1h1_p4eDDKdlrB8-Ma9u8g4kO4g63tYLJq_HdTP-NrQOO0-7mVna2WY1sU5XkecO553eJxhOYtKY1zQ9_93FFDBX3sSW5kcDof2fV6_QUdoXgP:1rzVQx:DzBEeFAU-3m-cC_cscbI2NzG68MLcHoAcSWJ83NKUdE', '2024-05-08 05:44:43.693487'),
('ptxc98fp4m4rij3gb4a5awupcg9bigxl', '.eJxVjstOhDAUhl-FdOUkWFraQmEnG92YmBjdktML0BEKQokxk3l3qZmFbs7iv3znv6AW9jC0-2bX1hlUoxylfzUF-sP6aJgz-H7GevZhdQrHCL65G36ejR2bW_YfYIBtONodKwpZGRBWc94pyi1wQgAEUYYpISsBXDLSAbGlLhQ3wDpKmJBa5bIsygOqYQ2oviART2THvXmKlnU2uw6_80WKPEz2ePiwLKNN3Mswe5tQltzRXD42p-Q-eQ2wjq4fwsH83MEHF75RTSPI6VjlFa8qTMjhuwn6KGWTNQ4yb7-2bKHt29O7K5sNn5ceXa_XHwy7Z18:1s0OtY:PtCmEdEFFSOkzMMu44GI3-QtpbiFgvjQYBtL_gLicWw', '2024-05-10 16:57:56.816595'),
('q600tlvta9z8vjdjb9gjjlwzjl2jcuvh', '.eJxVjDsOwjAQBe_iGlnrjT-Ykj5nsNY_HEC2FCcV4u5gKQW0b2beiznat-L2nla3RHZhgp1-N0_hkeoA8U711nhodVsXz4fCD9r53GJ6Xg_376BQL6NWmEkjyBTPAizYKaKaAH3IlrQwBDYLqQRN0SB4mxPar-w1QDBCGvb-AMhWNvk:1wDzH5:iTkyF8HSsX97i6d_yIy57r7vdNm-rRD1REai4yKlTgY', '2026-05-02 06:35:27.624420'),
('r2dq263jg990jpiyrd33y5iv7h6hfowv', '.eJxVT8tqwzAQ_BXhUwtBkR9y7Nwa6KGEQqAfYFbSylYsS6ktJ6Qh_14ZfGgvy-7M7szsI2lgDl0zTzg2RiX7JEs2fzEBske3EOoMrvVUehdGI-iyQld2op9eoT2su_8EOpi6eK3zsqxqBRxlUWiRFggFYwCcCZULXtUciipnGhjuZCkKBblOWc4rKbJqV-6iqIQxJPtHTBjLor3kzTbJZfRqlqFZRwcDRsOTadE7Iu7kK_gr9iPoQN4G-EFysvNE3i3K-IgkRwzBInlJi6yqX8nNhC6egHEWpyl2iJYcvLpvSEo5sTHI9wwumHBf3Y1c_HhdU8YiawZoF2A7oDKwdXibttJrjc3Nztf-40jPlzZ5Pp-_L_J71g:1vYgB4:cs_NkQbfyJAPXqAdAbTd-S5aEAGHpnMlQ_NOXdWQsl0', '2026-01-08 07:54:30.866390'),
('ri71ywyn1s6dtlc3nqadodfd07714wng', '.eJxVT8tqwzAQ_BWhUwtBsS2_5FsDPZRQCPQDzFpa20pkKbXlhDTk3ytBDu1l2Z3ZnZm90xZWP7brgnOrFW1oRjd_sQ7kCW0k1BHs4Jh01s-6Y3GFPdmFfTqFZvfc_ScwwjKGa4HQ8apTdSWLOhV5X4kCseaZ4KJPVJnJSpScV2kmcsg4SMk77GtR5GVSqlQGUQmzp809JAwlase82YaeZ6dW6dvnaGHCYHjQAzpLuhv58u6Cpxl6T94m-EFyMOtC3g3K8Igke_TeIHlJ86wWr-Sq_RhOQFuDyxI6REN2Tt02JGUFMSHI9wrWa3-jTRrdtYx-hRAsSQKrJxgisJ1QadhavC5b6foe26tZL6ePPTueB_p4PH4BoQJ7RQ:1rmVvr:g0zRKMJ6HcCBNvj1He0_0TzpYdogXiwwM1WaA23dUPk', '2024-04-02 09:38:55.025578'),
('tf6bybq0vpsy40sapwkt1q12hb8h62c0', '.eJxVjMEOwiAQRP-FsyFLKQIevfsNZFkWqRpISnsy_rtt0oMeZ96beYuA61LC2nkOUxIXMYjTbxeRnlx3kB5Y701Sq8s8Rbkr8qBd3lri1_Vw_w4K9rKtlRk5WtTOEmVmY9Tg2YJWdkvgs7YclQdwnpEzA5hITlPGM7IekxefL_KuOJw:1rozsS:3E4s-PYgwnJ03pTxzGhJwNq-GHHSBHJ5COl59bjuXDE', '2024-04-09 06:01:40.160469');

-- --------------------------------------------------------

--
-- Table structure for table `profile`
--

CREATE TABLE `profile` (
  `id` bigint(20) NOT NULL,
  `gender` varchar(15) NOT NULL,
  `contact` bigint(20) NOT NULL,
  `address` longtext NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `profile`
--

INSERT INTO `profile` (`id`, `gender`, `contact`, `address`, `user_id`) VALUES
(1, 'male', 8574692145, 'i-404 avani square manohar villa ahemdabad gujarat\r\n\r\n', 2),
(2, 'male', 84579568475, 'oi\'ewhfwrsoighrwgnslidghwnroenig', 3),
(3, 'male', 7418529637, 'qwertyuiopqwertyuiopasdfghjklzxcvbnm', 4),
(4, 'male', 7048185783, 'sddvsrswrgesrge', 6),
(5, 'male', 7048185783, 'drge', 7),
(6, 'Not Specified', 0, '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `store_categories`
--

CREATE TABLE `store_categories` (
  `id` bigint(20) NOT NULL,
  `name` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store_categories`
--

INSERT INTO `store_categories` (`id`, `name`) VALUES
(1, 'Kitchen Appliances'),
(2, 'Home Comfort Appliances'),
(3, 'Laundry Appliances'),
(4, 'Entertainment Appliances'),
(5, 'Watches'),
(6, 'Mobiles & Accessories');

-- --------------------------------------------------------

--
-- Table structure for table `store_contact_us`
--

CREATE TABLE `store_contact_us` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `subject` varchar(200) NOT NULL,
  `message` longtext NOT NULL,
  `date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store_contact_us`
--

INSERT INTO `store_contact_us` (`id`, `name`, `email`, `subject`, `message`, `date`) VALUES
(1, 'sujit', 'sujit@gmail.com', 'khhab;aiuf', 'iuduKGFS:ABIE>KVFIA:GEUQFB:IUVWUGFYB;AIEF', '2024-03-19 06:46:30.294536'),
(2, 'kwehnf', 'sujitpatel5210@gmail.com', 'sdlfhi', 'aefwef', '2024-03-27 09:35:01.754925'),
(3, 'pooja', 'poja@gmail.com', 'yffyotufgv', 'lygblykhbiuhj', '2024-04-26 17:02:38.235145');

-- --------------------------------------------------------

--
-- Table structure for table `store_coupon`
--

CREATE TABLE `store_coupon` (
  `id` bigint(20) NOT NULL,
  `code` varchar(50) NOT NULL,
  `discount_percentage` decimal(5,2) NOT NULL,
  `min_order_amount` decimal(10,2) NOT NULL,
  `max_uses` int(10) UNSIGNED NOT NULL CHECK (`max_uses` >= 0),
  `times_used` int(10) UNSIGNED NOT NULL CHECK (`times_used` >= 0),
  `is_active` tinyint(1) NOT NULL,
  `valid_from` datetime(6) NOT NULL,
  `valid_to` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store_coupon`
--

INSERT INTO `store_coupon` (`id`, `code`, `discount_percentage`, `min_order_amount`, `max_uses`, `times_used`, `is_active`, `valid_from`, `valid_to`, `created_at`) VALUES
(1, 'DIWALI20', 10.00, 200.00, 10, 0, 1, '2026-04-02 03:42:53.000000', '2026-04-04 03:43:39.000000', '2026-04-02 03:43:42.569804');

-- --------------------------------------------------------

--
-- Table structure for table `store_emailotp`
--

CREATE TABLE `store_emailotp` (
  `id` bigint(20) NOT NULL,
  `otp` varchar(6) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store_emailotp`
--

INSERT INTO `store_emailotp` (`id`, `otp`, `created_at`, `user_id`) VALUES
(25, '282148', '2026-04-03 04:02:52.980328', 3),
(46, '477187', '2026-04-18 06:37:23.237183', 2);

-- --------------------------------------------------------

--
-- Table structure for table `store_filter_price`
--

CREATE TABLE `store_filter_price` (
  `id` bigint(20) NOT NULL,
  `Price` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store_filter_price`
--

INSERT INTO `store_filter_price` (`id`, `Price`) VALUES
(1, '1000 to 10000'),
(2, '10000 to 20000'),
(3, '20000 to 30000'),
(4, '30000 to 40000'),
(5, '40000 to 50000'),
(6, 'More than 50000');

-- --------------------------------------------------------

--
-- Table structure for table `store_images`
--

CREATE TABLE `store_images` (
  `id` bigint(20) NOT NULL,
  `image` varchar(100) NOT NULL,
  `product_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store_images`
--

INSERT INTO `store_images` (`id`, `image`, `product_id`) VALUES
(1, 'news/tele3_auxCH1S.jpg', 1),
(2, 'news/tele4_YOAQ1Um.jpg', 1),
(3, 'news/coffe_WPMFvnx.jpg', 2),
(4, 'news/cofee2_vy7hx9b.jpg', 2),
(5, 'news/cofee3_4eDfktO.jpg', 2),
(6, 'news/wa1_MGb8sM1.jpg', 3),
(7, 'news/wa2_6uWbkbB.jpg', 3),
(8, 'news/wa3_0GgnPJN.jpg', 3),
(9, 'news/sm1_uQOblIu.jpg', 4),
(10, 'news/sm2_9enIsxM.jpg', 4),
(11, 'news/sm3_NXA6kqx.jpg', 4),
(12, 'news/p1_CJwPlIY.jpg', 5),
(13, 'news/p2_m1lX9Ew.jpg', 5),
(14, 'news/p3_WIPiSuB.jpg', 5),
(15, 'news/mo1_9mxNiHc.jpg', 6),
(16, 'news/mo2.jpg', 6),
(17, 'news/mo3.jpg', 6),
(18, 'news/lap1_vdxVlD1.jpg', 7),
(19, 'news/lap2.jpg', 7),
(20, 'news/lap3.jpg', 7),
(21, 'news/mic1_dvvsOra.jpg', 8),
(22, 'news/mic2.jpg', 8),
(23, 'news/mic3.jpg', 8),
(24, 'news/b2.jpg', 9),
(25, 'news/b3_GAdumq2.jpg', 9),
(26, 'news/e2.jpg', 10),
(27, 'news/e3.jpg', 10),
(28, 'news/g2.jpg', 11),
(29, 'news/g3.jpg', 11),
(30, 'news/g4.jpg', 11),
(31, 'news/c2_QziSjSh.jpg', 12),
(32, 'news/c3_ttZL3ZT.jpg', 12),
(33, 'news/c4.jpg', 12),
(34, 'news/aa2.jpg', 13),
(35, 'news/aa3.jpg', 13),
(36, 'news/aa4.jpg', 13),
(37, 'news/f2.jpg', 14),
(38, 'news/f3.jpg', 14),
(39, 'news/f4.jpg', 14),
(40, 'news/ff2.jpg', 15),
(41, 'news/ff3.jpg', 15),
(42, 'news/ff4.jpg', 15),
(43, 'news/a22.jpg', 16),
(44, 'news/a33.jpg', 16),
(45, 'news/a44.jpg', 16),
(79, 'news/q22.jpg', 28),
(80, 'news/q33.jpg', 28),
(81, 'news/q44.jpg', 28),
(85, 'news/91Ragv1G-aL._SL1500_.jpg', 30),
(86, 'news/81BChvoSBUL._SL1500_.jpg', 30),
(87, 'news/61UDDklDWSL._SL1500_.jpg', 30),
(88, 'news/71h7fLNEQPL._SL1500_.jpg', 30),
(89, 'news/41Lewj2FmL._SX679_.jpg', 31),
(90, 'news/41X9Yq94QVL._SX679_.jpg', 31),
(91, 'news/31s4WuqU8cL._SX679_.jpg', 31),
(92, 'news/41cDpau9wL._SX679_.jpg', 31),
(93, 'news/711q6oRl-RL._SX679_.jpg', 32),
(94, 'news/71nVtcGqlfL._SX679_.jpg', 32),
(95, 'news/51PAYxKo2qL._SX38_SY50_CR003850_.jpg', 33),
(96, 'news/71QIFLrrqL._SX679_.jpg', 33),
(97, 'news/61EdtkK4tmL._SX679_.jpg', 34),
(98, 'news/61-jZrphNyL._SL1500_.jpg', 34),
(99, 'news/41-CiSE2KL._SS100_.jpg', 35),
(100, 'news/41sS-5e43jL._SS100_.jpg', 35),
(101, 'news/5167Mtzk8L._SS100_.jpg', 36),
(102, 'news/51dYVXXNfQL._SS100_.jpg', 36);

-- --------------------------------------------------------

--
-- Table structure for table `store_order`
--

CREATE TABLE `store_order` (
  `id` bigint(20) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `address` longtext NOT NULL,
  `city` varchar(100) NOT NULL,
  `firstname` varchar(100) NOT NULL,
  `pincode` int(11) NOT NULL,
  `phone` bigint(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `orderdate` date NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` varchar(100) NOT NULL,
  `paid` tinyint(1) DEFAULT NULL,
  `payment_id` varchar(300) DEFAULT NULL,
  `payment_method` varchar(100) NOT NULL,
  `status` varchar(20) NOT NULL,
  `delivery_date` date DEFAULT NULL,
  `is_cancelled` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store_order`
--

INSERT INTO `store_order` (`id`, `lastname`, `state`, `address`, `city`, `firstname`, `pincode`, `phone`, `email`, `orderdate`, `user_id`, `amount`, `paid`, `payment_id`, `payment_method`, `status`, `delivery_date`, `is_cancelled`) VALUES
(54, 'sharma', 'Gujarat', 'i-404 avani square manohar villa ahemdabad gujarat\r\n\r\n', 'Ahmedabad', 'sujal', 4444, 8574692145, 'sujal78sharma@gmail.com', '2024-04-17', 2, '52297.0', 1, NULL, 'Online Payment', 'confirmed', NULL, 0),
(55, 'sharma', 'Gujarat', 'i-404 avani square manohar villa ahemdabad gujarat\r\n\r\n', 'Ahmedabad', 'sujal', 123456, 8574692145, 'sujal78sharma@gmail.com', '2024-04-20', 2, '5998.0', 0, NULL, ' Cash On Delivery', 'shipped', NULL, 0),
(56, 'sharma', 'Gujarat', 'i-404 avani square manohar villa ahemdabad gujarat\r\n\r\n', 'Ahmedabad', 'sujal', 23455, 8574692145, 'sujal78sharma@gmail.com', '2024-04-26', 2, '49899', 1, NULL, 'Online Payment', 'cancelled', NULL, 1),
(57, 'sharma', 'Gujarat', 'drge', 'Ahmedabad', 'sujal', 94534, 8574692145, 'sujal78sharma@gmail.com', '2024-04-27', 2, '97399', 1, NULL, 'Online Payment', 'delivered', '2026-03-16', 0),
(58, 'patel', 'Gujarat', 'drge', 'Ahmedabad', 'harsh', 123223, 7048185783, 'sujal78sharma@gmail.com', '2024-04-27', 7, '92396', 1, NULL, 'Online Payment', 'delivered', NULL, 0),
(68, 'sharma', 'Gujarat', 'Manohar villa char rasta', 'Ahemdabad', 'sujal', 382330, 7048185783, 'sujal78sharma@gmail.com', '2026-04-05', 1, '2676.00', 0, NULL, 'Online Payment', 'cancelled', NULL, 1),
(69, 'sharma', 'Gujarat', 'Manohar villa char rasta', 'Ahemdabad', 'sujal', 382330, 7048185783, 'sujal78sharma@gmail.com', '2026-04-05', 1, '2676.00', 0, NULL, 'Online Payment', 'out_for_delivery', '2026-04-08', 0),
(70, 'sharma', 'Gujarat', 'ugoiuyrtearwsdfgk;lk\'ljgkfhfsjgdz', 'Ahemdabad', 'sujal', 382330, 7048185783, 'sujal78sharma@gmail.com', '2026-04-05', 1, '117134.82', 1, 'pay_SZpCRaaBzi32bb', 'Online Payment', 'out_for_delivery', '2026-04-06', 0);

-- --------------------------------------------------------

--
-- Table structure for table `store_orderitem`
--

CREATE TABLE `store_orderitem` (
  `id` bigint(20) NOT NULL,
  `product` varchar(200) NOT NULL,
  `price` varchar(100) NOT NULL,
  `image` varchar(100) NOT NULL,
  `quantity` varchar(20) NOT NULL,
  `total` varchar(1000) NOT NULL,
  `order_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store_orderitem`
--

INSERT INTO `store_orderitem` (`id`, `product`, `price`, `image`, `quantity`, `total`, `order_id`) VALUES
(59, 'Gladiator', '1399.00', '/media/news/sm1_6UTxw13.jpg', '2', '2798.0', 54),
(60, 'Apple iPhone 13 (128GB) - Starlight', '49499.00', '/media/news/p1_UHVi7Bs.jpg', '1', '49499.0', 54),
(61, 'boAt Airdopes 121v2 in-Ear True Wireless Earbuds with Upto 14 Hours Playback, 8MM Drivers, Battery I', '1299.00', '/media/news/e.jpg', '1', '1299.0', 55),
(62, 'Butterfly Rhino Plus Table Top Wet Grinder 2Litre, (Grey) 150W, 230V, AC 50Hz,Plastic', '4699.00', '/media/news/g.webp', '1', '4699.0', 55),
(63, 'Apple iPhone 13 (128GB) - Starlight', '49499.00', '/media/news/p1_UHVi7Bs.jpg', '1', '49499.0', 56),
(64, 'Apple iPhone 14 Plus (512 GB) - Blue', '96999.00', '/media/news/mo1.jpg', '1', '96999.0', 57),
(65, 'OnePlus 108 cm (43 inches) Y Series 4K Ultra HD Smart Android LED TV 43Y1S Pro (Black)', '22999.00', '/media/news/tele_eWTecKc.jpg', '4', '91996.0', 58),
(76, 'AIRTH Air Purifier For AC, Coated HEPA AC Filter, Proven Protection From PM2.5 PM10 Viruses and Alle', '2200.0', '/media/news/a11.jpg', '1', '2200.0', 68),
(77, 'AIRTH Air Purifier For AC, Coated HEPA AC Filter, Proven Protection From PM2.5 PM10 Viruses and Alle', '2200.0', '/media/news/a11.jpg', '1', '2200.0', 69),
(78, 'AIRTH Air Purifier For AC, Coated HEPA AC Filter, Proven Protection From PM2.5 PM10 Viruses and Alle', '2200.0', '/media/news/a11.jpg', '1', '2200.0', 70),
(79, 'Apple iPhone 14 Plus (512 GB) - Blue', '96999.0', '/media/news/mo1.jpg', '1', '96999.0', 70);

-- --------------------------------------------------------

--
-- Table structure for table `store_orderstatushistory`
--

CREATE TABLE `store_orderstatushistory` (
  `id` bigint(20) NOT NULL,
  `status` varchar(50) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `order_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store_orderstatushistory`
--

INSERT INTO `store_orderstatushistory` (`id`, `status`, `updated_at`, `order_id`) VALUES
(1, 'shipped', '2026-03-15 16:17:59.113628', 57),
(2, 'confirmed', '2026-03-15 16:20:15.109375', 57),
(3, 'shipped', '2026-03-15 16:20:24.744396', 57),
(4, 'cancelled', '2026-03-15 16:51:20.349777', 56),
(5, 'delivered', '2026-04-05 04:36:45.687089', 58),
(6, 'delivered', '2026-04-05 04:37:01.035577', 57),
(7, 'pending', '2026-04-05 13:00:19.165348', 68),
(8, 'pending', '2026-04-05 13:03:27.486847', 69),
(9, 'out_for_delivery', '2026-04-05 13:11:46.674093', 69),
(10, 'pending', '2026-04-05 13:16:49.221770', 70),
(11, 'out_for_delivery', '2026-04-05 13:17:48.112218', 70),
(12, 'shipped', '2026-04-05 13:22:10.049452', 70),
(13, 'out_for_delivery', '2026-04-05 13:24:07.071248', 70),
(14, 'cancelled', '2026-04-18 06:43:26.949528', 68);

-- --------------------------------------------------------

--
-- Table structure for table `store_product`
--

CREATE TABLE `store_product` (
  `unique_id` varchar(200) DEFAULT NULL,
  `id` bigint(20) NOT NULL,
  `image` varchar(300) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `description` longtext NOT NULL,
  `status` varchar(200) NOT NULL,
  `categories_id` bigint(20) NOT NULL,
  `filter_price_id` bigint(20) NOT NULL,
  `subcategories_id` bigint(20) NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `discount_percentage` decimal(5,2) NOT NULL,
  `is_deal_of_day` tinyint(1) NOT NULL,
  `offer_expiry` datetime(6) DEFAULT NULL,
  `stock` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store_product`
--

INSERT INTO `store_product` (`unique_id`, `id`, `image`, `name`, `price`, `description`, `status`, `categories_id`, `filter_price_id`, `subcategories_id`, `created_date`, `discount_percentage`, `is_deal_of_day`, `offer_expiry`, `stock`) VALUES
(NULL, 1, 'news/tele_eWTecKc.jpg', 'OnePlus 108 cm (43 inches) Y Series 4K Ultra HD Smart Android LED TV 43Y1S Pro (Black)', 22999.00, 'Screen Size 43 Inches Brand OnePlus Supported Internet Services Netflix, Prime Video, Zee5, Oxygen Play, Eros Now, JioCinema, SonyLiv, Youtube, Hungama, Hotstar Display Technology LED Product Dimensions 14.1D x 106W x 63H Centimeters Resolution 4K Refresh Rate 60 Hz Special Feature Browser Model Name 43 Y1S Pro Included Components 1 LED TV, 2 Table Stand Base, 1 User Manual, 1 Remote Control,1 AV IN Adapter, 1AC Cord, 2 AAA Battery1 LED TV, 2 Table Stand Base, 1 User Manual, 1 Remote Control,1 AV IN Adapter, 1AC Cord, 2 AAA Battery', 'PUBLISH', 4, 3, 10, '2024-03-18 15:11:09.000000', 50.00, 0, '2026-04-03 04:00:00.000000', 3),
(NULL, 2, 'news/coffe_wluvkIK.jpg', 'Pigeon by Stovekraft Amaze Plus Electric Kettle (14289) with Stainless Steel Body, 1.5 l', 599.00, 'Brand Pigeon Colour Silver, Balck Special Feature Indicator Light, Portable, Durable, Automatic Shut-Off Package Information Kettle Finish Type Shiny Product Dimensions 12L x 7W x 14H Centimeters Included Components 1 - Pigeon amaze electric kettle (1.5 Litre) Product Care Instructions Hand Wash and Dishwasher Safe Country/Region Of Origin India Country/Region of Origin India', 'PUBLISH', 1, 1, 3, '2024-03-18 15:12:07.000000', 0.00, 0, NULL, 2),
(NULL, 3, 'news/wa1_6W7XHYt.jpg', 'Phoenix', 1999.00, 'Fire-Boltt Phoenix round dial smartwatch features a 1.3” HD display, BT call, voice assistant, 100 sports modes, health suite, IP67, inbuilt games, smart notifications & other best-in-segment features.', 'PUBLISH', 5, 1, 13, '2024-03-18 15:14:17.000000', 20.00, 0, '2026-04-04 04:00:23.000000', 0),
(NULL, 4, 'news/sm1_6UTxw13.jpg', 'Gladiator', 1399.00, 'Shop for Fire-Boltt Gladiator smartwatch that comes with a 49.7mm (1.96\") HD large display, Bluetooth calling, 123 sports modes, voice assistant, and rotating crown metal body', 'PUBLISH', 5, 1, 13, '2024-03-18 15:16:01.000000', 0.00, 0, NULL, 0),
(NULL, 5, 'news/p1_UHVi7Bs.jpg', 'Apple iPhone 13 (128GB) - Starlight', 49499.00, '15 cm (6.1-inch) Super Retina XDR display\r\nCinematic mode adds shallow depth of field and shifts focus automatically in your videos\r\nAdvanced dual-camera system with 12MP Wide and Ultra Wide cameras; Photographic Styles, Smart HDR 4, Night mode, 4K Dolby Vision HDR recording\r\n12MP TrueDepth front camera with Night mode, 4K Dolby Vision HDR recording\r\nA15 Bionic chip for lightning-fast performance', 'PUBLISH', 6, 5, 16, '2024-03-18 15:17:13.000000', 0.00, 0, NULL, 3),
(NULL, 6, 'news/mo1.jpg', 'Apple iPhone 14 Plus (512 GB) - Blue', 96999.00, '16.95 cm (6.7-inch) Super Retina XDR display\r\nAdvanced camera system for better photos in any light\r\nCinematic mode now in 4K Dolby Vision up to 30 fps\r\nAction mode for smooth, steady, handheld videos\r\nVital safety technology — Crash Detection calls for help when you can’t\r\nAll-day battery life and up to 26 hours of video playback\r\nIndustry-leading durability features with Ceramic Shield and water resistance', 'PUBLISH', 6, 6, 16, '2024-03-18 15:19:48.000000', 0.00, 0, NULL, 2),
(NULL, 7, 'news/lap1.jpg', 'ASUS Vivobook 15, Intel Core i3-1220P 12th Gen, 15.6\" (39.62 cm) FHD, Thin and Laptop (8GB/512GB SSD', 38990.00, 'Processor: 12th Gen Intel Core i3-1220P Processor 1.1 GHz (12M Cache, up to 4.4 GHz, 10 cores)\r\nMemory: 8GB DDR4 on board 3200MHz with | Storage: 512GB M.2 NVMe PCIe 3.0 SSD\r\nDisplay: 15.6-inch (39.62cm), FHD (1920 x 1080) 16:9 aspect ratio, 220nits, 60Hz refresh rate, 45% NTSC color gamut, Anti-glare display\r\nGraphics: Integrated Intel UHD Graphics\r\nOperating System: Windows 11 Home with Lifetime validity | Software Included: Office Home and Student 2021 included with Lifetime validity\r\nDesign: 1.80 ~ 1.84 cm Thin | 1.70 kg weight | Thin and Light Laptop | 42WHrs, 3S1P, 3-cell Li-ion | Up to 6 hours battery life ;Note: Battery life depends on conditions of usage\r\nKeyboard: Chiclet Keyboard', 'PUBLISH', 4, 4, 19, '2024-03-18 15:22:06.000000', 0.00, 0, NULL, 0),
(NULL, 8, 'news/mic1.jpg', 'Philips HD6975/00 Digital Oven Toaster Grill, 25 Litre OTG, 1500 Watt with Opti Temp Technology, Cha', 8999.00, 'CAPACITY: 25 litres. POWER: 1500 watts; Operating Voltage: 220 - 240 volts. Frequency: 50/60 Hz\r\nOPTI TEMP TECHNOLOGY: Uniform cooking on all sides and even-browning in bread & cakes with No dark spots, perfect output\r\nONE TOUCH 10 PRESENT MENU with Pre-programmed time, temperature & heating element selection for these 10 preset modes to give expert results\r\n10 PRESENT MODES: Toast (7 browning levels), Bagel (7 browning levels), Pizza, Bake, Broil, Cookies, Roast, Grill, Tikka, Preheat\r\nPRE-HEAT MODE: Prepares the oven for perfect baking & cooking output and 90 MINUTES AUTO CUT- OFF\r\nMOTORISED ROTISSERIES function for perfect browning, RUST FREE ROTISSERIE ROD\r\nDOUBLE GLASS DOOR for Heat retention and safety and HEATING ELEMENTS TESTED for 600 hours of endurance', 'PUBLISH', 1, 1, 2, '2024-03-18 15:24:25.000000', 0.00, 0, NULL, 5),
(NULL, 9, 'news/b_LplCAEq.webp', 'boAt Rockerz 450 Bluetooth On Ear Headphones with Mic, Upto 15 Hours Playback, 40MM Drivers, Padded', 1499.00, 'Playback- It provides a massive battery backup of upto 15 hours for a superior playback time. Charging Time : 3 Hours\r\nDrivers- Its 40mm dynamic drivers help pump out immersive HD audio all day long.\r\nEarcushions- It has been ergonomically designed and structured as an on-ear headphone to provide the best user experience with its comfortable padded earcushions and lightweight design\r\nControls- You can control your music without hiccups using the easy access controls, communicate seamlessly using the built-in mic, access voice assistant and always stay in the zone\r\nDual Modes- One can connect to boAt Rockerz 450 via not one but two modes, Bluetooth as well as AUX', 'PUBLISH', 6, 5, 17, '2024-04-20 06:05:37.000000', 0.00, 0, NULL, 7),
(NULL, 10, 'news/e.jpg', 'boAt Airdopes 121v2 in-Ear True Wireless Earbuds with Upto 14 Hours Playback, 8MM Drivers, Battery I', 1299.00, 'Playback- Airdopes 121v2 offers a nonstop playback of up to 3.5H with each charge and an additional 10.5H playtime with the included charging case\r\nLightweight- With a dual tone finish on a lightweight ergonomic design weighing just around 4g per earbud, get ready to groove in full flow with Airdopes 121v2v2 TWS earbuds, Frequency - 20Hz-20KHz\r\nDrivers- It possesses powerful 8mm drivers that pump out immersive auditory experience all day long\r\nBattery Indicator- Its carry cum charge case also has the battery LED indicator that shows the remaining power for the case\r\nControls- The true wireless earbuds offer easy access multifunction button controls with stereo calling feature for an overall seamless user experience.\r\nBluetooth- These true wireless earbuds offer a true wireless experience for real time audio with Bluetooth v5.0.\r\nVoice Assistant- You can access the instant voice assistant via just a single press of the Multifunction Button\r\n1 year warranty from the date of purchase', 'PUBLISH', 6, 5, 17, '2024-04-20 06:09:45.000000', 0.00, 0, NULL, 10),
(NULL, 11, 'news/g.webp', 'Butterfly Rhino Plus Table Top Wet Grinder 2Litre, (Grey) 150W, 230V, AC 50Hz,Plastic', 4699.00, 'Aesthetically designed body and body made of high quality ABS material\r\nPortable and Convenient\r\nUniform grinding pressure\r\nDetachable stainless steel drum\r\nHygienic deliverable with easy to handle and clean', 'PUBLISH', 1, 1, 20, '2024-04-20 06:16:33.000000', 0.00, 0, NULL, 14),
(NULL, 12, 'news/c.jpg', 'Morphy Richards New Europa Coffee Making Machine|800W Espresso & Cappuccino Coffee Machine For Home|', 4499.00, 'Versatile Brewing: Enjoy a variety of coffee options with the ability to make espresso, cappuccino, and latte\r\nMilk Frothing Nozzle: Perfect for crafting specialty drinks like Latte, Espresso Macchiato, Caffè Breve, and Caramel Macchiato\r\nTurbo Cappuccino Nozzle: Specifically designed for achieving a rich froth in your favourite Cappuccino\r\nPowerful Performance: Boasts 800 watts of power and operates at 230 volts with a Bar Pressure of 4 bar\r\nConvenient Control: Features a function select knob for easy operation\r\nWarranty: Backed by a 2-year warranty on the product', 'PUBLISH', 1, 1, 20, '2024-04-20 06:17:14.000000', 0.00, 0, NULL, 5),
(NULL, 13, 'news/aa1.webp', 'Lloyd 1.2 Ton 5 Star Inverter Split AC (5 in 1 Convertible, 100% Copper, Anti-Viral + PM 2.5 Filter,', 34990.00, 'Lloyd Split AC with Inverter Compressor: AC with variable speed compressor which automatically adjusts power depending on room temperature & heat load. Convertible / adjustable with 5 cooling modes through remote control to operate in different tonnages for different cooling needs (30% to 110% capacity)\r\nCapacity: 1.2 ton suitable for medium size rooms up to 120 square feet\r\nEnergy Rating: 5 Star, Annual Energy Consumption: 635.62, ISEER Value: 5.11, please refer to energy label on the product page\r\nManufacturer Warranty: 1 Year on the product, 5 Years on Component (including PCB) and 10 Years on the Compressor, please refer to company website for further details\r\nGolden Fins Evaporator Coils: Ensures better cooling performance, require low maintenance and enhances durability of the product\r\nKey Features: Cools even at Ambient temperature of 52°C with 4 Way Air Swing, Stabilizer Free Operation within 100 - 300 voltage range; Hidden LED Display; Noise Level: IDU - 40 (DB)\r\nSpecial Features: 5 in 1 Convertible AC that Cools even @ 52°C temperature, Anti-Viral + PM 2.5 Air Filter, 7m Long Air Throw, Turbo Cool, Low Gas Detection, Clean Filter Indication, Installation Check, Auto Restart on power restoration', 'PUBLISH', 2, 4, 4, '2024-04-20 06:19:50.000000', 0.00, 0, NULL, 0),
(NULL, 14, 'news/f1.jpg', 'atomberg Aris Starlight 1200mm Ceiling Fans with Underlight, IoT and Remote Control | Smart Fan wit', 7999.00, 'INTEGRATED DESIGN: Atomberg Aris Starlight has an integrated ABS body. Aerodynamically designed ABS blades provide fantastic air delivery and are easy to clean. This is a noiseless fan and has an adjustable canopy design for easy mounting.\r\nUNDERLIGHT FEATURE: This fan comes with an underlight feature with 3 colour tones and varying intensities to upgrade the ambience of your room.\r\nENERGY EFFICIENT BLDC TECHNOLOGY: Atomberg Aris Starlight comes with an energy efficient BLDC motor. This fan has a high air delivery of 245 CMM at 280 RPM. The super-efficient 5-Star rated BLDC motor consumes just 39W at top speed.\r\nIoT ENABLED SMART FAN: Atomberg Aris Starlight comes with superior IoT features. You can control your fan via in-app voice commands through the Atomberg Home App. This smart fan can be accessed by both Wi-Fi & Bluetooth. It is also compatible with Alexa & Google Home devices.', 'PUBLISH', 2, 1, 5, '2024-04-20 06:21:47.000000', 0.00, 0, NULL, 3),
(NULL, 15, 'news/ff1.webp', 'atomberg Renesa 1200mm BLDC Motor 5 Star Rated Sleek Ceiling Fans with Remote | Upto 65% Energy Savi', 3799.00, 'Brand	atomberg\r\nColour	Midnight Black\r\nElectric fan design	Ceiling Fan\r\nPower Source	Corded Electric\r\nStyle	Modern\r\nProduct Dimensions	59D x 25W x 23H Centimeters', 'PUBLISH', 2, 5, 5, '2024-04-20 06:23:49.000000', 0.00, 0, NULL, 0),
(NULL, 16, 'news/a11.jpg', 'AIRTH Air Purifier For AC, Coated HEPA AC Filter, Proven Protection From PM2.5 PM10 Viruses and Alle', 2200.00, 'Colour	White\r\nBrand	AiRTH\r\nProduct Dimensions	22D x 69W x 5H Centimeters\r\nSpecification Met	HEPA\r\nParticle Retention Size	0.3 Micron\r\n	Power Source\r\nNo Power Required\r\n	Item Weight\r\n1.3 Kilograms\r\n	Control Method\r\nTouch\r\n	Filter Type\r\nHEPA', 'PUBLISH', 2, 3, 6, '2024-04-20 06:25:18.000000', 0.00, 0, NULL, 10),
(NULL, 28, 'news/q11.jpg', 'SKMEI Men\'s Watch New Wheels Rolling Creative Fashion Che Youhui League Fans Butterfly Double Snap G', 1799.00, 'Case diameter43 Millimetres\r\nBand colourMODEL D\r\nBand material typeStainless Steel\r\nWarranty typeManufacturer\r\nWatch movement typeJapanese Quartz\r\nCase thickness8.9 Centimetres\r\nCountry of OriginIndia\r\nAbout this item\r\nStylish Design for Guys: The SKMEI Men\'s Watch has a cool design inspired by car wheels, making it unique and fashionable.\r\nSpinning Dial: The watch has a special spinning dial that can rotate all the way around. It looks like the inside of a machine and is perfect for people who love cars.\r\nSuper Tough: This watch is made to last. It has a strong metal case and a special coating that won\'t fade. The glass on the front is 3D and adds a classy touch.', 'PUBLISH', 5, 5, 15, '2024-04-26 17:07:21.000000', 0.00, 0, NULL, 100),
(NULL, 30, '', 'Sony HT-S20R Real 5.1ch Dolby Digital Soundbar', 23000.00, 'Sony HT-S20R Real 5.1ch Dolby Digital Soundbar for TV with subwoofer and Compact Rear Speakers, 5.1ch Home Theatre System (400W,Bluetooth & USB Connectivity, HDMI & Optical connectivity)', 'PUBLISH', 4, 3, 11, '2026-04-17 16:28:50.799918', 33.00, 1, NULL, 15),
(NULL, 31, 'news/516HIUddM3L._SX679_.jpg', 'Google Pixel 10 5G (Obsidian, 12GB RAM, 256GB Storage)', 70000.00, 'Brand	Google\r\nOperating System	ANDROID 16\r\nRAM Memory Installed Size	12 GB\r\nCPU Model	Google Tensor\r\nMemory Storage Capacity	256 GB\r\n\r\n\r\nGoogle Pixel 10 is the everyday phone unlike anything else; it has Google Tensor G5, Pixel’s most powerful chip, an incredible camera, and advanced AI - Gemini built in.\r\nThe upgraded triple rear camera system has a new 5x telephoto lens - up to 20x Super Res Zoom for stunning detail from far away; Night Sight takes crisp, clear photos in low-light settings; and Camera Coach helps you snap your best pics.', 'PUBLISH', 6, 6, 16, '2026-04-17 16:35:15.715702', 13.00, 1, '2026-04-29 22:04:00.000000', 5),
(NULL, 32, 'news/41PQiSgI9gL._SX342_SY445_QL70_FMwebp_.webp', 'Godrej Smart Choice 7 Kg 5 Star, AI Tech, Fabrisafe Steel Drum, Magic Lint Filter, Fills Tub At ~0 W', 25000.00, 'Product Dimensions	56.5D x 56.5W x 93.2H Centimeters\r\nBrand	Godrej\r\nCapacity	7 Kilograms\r\nSpecial Feature	3 Digit LED Display, Cycle End buzzer, Unbalance Sensor, Zero pressure technology, fabrisafe Drum\r\nAccess Location	Top Load\r\nAbout this item\r\nFully-automatic top load washing machine with Tidal Wash Technology: Acu Wash Drum\'s contours provides low & high tide effect, accurately scrubbing the clothes & the Turbo 6 Pulsator has 6 ridges that create water motions inside the tub for better penetration of detergent and easy dirt removal. Product color might slightly vary due to photographic lighting sources or your monitor settings\r\nCapacity 7 kg: Suitable for 3 – 4 members', 'PUBLISH', 3, 3, 8, '2026-04-17 16:40:37.267446', 40.00, 1, '2026-04-27 22:10:00.000000', 8),
(NULL, 33, 'news/419LNPjar6L._SX342_SY445_QL70_FMwebp_.webp', 'LG 7 Kg 5 Star Smart Inverter Technology Fully Automatic Top Load Washing Machine (T70VBMB1Z, Auto P', 18000.00, 'Product Dimensions	56D x 54W x 88.5H Centimeters\r\nBrand	LG\r\nCapacity	7 Kilograms\r\nSpecial Feature	Auto Restart, Child Lock, High Efficiency, Inverter, LED Display\r\nAccess Location	Top Load\r\nAbout this item\r\nFully-automatic top load washing machine with Inverter Motor and Smart wash technology: Affordable with great wash quality, Easy to use; Has both washing and drying functions\r\nCapacity 7.0 Kg: Suitable for 3 – 4 members', 'PUBLISH', 3, 2, 8, '2026-04-17 16:43:14.364058', 0.00, 1, NULL, 5),
(NULL, 34, 'news/51nBTTG3hNL._SX679_.jpg', 'OnePlus Nord Buds 3r TWS Earbuds up to 54 Hours Playback, 2-mic Clear Calls, 3D Spatial Audio, AI Tr', 20000.00, 'Brand	OnePlus\r\nColour	Ash Black\r\nEar Placement	On Ear\r\nForm Factor	In Ear\r\nImpedance	32 Ohms\r\nAbout this item\r\n[Our longest battery ever, up to 54 hrs Music Playback]: A full charge Nord Buds 3r gives upto 54 hours of music playback. 10 minutes of fast charging gives 8 hours of music.\r\n[Titanium-coated Drivers]: The Nord buds 3r comes with 12.4 mm Titanium-coated Drivers to enjoy deeper bass and powerful beats resulting in crystal - clear details in every note. It has fixed spatial audio specifically for OnePlus smartphone users.', 'PUBLISH', 4, 1, 17, '2026-04-17 16:53:49.179031', 10.00, 1, '2026-04-21 22:23:00.000000', 10),
(NULL, 35, 'news/31oNucpTJAL._SY300_SX300_QL70_FMwebp_.webp', 'Havells Glace Plus 1000 Watts Dry Iron Press| 2X Non Stick Greblon Coating from Germany| 2X ISI Cert', 2000.00, 'Brand	Havells\r\nSpecial Feature	Temperature Control\r\nColour	Royal Blue\r\nWattage	1000 Watts\r\nProduct Dimensions	25L x 10W Centimeters\r\nAbout this item\r\nStable & Efficient Performance- Heavy-duty construction ensures smooth and consistent ironing performance for all types of garments.\r\nQuick Heat-Up - 1000W Iron delivers powerful and consistent heat for fast and efficient ironing—no more waiting around!', 'PUBLISH', 3, 1, 9, '2026-04-17 17:47:11.832378', 0.00, 0, NULL, 5),
(NULL, 36, 'news/51yW87aqMQL.jpg', 'OWNAIR Steamer for Ironing Clothes - 1500W Handheld Garment Steamer - 24g/min High Steam, Fast Heat-', 2500.00, 'Brand	OWNAIR\r\nColour	Blue\r\nProduct Dimensions	8L x 21W x 19H Centimeters\r\nItem Weight	750 Grams\r\nStyle	TURBO\r\nAbout this item\r\n???????????????????????????????????????? ???????????????????????????? ????????????????: To ensure nationwide support, we provide a live video demo instead of a physical demo. Our team guides you through product usage and care. Contact Own Air Customer Support to book your virtual demo at a time that suits you.\r\n???????????????????????????????????????? ???????????????????????????? ????????????????????????????:- This garment steamer for clothes is designed for quick wrinkle removal and freshening up outfits. Instantly transform your clothes without the hassle of a traditional steam iron for clothes.', 'PUBLISH', 3, 1, 9, '2026-04-17 17:48:55.670909', 0.00, 0, NULL, 3);

-- --------------------------------------------------------

--
-- Table structure for table `store_review`
--

CREATE TABLE `store_review` (
  `id` bigint(20) NOT NULL,
  `rating` int(11) NOT NULL,
  `comment` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `image` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store_review`
--

INSERT INTO `store_review` (`id`, `rating`, `comment`, `created_at`, `product_id`, `user_id`, `image`) VALUES
(1, 4, 'Nice Phone', '2026-03-15 14:22:28.763552', 6, 2, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `store_subcategories`
--

CREATE TABLE `store_subcategories` (
  `id` bigint(20) NOT NULL,
  `name` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store_subcategories`
--

INSERT INTO `store_subcategories` (`id`, `name`) VALUES
(2, 'Microwave Ovens'),
(3, 'Coffee Makers'),
(4, 'Air Conditioners'),
(5, 'Fans'),
(6, 'Air Purifiers'),
(7, 'Laundry Appliances'),
(8, 'Washing Machines'),
(9, 'Irons'),
(10, 'Televisions'),
(11, 'Home Theater Systems'),
(12, 'Gaming Consoles'),
(13, 'Smartwatches'),
(14, 'Fitness Trackers'),
(15, 'Traditional Watches'),
(16, 'Mobiles'),
(17, 'Headphones/Earphones'),
(18, 'Bluetooth Speakers'),
(19, 'Laptop'),
(20, 'Grinder');

-- --------------------------------------------------------

--
-- Table structure for table `store_useractivity`
--

CREATE TABLE `store_useractivity` (
  `id` bigint(20) NOT NULL,
  `session_key` varchar(40) DEFAULT NULL,
  `viewed_at` datetime(6) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store_useractivity`
--

INSERT INTO `store_useractivity` (`id`, `session_key`, `viewed_at`, `product_id`, `user_id`) VALUES
(1, 'kbdu26j645382zvzjnpa412h6mwzz54i', '2026-04-05 12:37:54.531103', 10, 1),
(2, 'kbdu26j645382zvzjnpa412h6mwzz54i', '2026-04-05 12:39:54.336518', 10, 1),
(3, 'kbdu26j645382zvzjnpa412h6mwzz54i', '2026-04-05 12:41:05.398904', 10, 1),
(4, 'kbdu26j645382zvzjnpa412h6mwzz54i', '2026-04-05 12:42:00.511961', 10, 1),
(5, 'kbdu26j645382zvzjnpa412h6mwzz54i', '2026-04-06 04:51:47.093002', 2, 1),
(6, 'kbdu26j645382zvzjnpa412h6mwzz54i', '2026-04-17 16:29:36.330760', 30, 1),
(7, 'kbdu26j645382zvzjnpa412h6mwzz54i', '2026-04-17 16:36:40.618083', 31, 1),
(8, 'kbdu26j645382zvzjnpa412h6mwzz54i', '2026-04-17 16:36:47.714375', 31, 1),
(9, 'kbdu26j645382zvzjnpa412h6mwzz54i', '2026-04-17 16:37:42.309518', 31, 1),
(10, 'hqtq9z8jde7lcmt43x7dh60mslvo1p9q', '2026-04-17 17:52:37.479972', 1, 1),
(11, 'hqtq9z8jde7lcmt43x7dh60mslvo1p9q', '2026-04-17 17:52:56.755039', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `store_wishlist`
--

CREATE TABLE `store_wishlist` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store_wishlist`
--

INSERT INTO `store_wishlist` (`id`, `created_at`, `product_id`, `user_id`) VALUES
(1, '2026-03-15 14:32:30.243206', 6, 2),
(2, '2026-03-15 14:40:08.123325', 2, 2),
(4, '2026-03-16 07:35:32.505447', 3, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `profile`
--
ALTER TABLE `profile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `store_categories`
--
ALTER TABLE `store_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `store_contact_us`
--
ALTER TABLE `store_contact_us`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `store_coupon`
--
ALTER TABLE `store_coupon`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `store_emailotp`
--
ALTER TABLE `store_emailotp`
  ADD PRIMARY KEY (`id`),
  ADD KEY `store_emailotp_user_id_b378efba_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `store_filter_price`
--
ALTER TABLE `store_filter_price`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `store_images`
--
ALTER TABLE `store_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `store_images_product_id_b2f0d742_fk_store_product_id` (`product_id`);

--
-- Indexes for table `store_order`
--
ALTER TABLE `store_order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `store_order_user_id_ae5f7a5f_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `store_orderitem`
--
ALTER TABLE `store_orderitem`
  ADD PRIMARY KEY (`id`),
  ADD KEY `store_orderitem_order_id_acf8722d_fk_store_order_id` (`order_id`);

--
-- Indexes for table `store_orderstatushistory`
--
ALTER TABLE `store_orderstatushistory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `store_orderstatushistory_order_id_604f3e66_fk_store_order_id` (`order_id`);

--
-- Indexes for table `store_product`
--
ALTER TABLE `store_product`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_id` (`unique_id`),
  ADD KEY `store_product_categories_id_068339d7_fk_store_categories_id` (`categories_id`),
  ADD KEY `store_product_filter_price_id_0eeac842_fk_store_filter_price_id` (`filter_price_id`),
  ADD KEY `store_product_subcategories_id_9c740e4f_fk_store_sub` (`subcategories_id`);

--
-- Indexes for table `store_review`
--
ALTER TABLE `store_review`
  ADD PRIMARY KEY (`id`),
  ADD KEY `store_review_product_id_abc413b2_fk_store_product_id` (`product_id`),
  ADD KEY `store_review_user_id_cc54d86d_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `store_subcategories`
--
ALTER TABLE `store_subcategories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `store_useractivity`
--
ALTER TABLE `store_useractivity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `store_useractivity_product_id_b6d48641_fk_store_product_id` (`product_id`),
  ADD KEY `store_useractivity_user_id_2692ed8a_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `store_wishlist`
--
ALTER TABLE `store_wishlist`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `store_wishlist_user_id_product_id_bcc1ac25_uniq` (`user_id`,`product_id`),
  ADD KEY `store_wishlist_product_id_8af1333d_fk_store_product_id` (`product_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `profile`
--
ALTER TABLE `profile`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `store_categories`
--
ALTER TABLE `store_categories`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `store_contact_us`
--
ALTER TABLE `store_contact_us`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `store_coupon`
--
ALTER TABLE `store_coupon`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `store_emailotp`
--
ALTER TABLE `store_emailotp`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `store_filter_price`
--
ALTER TABLE `store_filter_price`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `store_images`
--
ALTER TABLE `store_images`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT for table `store_order`
--
ALTER TABLE `store_order`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `store_orderitem`
--
ALTER TABLE `store_orderitem`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `store_orderstatushistory`
--
ALTER TABLE `store_orderstatushistory`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `store_product`
--
ALTER TABLE `store_product`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `store_review`
--
ALTER TABLE `store_review`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `store_subcategories`
--
ALTER TABLE `store_subcategories`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `store_useractivity`
--
ALTER TABLE `store_useractivity`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `store_wishlist`
--
ALTER TABLE `store_wishlist`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `profile`
--
ALTER TABLE `profile`
  ADD CONSTRAINT `profile_user_id_2aeb6f6b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `store_emailotp`
--
ALTER TABLE `store_emailotp`
  ADD CONSTRAINT `store_emailotp_user_id_b378efba_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `store_images`
--
ALTER TABLE `store_images`
  ADD CONSTRAINT `store_images_product_id_b2f0d742_fk_store_product_id` FOREIGN KEY (`product_id`) REFERENCES `store_product` (`id`);

--
-- Constraints for table `store_order`
--
ALTER TABLE `store_order`
  ADD CONSTRAINT `store_order_user_id_ae5f7a5f_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `store_orderitem`
--
ALTER TABLE `store_orderitem`
  ADD CONSTRAINT `store_orderitem_order_id_acf8722d_fk_store_order_id` FOREIGN KEY (`order_id`) REFERENCES `store_order` (`id`);

--
-- Constraints for table `store_orderstatushistory`
--
ALTER TABLE `store_orderstatushistory`
  ADD CONSTRAINT `store_orderstatushistory_order_id_604f3e66_fk_store_order_id` FOREIGN KEY (`order_id`) REFERENCES `store_order` (`id`);

--
-- Constraints for table `store_product`
--
ALTER TABLE `store_product`
  ADD CONSTRAINT `store_product_categories_id_068339d7_fk_store_categories_id` FOREIGN KEY (`categories_id`) REFERENCES `store_categories` (`id`),
  ADD CONSTRAINT `store_product_filter_price_id_0eeac842_fk_store_filter_price_id` FOREIGN KEY (`filter_price_id`) REFERENCES `store_filter_price` (`id`),
  ADD CONSTRAINT `store_product_subcategories_id_9c740e4f_fk_store_sub` FOREIGN KEY (`subcategories_id`) REFERENCES `store_subcategories` (`id`);

--
-- Constraints for table `store_review`
--
ALTER TABLE `store_review`
  ADD CONSTRAINT `store_review_product_id_abc413b2_fk_store_product_id` FOREIGN KEY (`product_id`) REFERENCES `store_product` (`id`),
  ADD CONSTRAINT `store_review_user_id_cc54d86d_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `store_useractivity`
--
ALTER TABLE `store_useractivity`
  ADD CONSTRAINT `store_useractivity_product_id_b6d48641_fk_store_product_id` FOREIGN KEY (`product_id`) REFERENCES `store_product` (`id`),
  ADD CONSTRAINT `store_useractivity_user_id_2692ed8a_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `store_wishlist`
--
ALTER TABLE `store_wishlist`
  ADD CONSTRAINT `store_wishlist_product_id_8af1333d_fk_store_product_id` FOREIGN KEY (`product_id`) REFERENCES `store_product` (`id`),
  ADD CONSTRAINT `store_wishlist_user_id_afcc4e88_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
