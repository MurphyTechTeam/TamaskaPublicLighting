-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 31 Bulan Mei 2022 pada 07.42
-- Versi server: 10.4.14-MariaDB
-- Versi PHP: 7.2.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tamaskapju`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `data_kawasan`
--

CREATE TABLE `data_kawasan` (
  `id_dataK` int(11) NOT NULL,
  `id_kawasan` int(11) NOT NULL,
  `no_device` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `data_kawasan`
--

INSERT INTO `data_kawasan` (`id_dataK`, `id_kawasan`, `no_device`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 3),
(4, 2, 4),
(5, 1, 5),
(6, 1, 6),
(7, 3, 7),
(8, 3, 8);

-- --------------------------------------------------------

--
-- Struktur dari tabel `devices`
--

CREATE TABLE `devices` (
  `no_device` int(11) NOT NULL,
  `id_device` varchar(200) DEFAULT NULL,
  `energy` float DEFAULT NULL,
  `power` float DEFAULT NULL,
  `voltage` float DEFAULT NULL,
  `ampere` float DEFAULT NULL,
  `powerF` float DEFAULT NULL,
  `LightSensor` float DEFAULT NULL,
  `battery` float DEFAULT NULL,
  `relay_status` int(5) DEFAULT NULL,
  `brightness` float DEFAULT NULL,
  `device_time` datetime DEFAULT current_timestamp(),
  `alarm_type` int(11) NOT NULL DEFAULT 1,
  `device_registered` datetime NOT NULL DEFAULT current_timestamp(),
  `restart_status` int(11) NOT NULL DEFAULT 2,
  `blue_status` int(11) NOT NULL DEFAULT 0,
  `lamp_treshold` float NOT NULL,
  `latitude` varchar(500) NOT NULL,
  `longitude` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `devices`
--

INSERT INTO `devices` (`no_device`, `id_device`, `energy`, `power`, `voltage`, `ampere`, `powerF`, `LightSensor`, `battery`, `relay_status`, `brightness`, `device_time`, `alarm_type`, `device_registered`, `restart_status`, `blue_status`, `lamp_treshold`, `latitude`, `longitude`) VALUES
(1, '/antares-cse/cnt-uoJ8bqJdQ-6874Gl', 9.0876, 1, 224, 0, 0, 8190, 4.47, 1, 65, '2022-04-26 20:36:50', 7, '2022-04-26 11:02:14', 0, 0, 3, '', ''),
(2, '/antares-cse/demo1', 9.0876, 1, 224, 0, 0, 8190, 4.47, 0, 65, '2022-04-26 20:36:50', 7, '2022-04-26 11:02:14', 0, 0, 3, '', ''),
(3, '/antares-cse/demo2', 9.0876, 1, 224, 0, 0, 8190, 4.47, 2, 65, '2022-04-26 20:36:50', 7, '2022-04-26 11:02:14', 0, 0, 3, '', ''),
(4, '/antares-cse/demo3', 9.0876, 1, 224, 0, 0, 8190, 4.47, 3, 65, '2022-04-26 20:36:50', 7, '2022-04-26 11:02:14', 0, 0, 3, '', ''),
(5, '/antares-cse/demo4', 9.0876, 1, 224, 0, 0, 8190, 4.47, 0, 65, '2022-04-26 20:36:50', 7, '2022-04-26 11:02:14', 0, 0, 3, '', ''),
(6, '/antares-cse/demo5', 9.0876, 1, 224, 0, 0, 8190, 4.47, 1, 65, '2022-04-26 20:36:50', 7, '2022-04-26 11:02:14', 0, 0, 3, '', ''),
(7, '/antares-cse/demo6', 9.0876, 1, 224, 0, 0, 8190, 4.47, 2, 65, '2022-04-26 20:36:50', 7, '2022-04-26 11:02:14', 0, 0, 3, '', ''),
(8, '/antares-cse/demo7', 9.0876, 1, 224, 0, 0, 8190, 4.47, 2, 65, '2022-04-26 20:36:50', 7, '2022-04-26 11:02:14', 0, 0, 3, '', '');

-- --------------------------------------------------------

--
-- Struktur dari tabel `device_conf`
--

CREATE TABLE `device_conf` (
  `id_conf` int(11) NOT NULL,
  `id_device` varchar(200) NOT NULL,
  `houron_hour` int(50) NOT NULL DEFAULT 0,
  `minon_hour` int(50) NOT NULL DEFAULT 0,
  `houroff_hour` int(50) NOT NULL DEFAULT 0,
  `houron_min` int(50) NOT NULL DEFAULT 0,
  `interval_loop` int(50) NOT NULL DEFAULT 0,
  `interval_send` int(50) NOT NULL DEFAULT 0,
  `mode` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `device_conf`
--

INSERT INTO `device_conf` (`id_conf`, `id_device`, `houron_hour`, `minon_hour`, `houroff_hour`, `houron_min`, `interval_loop`, `interval_send`, `mode`) VALUES
(1, '/antares-cse/cnt-uoJ8bqJdQ-6874Gl ', 1, 10, 2, 2, 1, 1, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `history`
--

CREATE TABLE `history` (
  `id_history` int(11) NOT NULL,
  `id_device` varchar(200) NOT NULL,
  `energy` float DEFAULT NULL,
  `power` float DEFAULT NULL,
  `voltage` float DEFAULT NULL,
  `ampere` float DEFAULT NULL,
  `powerF` float DEFAULT NULL,
  `LightSensor` float DEFAULT NULL,
  `battery` float DEFAULT NULL,
  `relay_status` int(5) DEFAULT NULL,
  `brightness` float DEFAULT NULL,
  `device_time` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `history`
--

INSERT INTO `history` (`id_history`, `id_device`, `energy`, `power`, `voltage`, `ampere`, `powerF`, `LightSensor`, `battery`, `relay_status`, `brightness`, `device_time`) VALUES
(1, '/antares-cse/cnt-uoJ8bqJdQ-6874Gl', 9.0252, 42, 225, 0.17, 1, 5376, 4.07, 1, 65, '2022-04-26 11:19:59'),
(2, '/antares-cse/cnt-uoJ8bqJdQ-6874Gl', 9.068, 42, 225, 0.17, 1, 3492, 4.15, 1, 65, '2022-04-26 12:20:02'),
(3, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.068, 42, 225, 0.17, 1, 3492, 4.15, 1, 65, '2022-04-26 12:20:02'),
(4, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.068, 42, 225, 0.17, 1, 3492, 4.15, 1, 65, '2022-04-26 12:20:02'),
(5, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.068, 42, 225, 0.17, 1, 3492, 4.15, 1, 65, '2022-04-26 12:20:02'),
(6, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.068, 42, 225, 0.17, 1, 3492, 4.15, 1, 65, '2022-04-26 12:20:02'),
(7, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.068, 42, 225, 0.17, 1, 3492, 4.15, 1, 65, '2022-04-26 12:20:02'),
(8, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.068, 42, 225, 0.17, 1, 3492, 4.15, 1, 65, '2022-04-26 12:20:02'),
(9, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.068, 42, 225, 0.17, 1, 3492, 4.15, 1, 65, '2022-04-26 12:20:02'),
(10, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.068, 42, 225, 0.17, 1, 3492, 4.15, 1, 65, '2022-04-26 12:20:02'),
(11, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.068, 42, 225, 0.17, 1, 3492, 4.15, 1, 65, '2022-04-26 12:20:02'),
(12, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.068, 42, 225, 0.17, 1, 3492, 4.15, 1, 65, '2022-04-26 12:20:02'),
(13, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.068, 42, 225, 0.17, 1, 3492, 4.15, 1, 65, '2022-04-26 12:20:02'),
(14, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.068, 42, 225, 0.17, 1, 3492, 4.15, 1, 65, '2022-04-26 12:20:02'),
(15, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.068, 42, 225, 0.17, 1, 3492, 4.15, 1, 65, '2022-04-26 12:20:02'),
(16, '/antares-cse/cnt-uoJ8bqJdQ-6874Gl', 9.068, 42, 225, 0.17, 1, 3492, 4.15, 1, 65, '2022-04-26 12:20:02'),
(17, '/antares-cse/cnt-uoJ8bqJdQ-6874Gl', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(18, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(19, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(20, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(21, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(22, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(23, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(24, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(25, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(26, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(27, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(28, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(29, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(30, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(31, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(32, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(33, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(34, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(35, '/antares-cse/cnt-uoJ8bqJdQ-6874Gl', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(36, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(37, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(38, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(39, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(40, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(41, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(42, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(43, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(44, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(45, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(46, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(47, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(48, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(49, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(50, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(51, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(52, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 1688, 4.09, 0, 65, '2022-04-26 13:32:15'),
(53, '/antares-cse/cnt-uoJ8bqJdQ-6874Gl', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(54, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(55, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(56, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(57, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(58, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(59, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(60, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(61, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(62, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(63, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(64, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(65, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(66, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(67, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(68, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(69, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(70, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(71, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(72, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(73, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(74, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(75, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(76, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(77, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(78, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(79, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(80, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(81, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(82, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(83, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(84, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(85, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(86, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(87, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(88, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(89, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(90, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(91, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(92, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(93, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(94, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(95, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(96, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(97, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(98, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(99, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(100, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(101, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(102, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(103, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(104, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(105, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(106, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(107, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(108, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(109, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(110, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(111, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(112, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(113, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(114, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(115, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(116, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(117, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(118, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(119, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(120, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(121, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(122, '/antares-cse/cnt-uoJ8bqJdQ-6874Gl', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(123, '/antares-cse/cnt-uoJ8bqJdQ-6874Gl', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(124, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(125, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(126, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(127, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(128, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(129, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(130, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(131, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(132, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(133, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(134, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(135, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(136, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(137, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(138, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(139, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(140, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(141, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(142, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(143, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(144, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(145, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(146, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(147, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(148, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(149, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(150, '/antares-cse/cnt-uoJ8bqJdQ-6874Gl', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(151, '/antares-cse/cnt-uoJ8bqJdQ-6874Gl', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(152, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(153, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(154, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(155, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(156, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(157, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(158, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(159, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(160, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(161, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(162, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(163, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(164, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(165, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(166, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(167, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(168, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(169, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(170, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(171, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(172, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(173, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(174, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(175, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(176, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(177, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(178, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(179, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(180, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(181, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(182, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(183, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(184, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(185, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(186, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(187, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(188, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(189, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(190, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(191, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(192, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(193, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(194, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(195, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(196, '/antares-cse/cnt-uoJ8bqJdQ-6874Gl', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(197, '/antares-cse/cnt-uoJ8bqJdQ-6874Gl', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(198, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(199, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(200, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(201, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(202, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(203, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(204, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(205, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(206, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(207, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(208, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(209, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(210, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.1, 0, 65, '2022-04-26 14:47:39'),
(211, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 0, 4.17, 0, 65, '2022-04-26 15:47:43'),
(212, '/antares-cse/cnt-uoJ8bqJdQ-6874Gl', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(213, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(214, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(215, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(216, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(217, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(218, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(219, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(220, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(221, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(222, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(223, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(224, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(225, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(226, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(227, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(228, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(229, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(230, '/antares-cse/cnt-uoJ8bqJdQ-6874Gl', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(231, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(232, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(233, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(234, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(235, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(236, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(237, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(238, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(239, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(240, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(241, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(242, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(243, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(244, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(245, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(246, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(247, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(248, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(249, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(250, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(251, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(252, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(253, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(254, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(255, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(256, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(257, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(258, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(259, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(260, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(261, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(262, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(263, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(264, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(265, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(266, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(267, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(268, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(269, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(270, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(271, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(272, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 225, 0, 0, 8190, 4.25, 0, 65, '2022-04-26 17:20:44'),
(273, '/antares-cse/cnt-uoJ8bqJdQ-6874Gl', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(274, '/antares-cse/cnt-uoJ8bqJdQ-6874Gl', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(275, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(276, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(277, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(278, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(279, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(280, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(281, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(282, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(283, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(284, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(285, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(286, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(287, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(288, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(289, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(290, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(291, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(292, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(293, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(294, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(295, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(296, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(297, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(298, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(299, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(300, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(301, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(302, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(303, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(304, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(305, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(306, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(307, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(308, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(309, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(310, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(311, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(312, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(313, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(314, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(315, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(316, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(317, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(318, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(319, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(320, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(321, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(322, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(323, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(324, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(325, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(326, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(327, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(328, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(329, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(330, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(331, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(332, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(333, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(334, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(335, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(336, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(337, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(338, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(339, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(340, '/antares-cse/cnt-uoJ8bqJdQ-6874Gl', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(341, '/antares-cse/cnt-uoJ8bqJdQ-6874Gl', 9.0876, 1, 224, 0, 0, 8190, 4.47, 0, 65, '2022-04-26 20:36:50'),
(342, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(343, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 8190, 4.47, 0, 65, '2022-04-26 20:36:50'),
(344, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(345, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 8190, 4.47, 0, 65, '2022-04-26 20:36:50'),
(346, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(347, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 8190, 4.47, 0, 65, '2022-04-26 20:36:50'),
(348, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(349, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 8190, 4.47, 0, 65, '2022-04-26 20:36:50'),
(350, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(351, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 8190, 4.47, 0, 65, '2022-04-26 20:36:50'),
(352, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 234, 0, 0, 8190, 4.57, 0, 65, '2022-04-26 19:36:43'),
(353, '/antares-cse/cnt-s6K-aXFjRCGoOOVq', 9.0876, 1, 224, 0, 0, 8190, 4.47, 0, 65, '2022-04-26 20:36:50');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kawasan`
--

