create table if not exists Genre(
	genre_id serial primary key,
	genre_name varchar(80) not NULL
);


create table if not exists Executor(
	singer_id serial primary key,
	singers_name varchar(80) not null
);


create table if not exists Singers_genres(
	singer_id integer references Executor(singer_id),
	genre_id integer references Genre(genre_id),
	constraint pk primary key (singer_id, genre_id)
);


insert into Executor(singers_name) values ('Chick Corea'), ('Weather Report'), ('Deep Forest'), ('Enigma'), ('Frank Turner');
insert into Genre(genre_name) values ('Jazz Fusion'), ('Ethno House'), ('Acoustic Punk');


INSERT INTO Singers_genres(genre_id, singer_id) VALUES
(1, 1), (1, 2), 
(2, 3), (2, 4), 
(3, 5);


create table if not exists Album_artist(
	album_id serial primary key,
	singers_id INTEGER references Executor(singer_id)
);



create table if not exists Music_album(
	name_album varchar(80) not NULL,
	singers_id INTEGER references Executor(singer_id),
	album_id integer references Album_artist(album_id)
);

insert into Music_album(name_album) values ('Return to Forever'), ('Heavy Weather'), ('Head Hunters'), ('Deep Forest'), ('MCMXC a.D.'), ('Volume 3: Further in Time'), ('England Keep My Bones'), ('Talon of the Hawk'), ('Violent Femmes');

INSERT INTO Music_album(name_album, singers_id) VALUES
('Return to Forever', 1), 
('Heavy Weather', 2), 
('Head Hunters', 2), 
('Deep Forest', 3), 
('MCMXC a.D.', 4), 
('Volume 3: Further in Time', 4), 
('England Keep My Bones', 4), 
('Talon of the Hawk', 5), 
('Violent Femmes', 5);

create table if not exists Trak(
	trak_id serial primary key,
	trak_name varchar(80) not NULL,
	track_duration INTERVAL,
	album_id integer references Album_artist(album_id)
);

insert into Trak(trak_name) values ('Spain'), ('Crystal Silence'), ('Birdland'), ('A Remark You Made'), ('MCMXC a.D.'), ('Chameleon'), ('England Keep My Bones'), ('Watermelon Man'), ('Violent Femmes');
INSERT INTO Trak(trak_name, album_id) VALUES
('Spain', (SELECT album_id FROM Album_artist WHERE singers_id = 1)),
('Crystal Silence', (SELECT album_id FROM Album_artist WHERE singers_id = 2)), 
('Birdland', (SELECT album_id FROM Album_artist WHERE singers_id = 2)), 
('A Remark You Made', (SELECT album_id FROM Album_artist WHERE singers_id = 2)), 
('MCMXC a.D.', (SELECT album_id FROM Album_artist WHERE singers_id = 3)), 
('Chameleon', (SELECT album_id FROM Album_artist WHERE singers_id = 4)), 
('England Keep My Bones', (SELECT album_id FROM Album_artist WHERE singers_id = 4)), 
('Watermelon Man', (SELECT album_id FROM Album_artist WHERE singers_id = 5)), 
('Violent Femmes', (SELECT album_id FROM Album_artist WHERE singers_id = 5));

UPDATE Trak
SET track_duration = '00:03:30' 
WHERE trak_name = 'Spain';

UPDATE Trak
SET track_duration = '00:06:55' 
WHERE trak_name = 'Crystal Silence';

UPDATE Trak
SET track_duration = '00:05:59' 
WHERE trak_name = 'Birdland';

UPDATE Trak
SET track_duration = '00:06:54' 
WHERE trak_name = 'A Remark You Made';

UPDATE Trak
SET track_duration = '00:04:43' 
WHERE trak_name = 'MCMXC a.D.';

UPDATE Trak
SET track_duration = '00:15:41' 
WHERE trak_name = 'Chameleon';

UPDATE Trak
SET track_duration = '00:03:57' 
WHERE trak_name = 'England Keep My Bones';

UPDATE Trak
SET track_duration = '00:06:28' 
WHERE trak_name = 'Watermelon Man';

