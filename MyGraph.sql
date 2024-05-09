USE MASTER
GO
DROP DATABASE IF EXISTS MyGraph
GO
CREATE DATABASE MyGraph
GO
USE MyGraph
GO

-- Создание таблицы пользователей (Users)
CREATE TABLE Users (
    id INT PRIMARY KEY,
    username VARCHAR(255),
    email VARCHAR(255),
    birthdate DATE,
    location VARCHAR(255)
) AS NODE;

-- Создание таблицы постов (Posts)
CREATE TABLE Posts (
    id INT PRIMARY KEY,
    content TEXT,
    timestamp DATETIME,
) AS NODE;

-- Создание таблицы тегов (Tags)
CREATE TABLE Tags (
    id INT PRIMARY KEY,
    name VARCHAR(255)
) AS NODE;

-- Создание таблицы дружб (Friendships)
CREATE TABLE Friendships (startdate DATETIME) AS EDGE;

-- Создание таблицы подписок на теги (Subscriptions)
CREATE TABLE Subscriptions (
    startdate DATETIME,
) AS EDGE;

-- Создание таблицы выпуска постов (PostPublishes)
CREATE TABLE PostPublishes (
    [timestamp] DATETIME,
) AS EDGE;


-- Заполнение таблицы пользователей (Users)
INSERT INTO Users (id, username, email, birthdate, location) VALUES
(1, 'user1', 'user1@example.com', '1990-01-01', 'New York'),
(2, 'user2', 'user2@example.com', '1995-05-15', 'Los Angeles'),
(3, 'user3', 'user3@example.com', '1988-09-20', 'London'),
(4, 'user4', 'user4@example.com', '1983-03-10', 'Paris'),
(5, 'user5', 'user5@example.com', '1992-11-25', 'Tokyo'),
(6, 'user6', 'user6@example.com', '1998-07-02', 'Sydney'),
(7, 'user7', 'user7@example.com', '1985-12-12', 'Berlin'),
(8, 'user8', 'user8@example.com', '1991-04-18', 'Moscow'),
(9, 'user9', 'user9@example.com', '1996-08-08', 'Toronto'),
(10, 'user10', 'user10@example.com', '1987-06-30', 'Rio de Janeiro');

-- Заполнение таблицы постов (Posts)
INSERT INTO Posts (id, content, timestamp) VALUES
(1, 'Content of post 1', '2024-05-09 10:00:00'),
(2, 'Content of post 2', '2024-05-09 12:30:00'),
(3, 'Content of post 3', '2024-05-09 14:45:00'),
(4, 'Content of post 4', '2024-05-09 16:20:00'),
(5, 'Content of post 5', '2024-05-09 18:00:00'),
(6, 'Content of post 6', '2024-05-09 20:15:00'),
(7, 'Content of post 7', '2024-05-09 22:10:00'),
(8, 'Content of post 8', '2024-05-09 23:55:00'),
(9, 'Content of post 9', '2024-05-10 01:30:00'),
(10, 'Content of post 10', '2024-05-10 03:20:00');

-- Заполнение таблицы тегов (Tags)
INSERT INTO Tags (id, name) VALUES
(1, 'tag1'),
(2, 'tag2'),
(3, 'tag3'),
(4, 'tag4'),
(5, 'tag5'),
(6, 'tag6'),
(7, 'tag7'),
(8, 'tag8'),
(9, 'tag9'),
(10, 'tag10');

