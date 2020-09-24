-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Хост: db
-- Время создания: Сен 22 2020 г., 13:20
-- Версия сервера: 5.7.31
-- Версия PHP: 7.4.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET GLOBAL time_zone = "+03:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `matcha_db`
--
DROP DATABASE IF EXISTS `matcha_db`;
CREATE DATABASE IF NOT EXISTS `matcha_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `matcha_db`;

-- --------------------------------------------------------

--
-- Структура таблицы `blacklist`
--

CREATE TABLE `blacklist` (
  `user` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `blocked_user` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `blacklist`
--

INSERT INTO `blacklist` (`user`, `blocked_user`) VALUES
('IvanIvan', 'Ivan'),
('IvanIvan', 'Irina'),
('IvanIvan', 'EvgeniyPonasenkov'),
('IvanIvan', 'LOL'),
('IvanIvan', 'Kek');

-- --------------------------------------------------------

--
-- Структура таблицы `dialogs`
--

CREATE TABLE `dialogs` (
  `id` int(11) NOT NULL,
  `friend_1` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `friend_2` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_activity` datetime DEFAULT NULL,
  `last_activist` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unread` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `dialogs`
--

INSERT INTO `dialogs` (`id`, `friend_1`, `friend_2`, `last_activity`, `last_activist`, `unread`) VALUES
(2, 'Ivan', 'QWERTY', '2020-09-03 11:31:26', 'Ivan', 1),
(3, 'Ivan', 'LOL', '2020-09-17 19:11:27', 'Ivan', 1),
(7, 'chorange', 'Ivan', '2020-09-14 18:24:10', 'chorange', 0),
(18, 'Ivan', 'IvanIvan', '2020-09-21 02:25:47', 'Ivan', 2),
(20, 'Ivan', 'Irina', '2020-09-22 13:08:19', 'Ivan', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `genders_list`
--

CREATE TABLE `genders_list` (
  `id` int(11) NOT NULL,
  `gender` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `guests`
--

CREATE TABLE `guests` (
  `user` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `visited_user` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `got` int(11) NOT NULL DEFAULT '0',
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `guests`
--

INSERT INTO `guests` (`user`, `visited_user`, `got`, `id`) VALUES
('Ivan', 'EvgeniyPonasenkov', 0, 10),
('Ivan', 'LOL', 0, 24),
('Ivan', '12345', 0, 25),
('Ivan', 'chorange', 0, 26),
('Ivan', 'chorange', 0, 29),
('Ivan', 'IvanIvan', 0, 30),
('Ivan', 'LOL', 0, 31),
('Ivan', '12345', 0, 32),
('Ivan', '12345', 0, 33),
('Ivan', '12345', 0, 35),
('Ivan', 'IvanIvan', 0, 36),
('Ivan', 'LOL', 0, 38),
('Ivan', 'IvanIvan', 0, 40),
('Ivan', 'LOL', 0, 41),
('Ivan', 'Irina', 0, 45),
('Ivan', 'Ivan', 0, 46),
('Ivan', 'Ivanh', 0, 47),
('Ivan', 'Ivanh', 0, 48),
('Ivan', 'Ivanh', 0, 49),
('Ivan', 'Ivan', 0, 50),
('Ivan', 'Ivanl', 0, 51);

-- --------------------------------------------------------

--
-- Структура таблицы `interests_list`
--

CREATE TABLE `interests_list` (
  `id` int(11) NOT NULL,
  `interest` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `likes`
--

CREATE TABLE `likes` (
  `id` int(11) NOT NULL,
  `liker` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `liked` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `got` int(11) DEFAULT NULL,
  `type` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'like'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `likes`
--

INSERT INTO `likes` (`id`, `liker`, `liked`, `date`, `got`, `type`) VALUES
(1, 'Irina', 'New', '2020-01-21 23:44:24', 0, 'like'),
(4, 'LOL', 'Ivan', '2020-01-22 02:59:50', 1, 'like'),
(5, 'LOL', 'Irina', '2020-01-22 02:59:51', 1, 'like'),
(6, 'QWERTY', 'Ivan', '2020-01-22 03:00:01', 1, 'like'),
(7, 'QWERTY', 'Irina', '2020-01-22 03:00:02', 1, 'like'),
(37, 'Ivan', 'EvgeniyPonasenkov', '2020-03-01 00:56:23', 0, 'like'),
(44, 'Ivan', 'LOL', '2020-03-01 03:58:08', 1, 'like'),
(45, 'Ivan', 'QWERTY', '2020-03-01 03:58:10', 0, 'like'),
(50, 'Ivan', 'qqq', '2020-09-03 11:31:33', 0, 'like'),
(51, 'Ivan', 'yanazaya', '2020-09-03 11:31:34', 0, 'like'),
(52, 'Ivan', 'chorange', '2020-09-03 11:31:35', 1, 'like'),
(54, 'chorange', 'Ivan', '2020-09-03 11:32:49', 1, 'like'),
(55, 'Ivan', 'coco', '2020-09-10 07:46:32', 1, 'like'),
(62, 'IvanIvan', 'Ivan', '2020-09-17 18:11:01', 1, 'like'),
(63, 'IvanIvan', 'New', '2020-09-17 19:06:30', 0, 'like'),
(64, 'IvanIvan', 'QWERTY', '2020-09-17 19:06:31', 0, 'like'),
(70, 'Irina', 'Ivan', '2020-09-18 14:07:45', 1, 'like'),
(71, 'Irina', 'EvgeniyPonasenkov', '2020-09-18 14:07:46', 0, 'like'),
(76, 'Ivan', '12345', '2020-09-21 01:19:29', 0, 'like'),
(77, 'Ivan', 'IvanIvan', '2020-09-21 01:43:53', 0, 'like'),
(95, 'Ivan', 'Irina', '2020-09-22 13:08:19', 0, 'like');

-- --------------------------------------------------------

--
-- Структура таблицы `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `author` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `adresant` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `message` varchar(4096) COLLATE utf8mb4_unicode_ci DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `messages`
--

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
(36, 'Irina', 'Ivan', '2020-03-03 22:18:12', '        axios           .get(\"/api/get_messages?username=\" + this.username + \"&last=-1\")           .then(function(response) {             if (response.data.answer === true) {               self.messages = response.data.messages;               self.$nextTick(() => {                 let mw = self.$refs.mess[self.$refs.mess.length - 1];                 mw.scrollIntoView();               });'),
(37, 'Irina', 'Ivan', '2020-03-03 22:18:41', '☻'),
(38, 'Irina', 'Ivan', '2020-03-03 22:25:10', 'jjdkjflskjvlj'),
(39, 'Irina', 'Ivan', '2020-03-03 22:25:16', 'fbl;dfkld'),
(40, 'Irina', 'Ivan', '2020-03-03 22:25:28', 'Здравствуйте'),
(41, 'Ivan', 'Irina', '2020-03-03 22:36:22', 'пьчпь'),
(42, 'Ivan', 'Irina', '2020-03-03 22:36:32', 'gkf;l'),
(43, 'Ivan', 'Irina', '2020-03-03 22:36:35', 'vkdlfvkdl;f'),
(44, 'Ivan', 'Irina', '2020-03-03 22:36:39', 'lvklsdkv;d'),
(45, 'Ivan', 'Irina', '2020-03-03 22:37:10', 'fbkdf;ld'),
(46, 'Ivan', 'Irina', '2020-09-01 13:14:52', 'kuk'),
(47, 'Ivan', 'Irina', '2020-09-01 13:15:09', 'dkjvhsjkdhv'),
(48, 'Ivan', 'Irina', '2020-09-01 13:15:12', 'lol'),
(49, 'Ivan', 'Irina', '2020-09-01 13:15:19', 'lol'),
(50, 'Ivan', 'QWERTY', '2020-09-03 11:31:26', 'kjgkhjl'),
(51, 'Ivan', 'qqq', '2020-09-03 11:31:33', 'Привет, теперь мы друзья!'),
(52, 'Ivan', 'yanazaya', '2020-09-03 11:31:34', 'Привет, теперь мы друзья!'),
(53, 'Ivan', 'chorange', '2020-09-03 11:31:35', 'Привет, теперь мы друзья!'),
(54, 'chorange', 'Ivan', '2020-09-03 11:32:21', 'Привет, теперь мы друзья!'),
(55, 'chorange', 'Ivan', '2020-09-03 11:32:49', 'Привет, теперь мы друзья!'),
(56, 'chorange', 'Ivan', '2020-09-04 09:43:39', 'Hello'),
(57, 'Ivan', 'chorange', '2020-09-04 09:44:15', 'htllo'),
(58, 'chorange', 'Ivan', '2020-09-04 09:46:25', 'Lol'),
(59, 'Ivan', 'chorange', '2020-09-04 09:48:36', 'hgjhghh'),
(60, 'chorange', 'Ivan', '2020-09-04 09:49:05', 'Hi'),
(61, 'Ivan', 'chorange', '2020-09-04 09:49:17', 'kik'),
(62, 'Ivan', 'Irina', '2020-09-07 04:06:45', 'орлр'),
(63, 'Ivan', 'chorange', '2020-09-10 07:38:23', 'dslhsd'),
(64, 'Ivan', 'coco', '2020-09-10 07:46:32', 'Привет, теперь мы друзья!'),
(65, 'chorange', 'Irina', '2020-09-10 16:55:50', 'Привет, теперь мы друзья!'),
(66, 'chorange', 'EvgeniyPonasenkov', '2020-09-10 16:55:52', 'Привет, теперь мы друзья!'),
(67, 'Ivan', 'chorange', '2020-09-10 20:04:39', 'kkk'),
(68, 'Ivan', 'chorange', '2020-09-10 23:12:21', 'lkl'),
(69, 'Irina', 'Ivan', '2020-09-14 16:39:07', 'H'),
(70, 'Ivan', 'Irina', '2020-09-14 16:39:34', 'k'),
(71, 'chorange', 'Ivan', '2020-09-14 18:24:10', 'kj'),
(72, 'IvanIvan', 'Ivan', '2020-09-17 16:47:25', 'Привет, теперь мы друзья!'),
(73, 'IvanIvan', 'Ivan', '2020-09-17 16:58:11', 'Привет, теперь мы друзья!'),
(74, 'IvanIvan', 'Ivan', '2020-09-17 17:40:22', 'Привет, теперь мы друзья!'),
(75, 'IvanIvan', 'Ivan', '2020-09-17 17:40:26', 'Привет, теперь мы друзья!'),
(76, 'IvanIvan', 'Ivan', '2020-09-17 18:11:01', 'Привет, теперь мы друзья!'),
(77, 'IvanIvan', 'New', '2020-09-17 19:06:30', 'Привет, теперь мы друзья!'),
(78, 'IvanIvan', 'QWERTY', '2020-09-17 19:06:31', 'Привет, теперь мы друзья!'),
(79, 'Ivan', 'LOL', '2020-09-17 19:11:27', 'jkhkjh'),
(80, 'Ivan', 'Irina', '2020-09-18 13:14:33', 'Привет, теперь мы друзья!'),
(81, 'Ivan', 'Irina', '2020-09-18 13:14:37', 'Привет, теперь мы друзья!'),
(82, 'Ivan', 'Irina', '2020-09-18 13:14:39', 'Привет, теперь мы друзья!'),
(83, 'Ivan', 'Irina', '2020-09-18 13:14:41', 'Привет, теперь мы друзья!'),
(84, 'Ivan', 'Irina', '2020-09-18 13:17:23', 'Привет, теперь мы друзья!'),
(85, 'Irina', 'Ivan', '2020-09-18 14:07:45', 'Привет, теперь мы друзья!'),
(86, 'Irina', 'EvgeniyPonasenkov', '2020-09-18 14:07:46', 'Привет, теперь мы друзья!'),
(87, 'Ivan', 'Irina', '2020-09-18 14:09:13', 'Привет, теперь мы друзья!'),
(88, 'Ivan', 'Irina', '2020-09-18 14:09:24', 'Привет, теперь мы друзья!'),
(89, 'Ivan', 'Irina', '2020-09-18 14:09:37', 'Привет, теперь мы друзья!'),
(90, 'Ivan', 'Irina', '2020-09-20 22:49:06', '<script>alert(\'lol\');</script>'),
(91, 'Ivan', 'Irina', '2020-09-21 01:10:56', 'Привет, теперь мы друзья!'),
(92, 'Ivan', '12345', '2020-09-21 01:19:29', 'Привет, теперь мы друзья!'),
(93, 'Ivan', 'Irina', '2020-09-21 01:20:16', 'lol'),
(94, 'Ivan', 'IvanIvan', '2020-09-21 01:43:53', 'Привет, теперь мы друзья!'),
(95, 'Ivan', 'IvanIvan', '2020-09-21 02:25:47', 'hsjkdfh'),
(96, 'Ivan', 'Irina', '2020-09-22 14:31:41', 'Привет, теперь мы друзья!'),
(97, 'Irina', 'Ivan', '2020-09-22 14:32:03', 'привет'),
(98, 'Ivan', 'Irina', '2020-09-22 14:33:10', 'Привет, теперь мы друзья!'),
(99, 'Ivan', 'Irina', '2020-09-22 14:41:12', 'Привет, теперь мы друзья!'),
(100, 'Ivan', 'Irina', '2020-09-22 15:01:09', 'Привет, теперь мы друзья!'),
(101, 'Ivan', 'Irina', '2020-09-22 15:02:49', 'Привет, теперь мы друзья!'),
(102, 'Ivan', 'Irina', '2020-09-22 15:04:32', 'Привет, теперь мы друзья!'),
(103, 'Ivan', 'Irina', '2020-09-22 13:08:02', 'Привет, теперь мы друзья!'),
(104, 'Ivan', 'Irina', '2020-09-22 13:08:19', 'Привет, теперь мы друзья!');

