-- phpMyAdmin SQL Dump
-- version 4.4.13
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Aug 08, 2015 at 06:35 PM
-- Server version: 5.6.24
-- PHP Version: 5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `up_and_running`
--
CREATE DATABASE IF NOT EXISTS `up_and_running` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `up_and_running`;

-- --------------------------------------------------------

--
-- Table structure for table `cars`
--

CREATE TABLE IF NOT EXISTS `cars` (
  `car_id` int(10) unsigned NOT NULL,
  `make_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `yearmade` year(4) NOT NULL,
  `mileage` mediumint(8) unsigned NOT NULL,
  `transmission` enum('manual','automatic') NOT NULL DEFAULT 'automatic',
  `price` decimal(8,2) NOT NULL,
  `description` text
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cars`
--

INSERT INTO `cars` (`car_id`, `make_id`, `yearmade`, `mileage`, `transmission`, `price`, `description`) VALUES
(1, 5, 2007, 113688, 'automatic', '13545.00', 'Green Chrysler 300. Only one owner, very carefully maintained. Top of the line, and beautifully styled, this is an outstanding ride with great performance.'),
(2, 2, 2007, 126570, 'automatic', '7540.00', 'Red Ford Focus. Great bargain as a family car.'),
(3, 12, 2012, 517, 'automatic', '20750.00', 'Demo model that''s hardly been out on the road, this red Chevrolet Cruze is just a dream, with just about every option you could ask for. Great fuel economy, too.'),
(4, 16, 2010, 116626, 'automatic', '10549.00', 'Red Camry in good running condition. Sound electrics and bodywork. Clean interior, appears never to have been smoked in.'),
(5, 7, 2011, 124694, 'automatic', '26946.00', 'Space grey BMW 3 series with beige leather interior. BMW Factory Certified with a 6 year/100,000 mile warranty from in-service date.'),
(6, 11, 2005, 95496, 'automatic', '8549.00', 'Black Jaguar S-Type in perfect working condition. Good electrics and bodywork. Low mileage. New tires recently fitted.'),
(7, 5, 2004, 75500, 'automatic', '6000.00', 'Black Sebring LX convertible. Very low mileage. Excellent ride. A must-see bargain.'),
(8, 4, 2001, 100145, 'automatic', '9545.00', 'Black SLK-Class convertible. Immaculate interior. Power top and power seats. Runs like new.'),
(9, 2, 1999, 102500, 'automatic', '4545.00', 'Metallic red Mustang convertible. Economy car, very easy on fuel. No negative history. No rust or damage on paintwork.'),
(10, 16, 2002, 173658, 'automatic', '6545.00', 'So much to like about this Silver Toyota 4Runner. Runs well, good paint, tires, nice sound system.'),
(11, 3, 2005, 122250, 'automatic', '11545.00', 'Black Cadillac SRX. Only one owner. Beautiful SUV.'),
(12, 17, 2002, 155500, 'automatic', '4300.00', 'Silver Passat. Only one owner. Leather interior. Rare bargain.'),
(13, 1, 1952, 46383, 'manual', '22050.00', 'Burgundy Studebaker Roadster with newly rebuilt engine and wide whitewall tires. Three-speed manual transmission. Runs and drives amazingly.'),
(14, 10, 2006, 124209, 'automatic', '9115.00', 'White Santa Fe. Only one owner. Leather interior and bodywork are in great shape.'),
(15, 10, 2012, 9811, 'automatic', '24549.00', 'Silver Genesis with beige leather and wood trim interior. Great handling and comfort. Low, low mileage. Luxury at an affordable price.'),
(16, 14, 2005, 130500, 'manual', '7500.00', 'Five-speed manual black Civic. Super clean, with 6 CD changer. This one, you must see!'),
(17, 15, 2007, 84947, 'automatic', '14549.00', 'Audi A4 Quattro. Gray with gray leather interior, and glass roof. Excellent value.'),
(18, 6, 1972, 77600, 'manual', '28050.00', 'Citroen D Super with 5 speed manual transmission in fantastic shape. Extremely well maintained, and has obviously been treasured by its owner. A real European classic.'),
(19, 8, 2012, 19361, 'automatic', '14548.00', 'Yellow Fiat 500 POP. Immaculate interior and bodywork. Electrics in perfect order. Tires only slightly worn.'),
(20, 12, 2002, 160550, 'automatic', '4540.00', 'Blue Impala LS with gray interior. Ideal economical vehicle with good gas mileage. Dependable engine, new tires. Price includes 6 month/8,500 mile warranty.'),
(21, 9, 2005, 94995, 'automatic', '8145.00', 'Gold Pontiac Bonneville with low mileage. Great condition.'),
(22, 5, 2006, 102300, 'automatic', '7100.00', 'Green Town & Country sports van.'),
(23, 8, 2012, 5238, 'automatic', '16045.00', 'Pearl white Fiat 500 sport hatchback. Power glass sunroof and power windows. Only one owner.'),
(24, 17, 2005, 70388, 'automatic', '14050.00', 'Shadow blue Touareg in excellent condition. Heated leather seats, sun roof, and navigation. Really low mileage. '),
(25, 13, 2012, 35000, 'automatic', '15545.00', 'Tan Altima. Low mileage. Excellent condition.'),
(26, 2, 2004, 108694, 'automatic', '10975.00', 'Top of the line black Expedition XLT 5.4 liter 4WD with every conceivable option. A truly exceptional SUV.'),
(27, 2, 2005, 123059, 'automatic', '7995.00', 'Blue Ford Escape. Excellent condition. A real bargain.'),
(28, 13, 2010, 32791, 'automatic', '20500.00', 'Red Pathfinder 4WD. Only one owner. Nicely equipped with just about every feature you could want, including third-row seats.'),
(29, 14, 2002, 124334, 'automatic', '5999.00', 'Silver Accord with sunroof, CD player, and all new tires. Excellent condition.'),
(30, 14, 2011, 27345, 'automatic', '13995.00', 'Dark gray Civic. Only one owner, very low mileage. Great fuel economy.'),
(31, 12, 2011, 34256, 'automatic', '11995.00', 'Dark gray Malibu. Interior and bodywork in good condition. Low mileage.'),
(32, 15, 2003, 93494, 'automatic', '9995.00', 'Silver Audi A6 with tan interior. Two previous owners. Mechanically sound and good bodywork. New tires.'),
(33, 3, 2005, 139534, 'automatic', '11500.00', 'Pearl white Cadillac SRX. Electrics, engine, and bodywork all in excellent condition. Only one owner. Tires have about 3/4 of their life span left.'),
(34, 7, 2011, 33784, 'automatic', '25899.00', 'White 3 Series 328i. Low mileage. Bodywork in mint condition. AM/FM stereo, trip computer, power sunroof.'),
(35, 5, 2012, 7834, 'automatic', '16555.00', 'White Chrysler 200 with black interior. Exceptionally low mileage ');

-- --------------------------------------------------------

--
-- Table structure for table `makes`
--

CREATE TABLE IF NOT EXISTS `makes` (
  `make_id` smallint(5) unsigned NOT NULL,
  `make` varchar(30) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `makes`
--

INSERT INTO `makes` (`make_id`, `make`) VALUES
(1, 'Studebaker'),
(2, 'Ford'),
(3, 'Cadillac'),
(4, 'Mercedes Benz'),
(5, 'Chrysler'),
(6, 'Citroen'),
(7, 'BMW'),
(8, 'Fiat'),
(9, 'Pontiac'),
(10, 'Hyundai'),
(11, 'Jaguar'),
(12, 'Chevrolet'),
(13, 'Nissan'),
(14, 'Honda'),
(15, 'Audi'),
(16, 'Toyota'),
(17, 'Volkswagen');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cars`
--
ALTER TABLE `cars`
  ADD PRIMARY KEY (`car_id`),
  ADD KEY `yearmade` (`yearmade`),
  ADD KEY `make_id` (`make_id`);

--
-- Indexes for table `makes`
--
ALTER TABLE `makes`
  ADD PRIMARY KEY (`make_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cars`
--
ALTER TABLE `cars`
  MODIFY `car_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=36;
--
-- AUTO_INCREMENT for table `makes`
--
ALTER TABLE `makes`
  MODIFY `make_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=18;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