INSERT INTO Friendships ($from_id, $to_id, startdate)
VALUES ((SELECT $node_id FROM Users WHERE id = 1),
 (SELECT $node_id FROM Users WHERE id = 2), '2023-01-01 10:00:00'),
 ((SELECT $node_id FROM Users WHERE id = 10),
 (SELECT $node_id FROM Users WHERE id = 5), '2023-01-05 10:00:00'),
 ((SELECT $node_id FROM Users WHERE id = 2),
 (SELECT $node_id FROM Users WHERE id = 9), '2023-01-10 10:00:00'),
 ((SELECT $node_id FROM Users WHERE id = 3),
 (SELECT $node_id FROM Users WHERE id = 1), '2023-01-05 10:00:00'),
 ((SELECT $node_id FROM Users WHERE id = 3),
 (SELECT $node_id FROM Users WHERE id = 6), '2023-01-10 10:00:00'),
 ((SELECT $node_id FROM Users WHERE id = 4),
 (SELECT $node_id FROM Users WHERE id = 2), '2023-01-05 10:00:00'),
 ((SELECT $node_id FROM Users WHERE id = 5),
 (SELECT $node_id FROM Users WHERE id = 4), '2023-01-10 10:00:00'),
 ((SELECT $node_id FROM Users WHERE id = 6),
 (SELECT $node_id FROM Users WHERE id = 7), '2023-02-01 10:00:00'),
 ((SELECT $node_id FROM Users WHERE id = 6),
 (SELECT $node_id FROM Users WHERE id = 8), '2023-02-05 10:00:00'),
 ((SELECT $node_id FROM Users WHERE id = 8),
 (SELECT $node_id FROM Users WHERE id = 3), '2023-02-10 10:00:00');
GO
SELECT *
FROM Friendships;

INSERT INTO PostPublishes ($from_id, $to_id, [timestamp])
VALUES ((SELECT $node_id FROM Posts WHERE ID = 1),
 (SELECT $node_id FROM Users WHERE ID = 1), '2022-05-05 14:30:00'),
 ((SELECT $node_id FROM Posts WHERE ID = 5),
 (SELECT $node_id FROM Users WHERE ID = 1), '2022-05-10 14:30:00'),
 ((SELECT $node_id FROM Posts WHERE ID = 8),
 (SELECT $node_id FROM Users WHERE ID = 1), '2022-05-05 14:30:00'),
 ((SELECT $node_id FROM Posts WHERE ID = 2),
 (SELECT $node_id FROM Users WHERE ID = 2), '2022-05-10 14:30:00'),
 ((SELECT $node_id FROM Posts WHERE ID = 3),
 (SELECT $node_id FROM Users WHERE ID = 3), '2022-06-05 14:30:00'),
 ((SELECT $node_id FROM Posts WHERE ID = 4),
 (SELECT $node_id FROM Users WHERE ID = 3), '2022-06-10 14:30:00'),
 ((SELECT $node_id FROM Posts WHERE ID = 6),
 (SELECT $node_id FROM Users WHERE ID = 4), '2022-06-05 14:30:00'),
 ((SELECT $node_id FROM Posts WHERE ID = 7),
 (SELECT $node_id FROM Users WHERE ID = 4), '2022-06-10 14:30:00'),
 ((SELECT $node_id FROM Posts WHERE ID = 1),
 (SELECT $node_id FROM Users WHERE ID = 9), '2022-06-05 14:30:00'),
 ((SELECT $node_id FROM Posts WHERE ID = 9),
 (SELECT $node_id FROM Users WHERE ID = 4), '2022-06-10 14:30:00'),
 ((SELECT $node_id FROM Posts WHERE ID = 10),
 (SELECT $node_id FROM Users WHERE ID = 9), '2022-07-05 14:30:00');
 GO
SELECT *
FROM PostPublishes;

INSERT INTO Subscriptions ($from_id, $to_id, startdate)
VALUES ((SELECT $node_id FROM Tags WHERE ID = 1),
 (SELECT $node_id FROM Users WHERE ID = 6), '2021-09-10 09:45:00'),
 ((SELECT $node_id FROM Tags WHERE ID = 5),
 (SELECT $node_id FROM Users WHERE ID = 1), '2021-09-05 09:45:00'),
 ((SELECT $node_id FROM Tags WHERE ID = 8),
 (SELECT $node_id FROM Users WHERE ID = 7), '2021-09-10 09:45:00'),
 ((SELECT $node_id FROM Tags WHERE ID = 2),
 (SELECT $node_id FROM Users WHERE ID = 2), '2021-10-05 09:45:00'),
 ((SELECT $node_id FROM Tags WHERE ID = 3),
 (SELECT $node_id FROM Users WHERE ID = 5), '2021-10-10 09:45:00'),
 ((SELECT $node_id FROM Tags WHERE ID = 4),
 (SELECT $node_id FROM Users WHERE ID = 3), '2021-10-05 09:45:00'),
 ((SELECT $node_id FROM Tags WHERE ID = 6),
 (SELECT $node_id FROM Users WHERE ID = 4), '2021-10-10 09:45:00'),
 ((SELECT $node_id FROM Tags WHERE ID = 7),
 (SELECT $node_id FROM Users WHERE ID = 2), '2021-10-05 09:45:00'),
 ((SELECT $node_id FROM Tags WHERE ID = 1),
 (SELECT $node_id FROM Users WHERE ID = 9), '2021-10-10 09:45:00'),
 ((SELECT $node_id FROM Tags WHERE ID = 9),
 (SELECT $node_id FROM Users WHERE ID = 8), '2021-11-05 09:45:00'),
 ((SELECT $node_id FROM Tags WHERE ID = 10),
 (SELECT $node_id FROM Users WHERE ID = 9), '2021-11-10 09:45:00');
 GO
