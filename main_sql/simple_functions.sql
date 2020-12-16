SELECT users.nick, fairy_tale.name
FROM users, fairy_tale
WHERE users.id_user = fairy_tale.id_author;


SELECT princess.sobriquet, location.name
FROM princess, location, resident
WHERE princess.id_character = resident.id_character and resident.id_location = location.id_location;


SELECT fairy_tale.name FROM fairy_tale
WHERE fairy_tale.creating_date > '12-12-2000';


select id_character from character
where date_of_birth < '2015-03-03';


select name from fairy_tale
where creating_date < '2015-03-03' and rating > 30;


SELECT character.name, location.name from character
INNER JOIN resident ON character.id_character = resident.id_character
INNER JOIN location ON location.id_location = resident.id_location
INNER JOIN king ON king.id_character = character.id_character
WHERE king.end_time < '12-10-2010';

SELECT fairy_tale.name, users.nick FROM users
INNER JOIN bookshelf ON users.id_user = bookshelf.id_user
INNER JOIN fairy_tale on bookshelf.id_user = fairy_tale.id_fairy_tale
WHERE users.score > 50;



create index on character(date_of_birth);
create index on users(registration_date);
create index on fairy_tale(creating_date);
create index on fairy_tale(rating);
create index on fairy_tale using hash(id_author);


