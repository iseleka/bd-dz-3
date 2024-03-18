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

create table if not exists Album_artist(
	album_id serial primary key,
	singers_id INTEGER references Executor(singer_id)
);


create table if not exists Music_album(
	name_album varchar(80) not NULL,
	singers_id INTEGER references Executor(singer_id),
	album_id integer references Album_artist(album_id)
);



create table if not exists Trak(
	trak_id serial primary key,
	trak_name varchar(80) not NULL,
	track_duration INTERVAL,
	album_id integer references Album_artist(album_id)
);


create table if not exists Collection(
	collection_id serial primary key,
	collection_name varchar(80) not NULL,
	collection_release_date DATE
);


create table if not exists Collection_trak(
	collection_id integer references Collection(collection_id),
	trak_id INTEGER references Trak(trak_id)
);