CREATE TABLE `kawasan` (
  `id_kawasan` int(11) NOT NULL,
  `nama_kawasan` varchar(250) NOT NULL,
  `date_updated` datetime NOT NULL DEFAULT current_timestamp(),
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `kawasan`
--

INSERT INTO `kawasan` (`id_kawasan`, `nama_kawasan`, `date_updated`, `date_created`) VALUES
(1, 'Kawasan Industri', '2022-04-30 08:45:23', '2022-04-30 08:45:23'),
(2, 'Kawasan LionPark', '2022-04-30 08:45:23', '2022-04-30 08:45:23'),
(3, 'Kawasan Cipali', '2022-04-30 11:50:03', '2022-04-30 11:50:03'),
(4, 'Kawasan Surabaya', '2022-04-30 11:50:03', '2022-04-30 11:50:03'),
(5, 'Kawasan Besi', '2022-04-30 11:50:03', '2022-04-30 11:50:03');

-- --------------------------------------------------------

--
-- Struktur dari tabel `role`
--

CREATE TABLE `role` (
  `id_role` int(11) NOT NULL,
  `nama_role` varchar(250) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `role`
--

INSERT INTO `role` (`id_role`, `nama_role`, `date_created`) VALUES
(1, 'Admin', '2022-04-29 20:45:11'),
(2, 'Pengelola Kawasan', '2022-04-29 20:45:11'),
(3, 'Engineer', '2022-04-29 20:45:11'),
(4, 'Tenant', '2022-04-29 20:45:11');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id_users` int(11) NOT NULL,
  `id_kawasan` int(11) NOT NULL DEFAULT 0,
  `nama` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password` varchar(300) NOT NULL,
  `avatar` varchar(200) NOT NULL,
  `id_role` int(11) NOT NULL DEFAULT 4,
  `date_updated` datetime NOT NULL DEFAULT current_timestamp(),
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id_users`, `id_kawasan`, `nama`, `email`, `password`, `avatar`, `id_role`, `date_updated`, `date_created`) VALUES
(1, 0, 'Rizqi Wijaya', 'rizqiEmail@gmail.com', '$2a$04$NM0FNu1yM.kemDAJKSwkXeFmIVSF1sgw/ZdpIRmjn0F821BEIPyc6', 'Images/avatar.png', 1, '2022-04-26 19:14:47', '2022-04-26 19:14:47'),
(2, 1, 'Hilmi', 'Hilmi@gmail.com', '$2a$04$2/beL7PtXpWbpN1/y7VLU..Oq5fCjy9x5fASphnpSLnmxuWUMlArm', 'Images/avatar.png', 2, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `data_kawasan`
--
ALTER TABLE `data_kawasan`
  ADD PRIMARY KEY (`id_dataK`);

--
-- Indeks untuk tabel `devices`
--
ALTER TABLE `devices`
  ADD PRIMARY KEY (`no_device`);

--
-- Indeks untuk tabel `device_conf`
--
ALTER TABLE `device_conf`
  ADD PRIMARY KEY (`id_conf`);

--
-- Indeks untuk tabel `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`id_history`);

--
-- Indeks untuk tabel `kawasan`
--
ALTER TABLE `kawasan`
  ADD PRIMARY KEY (`id_kawasan`);

--
-- Indeks untuk tabel `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id_role`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_users`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `data_kawasan`
--
ALTER TABLE `data_kawasan`
  MODIFY `id_dataK` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `devices`
--
ALTER TABLE `devices`
  MODIFY `no_device` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `device_conf`
--
ALTER TABLE `device_conf`
  MODIFY `id_conf` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `history`
--
ALTER TABLE `history`
  MODIFY `id_history` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=354;

--
-- AUTO_INCREMENT untuk tabel `kawasan`
--
ALTER TABLE `kawasan`
  MODIFY `id_kawasan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `role`
--
ALTER TABLE `role`
  MODIFY `id_role` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id_users` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
