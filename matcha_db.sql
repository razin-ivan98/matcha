-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Хост: db
-- Время создания: Сен 03 2020 г., 08:42
-- Версия сервера: 5.7.31
-- Версия PHP: 7.4.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `matcha_db`
--

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
(2, 'Ivan', 'QWERTY', '2020-03-01 03:56:38', 'Ivan', 0),
(3, 'Ivan', 'LOL', '2020-03-01 03:58:08', 'Ivan', 0),
(5, 'Irina', 'Ivan', '2020-09-01 13:15:19', 'Ivan', 4);

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
  `got` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `likes`
--

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
(49, 'Ivan', 'Irina', '2020-09-01 13:15:19', 'lol');

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
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `location` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `name`, `avatar`, `firstname`, `lastname`, `gender`, `orientation`, `email`, `rating`, `biography`, `password`, `confirmed`, `age`, `orientation_id`, `online`, `latitude`, `longitude`, `location`) VALUES
(29, 'Ivan', 'Ivan2020-09-02_104725.8023866eHMhSMpkKw.jpg', 'Ivan', 'Razin', 'Male', 'Natural', 'hjlkjk@l', 0, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 1, 0, 0, '2020-09-03 08:39:47', 55.755800773133785, 37.618613935763626, 'Россия, Москва, Никольская улица, 5/1с5'),
(30, 'Irina', '2019-12-07_160409.2405795.jpg', 'Irina', 'Krot', 'Female', 'Natural', 'hjlkjk@l', 0, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 1, 0, 0, '2020-03-03 22:37:36', 0, 0, ''),
(31, 'EvgeniyPonasenkov', '2019-12-07_160440.4013926.jpg', 'Evgeniy', 'Geniy', 'Male', 'Natural', 'Maestro@ya', 0, NULL, 'cde7190f13da5d30d02978a642a7ac14a3f5e75a32af5e7bbba98be62ea6145bf2f65baf2d6301e70c001babed36415d429466db9195d12905274b183cade09f', 1, 0, 0, '2020-03-03 16:14:09', 0, 0, ''),
(32, 'LOL', '2019-12-07_160506.3454037.JPG', 'khhj', 'Razin', 'Teapot', 'Pidor', 'hjlkjk@l', 0, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 1, NULL, NULL, '2020-03-03 16:14:04', 0, 0, ''),
(33, 'New', '2019-12-07_160535.9059893.jpg', 'sfvv', 'dvsvdv', 'Female', 'Gomosexual', 'vdvsv@rvbr', 0, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 1, NULL, NULL, '2020-03-03 16:14:10', 0, 0, ''),
(34, 'QWERTY', '2019-12-07_160605.4725239.gif', 'Aleksey', 'Petrovi4', 'Transgender', 'Gomosexual', 'jhjh@jjhl', 0, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 1, NULL, NULL, '2020-03-03 16:14:05', 0, 0, ''),
(35, 'Kek', '2019-12-07_160653.8234328.png', 'Kke', 'lol', 'Teapot', 'Pidor', 'hjlkjk@l', 0, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 1, NULL, NULL, '2020-03-03 16:14:07', 0, 0, ''),
(36, 'qqq', '2019-12-07_160720.9181081.jpg', 'Kostya', 'Marinenkov', 'Transgender', 'Bisexual', 'hjlkjk@l', 0, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 1, NULL, NULL, '2020-03-03 16:14:06', 0, 0, ''),
(37, 'yanazaya', '2019-12-07_160810.427570IMG_20190613_120632.jpg', 'Zaya', 'Yana', 'Female', 'Pidor', 'yz@yana.com', 0, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 1, NULL, NULL, '2020-03-03 16:14:02', 0, 0, ''),
(38, 'chorange', 'chorange2020-09-01_160751.301671BKphAb3n31M.jpg', 'Chorange', 'Dartwing', 'Female', 'Bisexual', 'lol@ya.com', 0, NULL, 'f6d1015e17df348f2d84b3b603648ae4bd14011f4e5b82f885e45587bcad48947d37d64501dc965c0f201171c44b656ee28ed9a5060aea1f2a336025320683d6', 1, NULL, NULL, '2020-09-02 10:59:30', 0, 0, '');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `likes`
--
ALTER TABLE `likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT для таблицы `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