-- --------------------------------------------------------

--
-- Структура таблицы `orientations_list`
--

CREATE TABLE `orientations_list` (
  `id` int(11) NOT NULL,
  `orientation` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `password_recovery`
--

CREATE TABLE `password_recovery` (
  `user` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `password_recovery`
--

INSERT INTO `password_recovery` (`user`, `id`, `date`) VALUES
('Abraham', 'ZmpTQrxPNkgMcQOkUjpxWtHrKDyBdIsL', '2020-09-09 09:41:53'),
('Ivan', 'WnPkXgnERBNiMGeusuSDJoDhJiXrDMWA', '2020-09-22 13:16:21');

-- --------------------------------------------------------

--
-- Структура таблицы `photos`
--

CREATE TABLE `photos` (
  `id` int(11) NOT NULL,
  `filename` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `body` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `posts`
--

INSERT INTO `posts` (`id`, `body`, `user_id`) VALUES
(2, 'lol privet', 25),
(3, 'kek zdarov', 3),
(7, 'ololo', 7);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image1` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image2` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image3` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image4` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image5` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
  `age` int(11) NOT NULL DEFAULT '0',
  `online` datetime DEFAULT NULL,
  `latitude` double NOT NULL DEFAULT '9999',
  `longitude` double NOT NULL DEFAULT '9999',
  `location` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'nowhere',
  `interests` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '[]',
  `register` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '{"data": false, "image": false, "geo": false}',
  `register_data` int(11) NOT NULL DEFAULT '0',
  `register_image` int(11) NOT NULL DEFAULT '0',
  `register_geo` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `name`, `image1`, `image2`, `image3`, `image4`, `image5`, `avatar`, `firstname`, `lastname`, `gender`, `orientation`, `email`, `rating`, `biography`, `password`, `confirmed`, `age`, `online`, `latitude`, `longitude`, `location`, `interests`, `register`, `register_data`, `register_image`, `register_geo`) VALUES
(29, 'Ivan', 'Ivan2020-09-10_224050.582543_2020-08-26_14.39.58.png', 'Ivan2020-09-10_223613.814259_2020-08-26_14.39.58.png', 'Ivan2020-09-10_223620.039404_2020-08-26_14.39.58.png', 'Ivan2020-09-14_181457.7508152.jpg', 'Ivan2020-09-21_022643.9110411477670391.jpg', 'Ivan2020-09-21_022643.9110411477670391.jpg', 'Ivan2', 'Razin', 'Male', 'Natural', 'hjlkjk@l', 165, 'A cookie associated with a cross-site resource at https://yandex.ru/ was set without the `SameSite` attribute. It has been blocked, as Chrome now only delivers cookies with cross-site requests if they are set with `SameSite=None` and `Secure`. You can review cookies in developer tools under Application>Storage>Cookies and see more details at https://www.chromestatus.com/feature/5088147346030592 and https://www.chromestatus.com/feature/5633521622188032.\n:8080/?#/settings:1 A cookie associated with a cross-site resource at http://yandex.ru/ was set without the `SameSite` attribute. It has been blocked, as Chrome now only delivers cookies with cross-site requests if they are set with `SameSite=None` and `Secure`. You can review cookies in developer tools under Application>Storage>Cookies and see more details at https://www.chromestatus.com/feature/5088147346030592 and https://www.chromestatus.com/feature/5633521622188032.', 'a820a221db9d8944de62ae619ad25f1ef321abb439259edba0578d2c35a815e466086fc2a82dedaaf8a2e64e7d6577e7c0a7ab416d69dbc683933ac93dca30fe', 1, 0, '2020-09-22 13:20:02', 55.76786456657348, 37.56615529185031, 'Россия, Москва, улица Климашкина', '[\"lol\",\"kek\",\"4ebureck\"]', '{\"data\": false, \"image\": false, \"geo\": false}', 1, 1, 1),
(30, 'Irina', NULL, 'Irina2020-09-14_182017.5300769.gif', NULL, NULL, NULL, 'Irina2020-09-14_182017.5300769.gif', 'Irina', 'Krot', 'Female', 'Natural', 'hjlkjk@l', 55, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 1, 0, '2020-09-22 13:20:00', 55.755241, 37.617779, 'Россия, Москва, Красная площадь, 1', '[]', '{\"data\": false, \"image\": false, \"geo\": false}', 1, 1, 1),
(31, 'EvgeniyPonasenkov', '2019-12-07_160440.4013926.jpg', NULL, NULL, NULL, NULL, '2019-12-07_160440.4013926.jpg', 'Evgeniy', 'Geniy', 'Male', 'Natural', 'Maestro@ya', 20, NULL, 'cde7190f13da5d30d02978a642a7ac14a3f5e75a32af5e7bbba98be62ea6145bf2f65baf2d6301e70c001babed36415d429466db9195d12905274b183cade09f', 1, 0, '2020-03-03 16:14:09', 0, 0, '', '[]', '{\"data\": false, \"image\": false, \"geo\": false}', 0, 0, 0),
(32, 'LOL', '2019-12-07_160506.3454037.JPG', 'LOL2020-09-15_094045.704993brick.bmp', NULL, NULL, NULL, 'LOL2020-09-15_094045.704993brick.bmp', 'khhj', 'Razin', 'Male', 'Bisexual', 'hjlkjk@l', 0, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 1, 20, '2020-09-21 00:15:08', 55.755523974207584, 37.61727283125619, 'Россия, Москва, Красная площадь, 1', '[]', '{\"data\": false, \"image\": false, \"geo\": false}', 1, 1, 1),
(33, 'New', '2019-12-07_160535.9059893.jpg', 'New2020-09-15_094337.4602678004181048.jpg', NULL, NULL, NULL, 'New2020-09-15_094337.4602678004181048.jpg', 'sfvv', 'dvsvdv', 'Female', 'Gomosexual', 'vdvsv@rvbr', 0, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 1, 10, '2020-09-15 09:44:17', 55.755241, 37.617779, 'Россия, Москва, Красная площадь, 1', '[]', '{\"data\": false, \"image\": false, \"geo\": false}', 1, 1, 1),
(34, 'QWERTY', '2019-12-07_160605.4725239.gif', NULL, NULL, NULL, NULL, '2019-12-07_160605.4725239.gif', 'Aleksey', 'Petrovi4', 'Male', 'Gomosexual', 'jhjh@jjhl', 0, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 1, 10, '2020-03-03 16:14:05', 0, 0, '', '[]', '{\"data\": false, \"image\": false, \"geo\": false}', 0, 0, 0),
(35, 'Kek', '2019-12-07_160653.8234328.png', NULL, NULL, NULL, NULL, '2019-12-07_160653.8234328.png', 'Kke', 'lol', 'Female', 'Bisexual', 'hjlkjk@l', 0, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 1, 3, '2020-03-03 16:14:07', 0, 0, '', '[]', '{\"data\": false, \"image\": false, \"geo\": false}', 0, 0, 0),
(36, 'qqq', '2019-12-07_160720.9181081.jpg', NULL, NULL, NULL, NULL, '2019-12-07_160720.9181081.jpg', 'Kostya', 'Marinenkov', 'Male', 'Bisexual', 'hjlkjk@l', 0, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 1, 45, '2020-03-03 16:14:06', 0, 0, '', '[]', '{\"data\": false, \"image\": false, \"geo\": false}', 0, 0, 0),
(37, 'yanazaya', '2019-12-07_160810.427570IMG_20190613_120632.jpg\r\n', NULL, NULL, NULL, NULL, '2019-12-07_160810.427570IMG_20190613_120632.jpg', 'Zaya', 'Yana', 'Female', 'Bisexual', 'yz@yana.com', 0, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 1, 21, '2020-03-03 16:14:02', 0, 0, '', '[]', '{\"data\": false, \"image\": false, \"geo\": false}', 0, 0, 0),
(38, 'chorange', 'chorange2020-09-01_160751.301671BKphAb3n31M.jpg', 'chorange2020-09-14_182350.1738002019-12-07_160653.8234328.png', 'chorange2020-09-21_015819.7902071477670391.jpg', 'chorange2020-09-21_021520.5582008004181048.jpg', 'chorange2020-09-21_021606.885654MEbBM4AHbpY.jpg', 'chorange2020-09-21_021606.885654MEbBM4AHbpY.jpg', 'Chorange', 'Dartwing', 'Female', 'Bisexual', 'lol@ya.com', 15, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 1, 65, '2020-09-22 14:25:20', 55.75654182829577, 37.61192845050671, 'Россия, Москва, Моховая улица, 11с8', '[]', '{\"data\": false, \"image\": false, \"geo\": false}', 1, 1, 1),
(40, 'Abraham', NULL, NULL, NULL, NULL, NULL, NULL, 'Abraham', 'A', 'Male', 'Natural', 'razin-ivan98@ya.ru', 0, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 1, 22, '2020-09-09 09:41:41', 9999, 9999, 'nowhere', '[]', '{\"data\": false, \"image\": false, \"geo\": false}', 0, 0, 0),
(41, 'coco', NULL, NULL, NULL, NULL, NULL, NULL, 'coco', 'coco', 'Male', 'Natural', 'mimigo98@gmail.com', 0, NULL, '640ac5ca7aa06322ba343618e3ef8a4bf20d0ecc4aef650a2735b052ad9e3eca27e0433a73da18380ed27a30b784bf45aceadc6d6bbd71410151e80d24a33d5e', 1, 76, '2020-09-10 07:47:08', 9999, 9999, 'nowhere', '[]', '{\"data\": false, \"image\": false, \"geo\": false}', 0, 0, 0),
(42, 'Misha', 'Misha2020-09-14_182539.418291_2020-08-26_14.39.58.png', NULL, NULL, NULL, NULL, 'Misha2020-09-14_182539.418291_2020-08-26_14.39.58.png', 'Misha', 'Orlov', 'Male', 'Natural', 'razin-ivan98@ya.ru', 0, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 1, 34, '2020-09-14 18:28:42', 55.755241, 37.617779, 'Россия, Москва, Красная площадь, 1', '[]', '{\"data\": false, \"image\": false, \"geo\": false}', 1, 1, 1),
(43, '12345', '123452020-09-16_114811.959859450_polskaya-podgalyanskaya-ovcharka_2.jpg', NULL, NULL, NULL, NULL, '123452020-09-16_114811.959859450_polskaya-podgalyanskaya-ovcharka_2.jpg', 'FirstName', 'LastName', 'Female', 'Gomosexual', 'razin-ivn98@ya.ru', 20, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 1, 101, '2020-09-16 11:52:04', 55.7555481752853, 37.61708507662514, 'Россия, Москва, Красная площадь, 1', '[\"lol\",\"kek\"]', '{\"data\": false, \"image\": false, \"geo\": false}', 1, 1, 1),
(44, '54321', '543212020-09-16_115300.073875800dcefc03160a9942571df254ac1fa9.jpg', NULL, NULL, NULL, NULL, '543212020-09-16_115300.073875800dcefc03160a9942571df254ac1fa9.jpg', 'Alexey', 'Navalny', 'Male', 'Gomosexual', 'razin-ivan98@ya.ru', 0, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 1, 43, '2020-09-16 11:58:39', 55.7555179239358, 37.61709044104316, 'Россия, Москва, Красная площадь, 1', '[\"vor\"]', '{\"data\": false, \"image\": false, \"geo\": false}', 1, 1, 1),
(45, 'Tom', NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '0', '0', '0', 0, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 0, 43, '2020-09-10 15:20:32', 9999, 9999, 'nowhere', '[]', '{\"data\": false, \"image\": false, \"geo\": false}', 0, 0, 0),
(46, 'Dimon', NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '0', '0', '0', 0, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 0, 43, '2020-09-02 15:20:40', 9999, 9999, 'nowhere', '[]', '{\"data\": false, \"image\": false, \"geo\": false}', 0, 0, 0),
(47, 'IvanIvan', 'IvanIvan2020-09-17_151019.6889006eHMhSMpkKw.jpg', NULL, NULL, NULL, NULL, 'IvanIvan2020-09-17_151019.6889006eHMhSMpkKw.jpg', 'Ivan', 'Kolivan', 'Female', 'Natural', 'rar@lol.com', 20, NULL, '6d63e9a2e60bea5a42dd4d4fea12869afeae248ae4c3ac5807f57afbccd1763b8272e8ed1d0dc801cd6a415fa762bc769293abdfdb956c2857861fe4c6ee7915', 1, 23, '2020-09-17 19:06:32', 55.755705481922845, 37.61842618113258, 'Россия, Москва, Никольская улица, 5/1с1', '[\"lol\",\"kek\"]', '{\"data\": false, \"image\": false, \"geo\": false}', 1, 1, 1);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `dialogs`
--
ALTER TABLE `dialogs`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `genders_list`
--
ALTER TABLE `genders_list`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `guests`
--
ALTER TABLE `guests`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `interests_list`
--
ALTER TABLE `interests_list`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `orientations_list`
--
ALTER TABLE `orientations_list`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `photos`
--
ALTER TABLE `photos`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `dialogs`
--
ALTER TABLE `dialogs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT для таблицы `guests`
--
ALTER TABLE `guests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT для таблицы `likes`
--
ALTER TABLE `likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT для таблицы `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT для таблицы `orientations_list`
--
ALTER TABLE `orientations_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
