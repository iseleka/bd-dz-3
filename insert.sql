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

