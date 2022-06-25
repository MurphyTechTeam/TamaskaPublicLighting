-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 22 Jun 2022 pada 11.48
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
-- Database: `tamaskapubliclight`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `area`
--

CREATE TABLE `area` (
  `area_id` int(11) NOT NULL,
  `cust_id` varchar(200) NOT NULL,
  `antares_apps` varchar(200) NOT NULL,
  `area_name` varchar(200) NOT NULL,
  `area_location` varchar(200) NOT NULL,
  `area_last` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `area`
--

INSERT INTO `area` (`area_id`, `cust_id`, `antares_apps`, `area_name`, `area_location`, `area_last`) VALUES
(1, '1280', 'SmartPJU', 'Kawasan Lion Park', 'Karawang, Jawa Barat', '2022-06-12 08:41:36'),
(2, '1290', 'SmartPJU2', 'Kawasan Industri Mojosemi', 'Mojokerto, Jawa Timur', '2022-06-12 08:41:36'),
(3, '1300', 'SmartPJU3', 'Kawasan Industri Cikarang', 'Cikarang, Jawa Barat', '2022-06-13 18:17:07');

-- --------------------------------------------------------

--
-- Struktur dari tabel `area_division`
--

CREATE TABLE `area_division` (
  `division_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `area_division`
--

INSERT INTO `area_division` (`division_id`, `user_id`, `area_id`, `date_created`) VALUES
(1, 1, 1, '2022-06-12 08:55:43'),
(2, 1, 2, '2022-06-12 08:55:43');

-- --------------------------------------------------------

--
-- Struktur dari tabel `detail_roles`
--

CREATE TABLE `detail_roles` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(52) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `detail_roles`
--

INSERT INTO `detail_roles` (`role_id`, `role_name`, `date_created`) VALUES
(1, 'admin', '2022-06-04 09:14:07'),
(2, 'Pengelola Kawasan', '2022-06-04 09:14:07'),
(3, 'Engineer', '2022-06-04 09:14:07'),
(4, 'Tenant', '2022-06-04 09:14:07');

-- --------------------------------------------------------

--
-- Struktur dari tabel `device`
--

CREATE TABLE `device` (
  `device_id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `antares_id` varchar(200) NOT NULL,
  `device_name` varchar(200) NOT NULL,
  `device_address` varchar(200) NOT NULL,
  `device_eui` varchar(200) NOT NULL,
  `longitude` varchar(500) NOT NULL,
  `latitude` varchar(500) NOT NULL,
  `device_location` varchar(200) NOT NULL,
  `device_cons` varchar(200) NOT NULL,
  `device_sts` int(11) NOT NULL,
  `device_last` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `device`
--

INSERT INTO `device` (`device_id`, `area_id`, `antares_id`, `device_name`, `device_address`, `device_eui`, `longitude`, `latitude`, `device_location`, `device_cons`, `device_sts`, `device_last`) VALUES
(1, 1, 'uoJ8bqJdQ-6874Gl', 'Luminer', 'f55e7014', 'a9ead5aa8dc8bac8', '107.263619', '-6.358417', 'Jln Pangandaran No. 9', '1', 1, '2022-06-12 08:51:40'),
(2, 1, 'uoJ8bqJdQ-6874Gl', 'device 1', 'f55e7014', 'we2ad5aa8dc8bac8', '107.263619', '-6.358417', 'Jln Pangandaran No. 9', '0', 2, '2022-06-12 08:51:40'),
(3, 2, 'uoJ8bqJdQ-6874Gl', 'device 2', 'f55e7015', '1ddad5aa8dc8bac8', '107.263619', '-6.358417', 'Jln Pangandaran No. 9', '1', 1, '2022-06-12 08:51:40'),
(4, 1, 'uoJ8bqJdQ-6874Gl', 'device 3', 'f55e7016', 'a9ead5aa8dc8bac8', '107.263619', '-6.358417', 'Jln Pangandaran No. 9', '0', 3, '2022-06-12 08:51:40'),
(5, 1, 'uoJ8bqJdQ-6874Gl', 'device 5', 'f55e7017', 'a9ead5aa8dc8bac8', '107.263619', '-6.358417', 'Jln Pangandaran No. 9', '1', 2, '2022-06-12 08:51:40'),
(6, 1, 'uoJ8bqJdQ-6874Gl', 'device 6', 'f55e7018', 'a9ead5aa8dc8bac8', '107.263619', '-6.358417', 'Jln Pangandaran No. 9', '2', 1, '2022-06-12 08:51:40'),
(7, 1, 'uoJ8bqJdQ-6874Gl', 'device 7', 'f55e7019', 'a9ead5aa8dc8bac8', '107.263619', '-6.358417', 'Jln Pangandaran No. 9', '1', 3, '2022-06-12 08:51:40');

-- --------------------------------------------------------

--
-- Struktur dari tabel `device_cons_d`
--

CREATE TABLE `device_cons_d` (
  `id` int(11) NOT NULL,
  `cons_name` varchar(200) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `device_cons_d`
--

INSERT INTO `device_cons_d` (`id`, `cons_name`, `date_created`) VALUES
(0, 'Padam', '2022-06-12 10:48:07'),
(1, 'Menyala', '2022-06-12 10:48:07'),
(2, 'Error', '2022-06-15 10:32:53');

-- --------------------------------------------------------

--
-- Struktur dari tabel `device_controlling`
--

CREATE TABLE `device_controlling` (
  `deviceC_id` int(11) NOT NULL,
  `device_id` int(11) NOT NULL,
  `manual_Control` int(11) NOT NULL,
  `restart_sts` int(11) NOT NULL,
  `alarm_type` int(11) NOT NULL,
  `hour_on` varchar(10) NOT NULL DEFAULT '00',
  `minutes_on` varchar(10) NOT NULL DEFAULT '00',
  `hour_off` varchar(10) NOT NULL DEFAULT '00',
  `minutes_off` varchar(10) NOT NULL DEFAULT '00',
  `interval_loop` int(11) NOT NULL,
  `interval_send` int(11) NOT NULL,
  `bluetooth` int(11) NOT NULL,
  `totalisator` int(11) NOT NULL,
  `lamp_treshold` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `device_controlling`
--

INSERT INTO `device_controlling` (`deviceC_id`, `device_id`, `manual_Control`, `restart_sts`, `alarm_type`, `hour_on`, `minutes_on`, `hour_off`, `minutes_off`, `interval_loop`, `interval_send`, `bluetooth`, `totalisator`, `lamp_treshold`) VALUES
(1, 1, 1, 0, 0, '10', '30', '14', '30', 10, 15, 1, 150, 200),
(2, 2, 0, 0, 0, '10', '30', '14', '30', 10, 15, 1, 150, 200),
(3, 3, 1, 0, 0, '10', '30', '14', '30', 10, 15, 1, 150, 200),
(4, 4, 0, 0, 0, '10', '30', '14', '30', 10, 15, 1, 150, 200),
(5, 5, 1, 0, 0, '10', '30', '14', '30', 10, 15, 1, 150, 200),
(6, 6, 2, 0, 0, '10', '30', '14', '30', 10, 15, 1, 150, 200),
(7, 7, 1, 0, 0, '10', '30', '14', '30', 10, 15, 1, 150, 200);

-- --------------------------------------------------------

--
-- Struktur dari tabel `device_history`
--

CREATE TABLE `device_history` (
  `history_id` int(11) NOT NULL,
  `device_id` int(11) NOT NULL,
  `energy` float NOT NULL DEFAULT 0,
  `power` float NOT NULL DEFAULT 0,
  `voltage` float NOT NULL DEFAULT 0,
  `ampere` float NOT NULL DEFAULT 0,
  `powerFactor` float NOT NULL DEFAULT 0,
  `lightSensor` float NOT NULL DEFAULT 0,
  `battery` float NOT NULL DEFAULT 0,
  `brightness` float NOT NULL DEFAULT 0,
  `device_cons` int(11) NOT NULL,
  `history_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `device_history`
--

INSERT INTO `device_history` (`history_id`, `device_id`, `energy`, `power`, `voltage`, `ampere`, `powerFactor`, `lightSensor`, `battery`, `brightness`, `device_cons`, `history_date`) VALUES
(1, 1, 550, 250, 300, 100, 150, 230, 100, 75, '1', '2022-05-17 17:51:53'),
(2, 1, 650, 150, 350, 120, 150, 230, 90, 80, '1', '2022-06-12 17:51:53'),
(3, 3, 450, 150, 350, 120, 150, 230, 90, 80, '1', '2022-06-15 17:51:53'),
(4, 1, 550, 250, 300, 100, 150, 230, 100, 75, '0', '2022-06-12 17:51:53'),
(5, 1, 650, 150, 350, 120, 150, 230, 90, 80, '0', '2022-06-12 17:51:53'),
(6, 3, 450, 150, 350, 120, 150, 230, 90, 80, '1', '2022-06-15 17:51:53'),
(7, 1, 650, 150, 350, 120, 150, 230, 90, 80, '0', '2022-06-15 08:47:52'),
(8, 2, 550, 250, 300, 100, 150, 230, 100, 75, '1', '2022-06-15 17:51:53'),
(9, 3, 650, 150, 350, 120, 150, 230, 90, 80, '1', '2022-06-15 17:51:53'),
(10, 1, 450, 150, 350, 120, 150, 230, 90, 80, '1', '2022-06-15 17:51:53'),
(11, 1, 550, 250, 300, 100, 150, 230, 100, 75, '0', '2022-06-13 17:51:53'),
(12, 1, 650, 150, 350, 120, 150, 230, 90, 80, '0', '2022-06-13 17:51:53'),
(13, 1, 150, 150, 350, 120, 150, 230, 90, 80, '0', '2022-06-15 08:47:50'),
(14, 1, 650, 150, 350, 120, 150, 230, 90, 80, '0', '2022-06-16 17:51:53'),
(15, 2, 550, 200, 320, 110, 150, 230, 85, 90, '1', '2022-06-21 11:40:15'),
(16, 1, 550, 200, 320, 110, 150, 230, 85, 90, '1', '2022-05-19 11:41:00'),
(17, 1, 550, 200, 320, 110, 150, 230, 85, 90, '1', '2022-05-21 11:41:08');

-- --------------------------------------------------------

--
-- Struktur dari tabel `device_monitoring`
--

CREATE TABLE `device_monitoring` (
  `deviceM_id` int(11) NOT NULL,
  `device_id` int(11) NOT NULL,
  `energy` float NOT NULL,
  `power` float NOT NULL,
  `voltage` float NOT NULL,
  `ampere` float NOT NULL,
  `powerFactor` float NOT NULL,
  `lightSensor` float NOT NULL,
  `battery` float NOT NULL,
  `brightness` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `device_monitoring`
--

INSERT INTO `device_monitoring` (`deviceM_id`, `device_id`, `energy`, `power`, `voltage`, `ampere`, `powerFactor`, `lightSensor`, `battery`, `brightness`) VALUES
(1, 1, 550, 250, 300, 100, 150, 230, 100, 75),
(2, 2, 550, 250, 300, 100, 150, 230, 100, 75),
(3, 3, 550, 250, 300, 100, 150, 230, 100, 75),
(4, 4, 550, 250, 300, 100, 150, 230, 100, 75),
(5, 5, 550, 250, 300, 100, 150, 230, 100, 75),
(6, 6, 550, 250, 300, 100, 150, 230, 100, 75),
(7, 7, 550, 250, 300, 100, 150, 230, 100, 75);

-- --------------------------------------------------------

--
-- Struktur dari tabel `device_sts_d`
--

CREATE TABLE `device_sts_d` (
  `id` int(11) NOT NULL,
  `sts_name` varchar(200) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `device_sts_d`
--

INSERT INTO `device_sts_d` (`id`, `sts_name`, `date_created`) VALUES
(1, 'Device aktif', '2022-06-12 08:37:45'),
(2, 'Device maintenance', '2022-06-12 08:37:45'),
(3, 'Device rusak', '2022-06-12 08:37:45');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password` varchar(300) NOT NULL,
  `avatar` varchar(200) NOT NULL,
  `date_updated` datetime NOT NULL DEFAULT current_timestamp(),
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`user_id`, `name`, `email`, `password`, `avatar`, `date_updated`, `date_created`) VALUES
(1, 'Rizqi Wijaya', 'rizqi@gmail.com', '$2a$04$NM0FNu1yM.kemDAJKSwkXeFmIVSF1sgw/ZdpIRmjn0F821BEIPyc6', 'Images/avatar.png', '2022-04-26 19:14:47', '2022-04-26 19:14:47'),
(2, 'Hilmi', 'Hilmi@gmail.com', '$2a$04$2/beL7PtXpWbpN1/y7VLU..Oq5fCjy9x5fASphnpSLnmxuWUMlArm', 'Images/avatar.png', '2022-06-12 08:57:24', '2022-06-12 08:57:28'),
(3, 'bangjago', 'bangjago@gmail.com', '$2a$04$2uyprOcf1suSYf9Qg98o4u44UXpnX19AYhZGHUwmU9RmuL9nxxa4.', 'Images/avatar.png', '2022-06-05 08:57:42', '2022-06-05 08:57:46'),
(4, 'wijaya', 'wijaya@gmail.com', '$2a$04$HOJMyx8BEp/4EvbiB6WVQOXzXT7vys7wTGkNbNLQTIp8XjcJvEfDC', 'Images/avatar.png', '2022-06-07 08:57:49', '2022-06-07 08:57:53');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_roles`
--

CREATE TABLE `user_roles` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `user_roles`
--

INSERT INTO `user_roles` (`id`, `user_id`, `role_id`) VALUES
(1, 1, 3),
(2, 1, 2),
(3, 1, 4);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `area`
--
ALTER TABLE `area`
  ADD PRIMARY KEY (`area_id`);

--
-- Indeks untuk tabel `area_division`
--
ALTER TABLE `area_division`
  ADD PRIMARY KEY (`division_id`);

--
-- Indeks untuk tabel `device`
--
ALTER TABLE `device`
  ADD PRIMARY KEY (`device_id`);

--
-- Indeks untuk tabel `device_cons_d`
--
ALTER TABLE `device_cons_d`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `device_controlling`
--
ALTER TABLE `device_controlling`
  ADD PRIMARY KEY (`deviceC_id`);

--
-- Indeks untuk tabel `device_history`
--
ALTER TABLE `device_history`
  ADD PRIMARY KEY (`history_id`);

--
-- Indeks untuk tabel `device_monitoring`
--
ALTER TABLE `device_monitoring`
  ADD PRIMARY KEY (`deviceM_id`);

--
-- Indeks untuk tabel `device_sts_d`
--
ALTER TABLE `device_sts_d`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- Indeks untuk tabel `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `area`
--
ALTER TABLE `area`
  MODIFY `area_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `area_division`
--
ALTER TABLE `area_division`
  MODIFY `division_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `device`
--
ALTER TABLE `device`
  MODIFY `device_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `device_cons_d`
--
ALTER TABLE `device_cons_d`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `device_controlling`
--
ALTER TABLE `device_controlling`
  MODIFY `deviceC_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `device_history`
--
ALTER TABLE `device_history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT untuk tabel `device_monitoring`
--
ALTER TABLE `device_monitoring`
  MODIFY `deviceM_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `device_sts_d`
--
ALTER TABLE `device_sts_d`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