UPDATE Trak
SET track_duration = '00:03:35' 
WHERE trak_name = 'Violent Femmes';




create table if not exists Collection(
	collection_id serial primary key,
	collection_name varchar(80) not NULL,
	collection_release_date DATE
);

insert into Collection(collection_name) values ('Jazz Fusion Masterpieces'), ('Ethno Beats: Global Rhythms'), ('Punk Unplugged: Acoustic Anthems'), ('Timeless Tracks: Jazz, World, and Punk');

create table if not exists Collection_trak(
	collection_id integer references Collection(collection_id),
	trak_id INTEGER references Trak(trak_id)
);

INSERT INTO Collection_trak(collection_id, trak_id)
SELECT
    1, trak_id
FROM
    Trak
WHERE
    trak_name IN ('Spain', 'Crystal Silence', 'Birdland');

INSERT INTO Collection_trak(collection_id, trak_id)
SELECT
    2, trak_id
FROM
    Trak
WHERE
    trak_name IN ('MCMXC a.D.', 'Chameleon');


INSERT INTO Collection_trak(collection_id, trak_id)
SELECT
    3, trak_id
FROM
    Trak
WHERE
    trak_name IN ('England Keep My Bones', 'Watermelon Man');

INSERT INTO Collection_trak(collection_id, trak_id)
SELECT
    4, trak_id
FROM
    Trak
WHERE
    trak_name IN ('Violent Femmes');
   
UPDATE Collection
SET collection_release_date = '2019-05-15' 
WHERE collection_name = 'Violent Femmes';

UPDATE Collection
SET collection_release_date = '2020-08-10' 
WHERE collection_name = 'Ethno Beats: Global Rhythms';

UPDATE Collection
SET collection_release_date = '2018-11-20' 
WHERE collection_name = 'Punk Unplugged: Acoustic Anthems';

UPDATE Collection
SET collection_release_date = '2017-12-30' 
WHERE collection_name = 'Timeless Tracks: Jazz, World, and Punk';
   
   

SELECT trak_name, track_duration FROM Trak 
ORDER BY track_duration DESC, trak_name 
LIMIT 1;

SELECT trak_name, track_duration FROM Trak 
where track_duration >= '00:03:30';

SELECT collection_name, collection_release_date FROM Collection
where collection_release_date between '2018-01-01'::date AND '2020-12-31'::date;
   
SELECT singers_name FROM Executor
WHERE singers_name NOT LIKE '% %';

SELECT trak_name FROM Trak
WHERE trak_name like '%My%';


SELECT genre_name, COUNT(singer_id)
FROM Genre
LEFT JOIN Singers_genres ON Genre.genre_id = Singers_genres.genre_id
GROUP BY Genre.genre_name;


select count(*) from Trak
FULL join Album_artist on Trak.album_id = Album_artist.album_id 
FULL join Collection  on Album_artist.album_id = Collection.collection_id 
WHERE extract(year from Collection.collection_release_date) BETWEEN EXTRACT(year FROM TO_DATE('2019-01-01', 'YYYY-MM-DD')) AND EXTRACT(year FROM TO_DATE('2020-12-31', 'YYYY-MM-DD'));

select AVG(track_duration) from trak
left join music_album on trak.trak_id = music_album.album_id;

select singers_name from executor 
left join Album_artist on executor.singer_id = Album_artist.album_id 
left join Collection  on Album_artist.album_id = Collection.collection_id 
WHERE collection_release_date IS NULL OR EXTRACT(YEAR FROM collection_release_date) != 2020;
--where collection_release_date is null or collection_release_date != 2020;


select collection_name from collection 
left join executor on executor.singer_id = collection.collection_id 
where singers_name like 'Chick Corea';





--SELECT COUNT(DISTINCT artist_id) FROM Artists
--GROUP BY genre;

--SELECT collection_name, collection_release_date FROM Genre
--where collection_release_date between '2019-01-01'::date AND '2020-12-31'::date;

--SELECT Albums.album_name, AVG(EXTRACT(epoch FROM track_duration)) AS avg_duration_seconds
--FROM Tracks
--JOIN Albums ON Tracks.album_id = Albums.album_id
--GROUP BY Albums.album_name;