SELECT *
FROM Subscriptions;

--Найти всех пользователей, которые подписаны на тег "tag1"
SELECT [User].username
FROM Users AS [User]
	, Subscriptions
	, Tags AS Tag
WHERE MATCH([Tag]-(Subscriptions)->[User])
	AND Tag.name = N'tag1';



--Найти всех пользователей, которые опубликовали посты после определенной даты
SELECT u.username
FROM Users u
	, PostPublishes
	, Posts p
WHERE MATCH(p-(PostPublishes)->u)
AND p.timestamp > '2021-05-09 14:30:00';

--Найти все посты, опубликованные пользователями, чье местоположение "New York"
SELECT p.content
FROM Posts p
	, Users u
	, PostPublishes
WHERE MATCH(p-(PostPublishes)->u)
AND u.location = 'New York';

--Найти всех пользователей, которые подписаны на тег "tag5":
SELECT [User].username
FROM Users AS [User]
	, Subscriptions
	, Tags AS Tag
WHERE MATCH([Tag]-(Subscriptions)->[User])
	AND Tag.name = N'tag5';

--Найти всех пользователей, у которых дата рождения меньше 1990 года и которые опубликовали посты:
SELECT u.username
FROM Users u
	, PostPublishes
	, Posts p
WHERE MATCH(u<-(PostPublishes)-p)
AND u.birthdate < '1990-01-01';

SELECT User1.username AS PersonName
 , STRING_AGG(User2.username, '->') WITHIN GROUP (GRAPH PATH)
AS Friends
FROM Users AS User1
 , Friendships FOR PATH AS fs
 , Users FOR PATH AS User2
WHERE MATCH(SHORTEST_PATH(User1(-(fs)->User2)+))
 AND User1.username = N'user1'; SELECT User1.username AS PersonName
 , STRING_AGG(User2.username, '->') WITHIN GROUP (GRAPH PATH)
AS Friends
FROM Users AS User1
 , Friendships FOR PATH AS fs
 , Users FOR PATH AS User2
WHERE MATCH(SHORTEST_PATH(User1(-(fs)->User2){1,2}))
 AND User1.username = N'user6'; SELECT User1.id AS IdFirst
	, User1.username AS First
	, CONCAT(N'friends', User1.id) AS [First image name]
	, User2.id AS IdSecond
	, User2.username AS Second
	, CONCAT(N'friends', User2.id) AS [Second image name]
FROM Users AS User1
 , Friendships AS fs
 , Users AS User2
WHERE MATCH(User1-(fs)->User2);SELECT [User].id AS IdFirst
	, [User].username AS First
	, CONCAT(N'friends', [User].id) AS [First image name]
	, Tag.id AS IdSecond
	, Tag.name AS Second
	, CONCAT(N'tags', Tag.id) AS [Second image name]
FROM Users AS [User]
	, Subscriptions AS ss
	, Tags AS Tag
WHERE MATCH(Tag-(ss)->[User]);

SELECT [User].id AS IdFirst
	, [User].username AS First
	, CONCAT(N'friends', [User].id) AS [First image name]
	, Post.id AS IdSecond
	, Post.content AS Second
	, CONCAT(N'posts', Post.id) AS [Second image name]
FROM Users AS [User]
	, PostPublishes AS pp
	, Posts AS Post
WHERE MATCH(Post-(pp)->[User]);
