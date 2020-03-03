-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               5.6.45 - MySQL Community Server (GPL)
-- Операционная система:         Win64
-- HeidiSQL Версия:              10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Дамп структуры базы данных matcha_db
CREATE DATABASE IF NOT EXISTS `matcha_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `matcha_db`;

-- Дамп структуры для таблица matcha_db.dialogs
CREATE TABLE IF NOT EXISTS `dialogs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `friend_1` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `friend_2` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_activity` datetime DEFAULT NULL,
  `last_activist` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unread` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Дамп данных таблицы matcha_db.dialogs: ~2 rows (приблизительно)
/*!40000 ALTER TABLE `dialogs` DISABLE KEYS */;
INSERT INTO `dialogs` (`id`, `friend_1`, `friend_2`, `last_activity`, `last_activist`, `unread`) VALUES
	(2, 'Ivan', 'QWERTY', '2020-03-01 03:56:38', 'Ivan', 0),
	(3, 'Ivan', 'LOL', '2020-03-01 03:58:08', 'Ivan', 0),
	(5, 'Irina', 'Ivan', '2020-03-03 22:37:10', 'Ivan', 0);
/*!40000 ALTER TABLE `dialogs` ENABLE KEYS */;

-- Дамп структуры для таблица matcha_db.genders_list
CREATE TABLE IF NOT EXISTS `genders_list` (
  `id` int(11) NOT NULL,
  `gender` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Дамп данных таблицы matcha_db.genders_list: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `genders_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `genders_list` ENABLE KEYS */;

-- Дамп структуры для таблица matcha_db.interests_list
CREATE TABLE IF NOT EXISTS `interests_list` (
  `id` int(11) NOT NULL,
  `interest` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Дамп данных таблицы matcha_db.interests_list: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `interests_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `interests_list` ENABLE KEYS */;

-- Дамп структуры для таблица matcha_db.likes
CREATE TABLE IF NOT EXISTS `likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `liker` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `liked` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `got` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Дамп данных таблицы matcha_db.likes: ~11 rows (приблизительно)
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` (`id`, `liker`, `liked`, `date`, `got`) VALUES
	(1, 'Irina', 'New', '2020-01-21 23:44:24', 0),
	(3, 'Irina', 'EvgeniyPonasenkov', '2020-01-22 02:59:13', 0),
	(4, 'LOL', 'Ivan', '2020-01-22 02:59:50', 1),
	(5, 'LOL', 'Irina', '2020-01-22 02:59:51', 1),
	(6, 'QWERTY', 'Ivan', '2020-01-22 03:00:01', 1),
	(7, 'QWERTY', 'Irina', '2020-01-22 03:00:02', 1),
	(37, 'Ivan', 'EvgeniyPonasenkov', '2020-03-01 00:56:23', 0),
	(44, 'Ivan', 'LOL', '2020-03-01 03:58:08', 0),
	(45, 'Ivan', 'QWERTY', '2020-03-01 03:58:10', 0),
	(48, 'Ivan', 'Irina', '2020-03-01 04:54:53', 1),
	(49, 'Irina', 'Ivan', '2020-03-01 05:12:28', 1);
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;

-- Дамп структуры для таблица matcha_db.messages
CREATE TABLE IF NOT EXISTS `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `adresant` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `message` varchar(4096) COLLATE utf8mb4_unicode_ci DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Дамп данных таблицы matcha_db.messages: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` (`id`, `author`, `adresant`, `date`, `message`) VALUES
	(9, 'Irina', 'Ivan', '2020-03-03 18:51:24', 'dgngnf'),
	(10, 'Ivan', 'Irina', '2020-03-03 18:52:59', 'dgngnf'),
	(11, 'Irina', 'Ivan', '2020-03-03 18:54:35', 'dgngnfgsfbdhn'),
	(12, 'Irina', 'Ivan', '2020-03-03 18:55:16', 'dgngnfgsfbdhn'),
	(13, 'Irina', 'Ivan', '2020-03-03 18:58:01', 'nfdnzgnz'),
	(14, 'Irina', 'Ivan', '2020-03-03 20:52:09', 'привет'),
	(15, 'Irina', 'Ivan', '2020-03-03 21:58:35', 'хающи'),
	(16, 'Irina', 'Ivan', '2020-03-03 22:02:28', 'gdbgn'),
	(17, 'Irina', 'Ivan', '2020-03-03 22:02:31', 'vbczbf'),
	(18, 'Irina', 'Ivan', '2020-03-03 22:02:35', 'zbvzdfb'),
	(19, 'Irina', 'Ivan', '2020-03-03 22:02:54', 'ggxnxngzng'),
	(20, 'Irina', 'Ivan', '2020-03-03 22:02:59', 'gnfzdgnzngzngfnz'),
	(21, 'Irina', 'Ivan', '2020-03-03 22:03:11', 'tnznnzrn'),
	(22, 'Irina', 'Ivan', '2020-03-03 22:03:47', 'dfhfh'),
	(23, 'Irina', 'Ivan', '2020-03-03 22:05:08', 'lol'),
	(24, 'Ivan', 'Irina', '2020-03-03 22:06:28', 'kek'),
	(25, 'Irina', 'Ivan', '2020-03-03 22:06:44', 'petushek'),
	(26, 'Irina', 'Ivan', '2020-03-03 22:07:03', '5'),
	(27, 'Irina', 'Ivan', '2020-03-03 22:07:08', '1'),
	(28, 'Irina', 'Ivan', '2020-03-03 22:07:16', 'ooo'),
	(29, 'Irina', 'Ivan', '2020-03-03 22:07:22', '555'),
	(30, 'Irina', 'Ivan', '2020-03-03 22:07:29', '77'),
	(31, 'Irina', 'Ivan', '2020-03-03 22:07:36', '98'),
	(32, 'Ivan', 'Irina', '2020-03-03 22:07:38', 'bfbs'),
	(33, 'Irina', 'Ivan', '2020-03-03 22:07:56', 'l'),
	(34, 'Irina', 'Ivan', '2020-03-03 22:14:08', 'lololo'),
	(35, 'Irina', 'Ivan', '2020-03-03 22:14:22', 'lololo'),
	(36, 'Irina', 'Ivan', '2020-03-03 22:18:12', '        axios           .get("/api/get_messages?username=" + this.username + "&last=-1")           .then(function(response) {             if (response.data.answer === true) {               self.messages = response.data.messages;               self.$nextTick(() => {                 let mw = self.$refs.mess[self.$refs.mess.length - 1];                 mw.scrollIntoView();               });'),
	(37, 'Irina', 'Ivan', '2020-03-03 22:18:41', '☻'),
	(38, 'Irina', 'Ivan', '2020-03-03 22:25:10', 'jjdkjflskjvlj'),
	(39, 'Irina', 'Ivan', '2020-03-03 22:25:16', 'fbl;dfkld'),
	(40, 'Irina', 'Ivan', '2020-03-03 22:25:28', 'Здравствуйте'),
	(41, 'Ivan', 'Irina', '2020-03-03 22:36:22', 'пьчпь'),
	(42, 'Ivan', 'Irina', '2020-03-03 22:36:32', 'gkf;l'),
	(43, 'Ivan', 'Irina', '2020-03-03 22:36:35', 'vkdlfvkdl;f'),
	(44, 'Ivan', 'Irina', '2020-03-03 22:36:39', 'lvklsdkv;d'),
	(45, 'Ivan', 'Irina', '2020-03-03 22:37:10', 'fbkdf;ld');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;

-- Дамп структуры для таблица matcha_db.orientations_list
CREATE TABLE IF NOT EXISTS `orientations_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orientation` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Дамп данных таблицы matcha_db.orientations_list: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `orientations_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `orientations_list` ENABLE KEYS */;

-- Дамп структуры для таблица matcha_db.photos
CREATE TABLE IF NOT EXISTS `photos` (
  `id` int(11) NOT NULL,
  `filename` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Дамп данных таблицы matcha_db.photos: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `photos` DISABLE KEYS */;
/*!40000 ALTER TABLE `photos` ENABLE KEYS */;

-- Дамп структуры для таблица matcha_db.posts
CREATE TABLE IF NOT EXISTS `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `body` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Дамп данных таблицы matcha_db.posts: ~2 rows (приблизительно)
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` (`id`, `body`, `user_id`) VALUES
	(2, 'lol privet', 25),
	(3, 'kek zdarov', 3),
	(7, 'ololo', 7);
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;

-- Дамп структуры для таблица matcha_db.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `firstname` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `lastname` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `gender` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `orientation` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `email` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `rating` int(11) NOT NULL DEFAULT '0',
  `biography` varchar(4096) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `confirmed` int(11) DEFAULT '0',
  `age` int(11) DEFAULT NULL,
  `orientation_id` int(11) DEFAULT NULL,
  `online` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Дамп данных таблицы matcha_db.users: ~9 rows (приблизительно)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `avatar`, `firstname`, `lastname`, `gender`, `orientation`, `email`, `rating`, `biography`, `password`, `confirmed`, `age`, `orientation_id`, `online`) VALUES
	(29, 'Ivan', '2020-01-21_224148.0847541.jpg', 'Ivan', 'Razin', 'Male', 'Natural', 'hjlkjk@l', 0, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 1, 0, 0, '2020-03-03 22:37:37'),
	(30, 'Irina', '2019-12-07_160409.2405795.jpg', 'Irina', 'Krot', 'Female', 'Natural', 'hjlkjk@l', 0, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 1, 0, 0, '2020-03-03 22:37:36'),
	(31, 'EvgeniyPonasenkov', '2019-12-07_160440.4013926.jpg', 'Evgeniy', 'Geniy', 'Male', 'Natural', 'Maestro@ya', 0, NULL, 'cde7190f13da5d30d02978a642a7ac14a3f5e75a32af5e7bbba98be62ea6145bf2f65baf2d6301e70c001babed36415d429466db9195d12905274b183cade09f', 1, 0, 0, '2020-03-03 16:14:09'),
	(32, 'LOL', '2019-12-07_160506.3454037.JPG', 'khhj', 'Razin', 'Teapot', 'Pidor', 'hjlkjk@l', 0, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 1, NULL, NULL, '2020-03-03 16:14:04'),
	(33, 'New', '2019-12-07_160535.9059893.jpg', 'sfvv', 'dvsvdv', 'Female', 'Gomosexual', 'vdvsv@rvbr', 0, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 1, NULL, NULL, '2020-03-03 16:14:10'),
	(34, 'QWERTY', '2019-12-07_160605.4725239.gif', 'Aleksey', 'Petrovi4', 'Transgender', 'Gomosexual', 'jhjh@jjhl', 0, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 1, NULL, NULL, '2020-03-03 16:14:05'),
	(35, 'Kek', '2019-12-07_160653.8234328.png', 'Kke', 'lol', 'Teapot', 'Pidor', 'hjlkjk@l', 0, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 1, NULL, NULL, '2020-03-03 16:14:07'),
	(36, 'qqq', '2019-12-07_160720.9181081.jpg', 'Kostya', 'Marinenkov', 'Transgender', 'Bisexual', 'hjlkjk@l', 0, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 1, NULL, NULL, '2020-03-03 16:14:06'),
	(37, 'yanazaya', '2019-12-07_160810.427570IMG_20190613_120632.jpg', 'Zaya', 'Yana', 'Female', 'Pidor', 'yz@yana.com', 0, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 1, NULL, NULL, '2020-03-03 16:14:02');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
