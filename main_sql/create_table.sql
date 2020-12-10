--tale

CREATE TABLE character(
	id_character serial PRIMARY KEY,
	name varchar(30) NOT NULL,
	family_status varchar(20),
	date_of_birth timestamp NOT NULL DEFAULT current_timestamp,
	gender varchar(1) CONSTRAINT valid_gender CHECK(gender = 'М' OR gender = 'Ж' OR gender = NULL)
);

CREATE TABLE king(
	id_character integer PRIMARY KEY REFERENCES character ON DELETE RESTRICT ON UPDATE RESTRICT, --хм, а зачем не очень поняла //характеристика персонажа. примари кей чтобы был юник и нот нал + целостность данных 
	start_time date NOT NULL,
	end_time date, -- а если еще не закончил правление //done!
	CONSTRAINT king_reign CHECK(start_time <= end_time),
	wisdom integer DEFAULT 0 -- может по дефолту таки 0 ставить? //done!
);

CREATE TABLE animal(
	id_character integer PRIMARY KEY REFERENCES character ON DELETE RESTRICT ON UPDATE RESTRICT,
	type varchar(50),
	wisdom integer DEFAULT 0 -- тоже мб 0 //done
);

CREATE TABLE princess(
	id_character integer PRIMARY KEY REFERENCES character ON DELETE RESTRICT ON UPDATE RESTRICT,
	--возможно unique (taisia -- а может везде добавить unique для характеристик персонажей) //done
	sobriquet varchar(70), -- а возможно и нет
	beauty_level integer DEFAULT 0, -- 0? //done
	mind_level integer DEFAULT 0 -- 0? //done
);

CREATE TABLE commander( 
	id_commander serial PRIMARY KEY,
	id_character integer REFERENCES character ON DELETE RESTRICT ON UPDATE RESTRICT,
	sobriquet varchar(70),
	mind_level integer DEFAULT 0, -- 0? //done
	number_of_conquests integer CONSTRAINT positiv_conquests CHECK(number_of_conquests >= 0)
);

CREATE TABLE bogatyr(
	id_character integer PRIMARY KEY REFERENCES character ON DELETE RESTRICT ON UPDATE RESTRICT,
	id_commander integer REFERENCES commander ON DELETE RESTRICT ON UPDATE RESTRICT,
	name varchar(70)
);

CREATE TABLE wizard(
	id_character integer PRIMARY KEY REFERENCES character ON DELETE RESTRICT ON UPDATE RESTRICT,
	--integer??????????????????? (taisia-- что за вопрос?)
	ward integer DEFAULT 0, -- 0? //done
	magic_level integer DEFAULT 0 --0? //done
);

CREATE TABLE villain(
	id_character integer PRIMARY KEY REFERENCES character ON DELETE RESTRICT ON UPDATE RESTRICT,
	enemies integer,
	damage integer DEFAULT 0 -- 0? //done
);


--system
CREATE TABLE users
(
	id_user serial PRIMARY KEY,
	role varchar(20) NOT NULL,
	nick varchar(30) NOT NULL UNIQUE,
	score integer NOT NULL DEFAULT 20,
	registration_date timestamp NOT NULL DEFAULT current_timestamp
);

CREATE TABLE vote(
	id_vote serial PRIMARY KEY,
	type varchar(50) NOT NULL,
	start_time timestamp NOT NULL,
	end_time timestamp NOT NULL, -- а бесконечные опросы нельзя?) //лишняя память. Даж гугл драйв сейчас удаляет с корзины если 30 дней прошло.
	CONSTRAINT voting_period CHECK(start_time <= end_time),
	content varchar(100) NOT NULL,
	bet integer NOT NULL CONSTRAINT positiv_bet CHECK(bet > 0)
);

--tasia

CREATE TABLE participating(
    id_vote integer references vote ON DELETE RESTRICT ON UPDATE RESTRICT,
    id_user integer references users ON DELETE RESTRICT ON UPDATE RESTRICT, --а у нас могут быть анонимные опросы? // не. нафиг надо
    user_status varchar(100) NOT NULL, -- Not null? //done!
    primary key(id_vote, id_user)
);

--tale

CREATE TABLE fairy_tale(
    id_fairy_tale serial primary key,
    name varchar(100) NOT NULL,
    id_author integer references users NOT NULL,
    rating integer DEFAULT 0,
    content text,
    creating_date timestamp NOT NULL DEFAULT current_timestamp
);

CREATE TABLE requests( -- тут нужен какой-то клюдч? или он автоматом создается. Я просто что-то не понимаю //done!
    id_vote integer references vote ON DELETE RESTRICT ON UPDATE RESTRICT,
    id_fairy_tale integer references fairy_tale ON DELETE RESTRICT ON UPDATE RESTRICT,
    primary key(id_vote, id_fairy_tale)
);

CREATE TABLE location(
    id_location serial PRIMARY KEY,
    id_state integer references location,
    name varchar(100) NOT NULL
);
CREATE TABLE resident( -- тут нужен какой-то клюдч? или он автоматом создается. Я просто что-то не понимаю
    id_character integer references character ON DELETE RESTRICT ON UPDATE RESTRICT,
    id_location integer references location ON DELETE RESTRICT ON UPDATE RESTRICT,
    primary key(id_character, id_location)
);

CREATE TABLE story_location(-- тут нужен какой-то клюдч? или он автоматом создается. Я просто что-то не понимаю
  id_fairy_tale integer references fairy_tale ON DELETE RESTRICT ON UPDATE RESTRICT,
  id_location integer references location ON DELETE RESTRICT ON UPDATE RESTRICT,
  primary key(id_fairy_tale, id_location)
);

CREATE TABLE story_character(-- тут нужен какой-то клюдч? или он автоматом создается. Я просто что-то не понимаю
    id_fairy_tale integer references fairy_tale ON DELETE RESTRICT ON UPDATE RESTRICT,
    id_character integer references character ON DELETE RESTRICT ON UPDATE RESTRICT,
    primary key(id_fairy_tale, id_character)
);

--system
CREATE TABLE bookshelf(-- тут нужен какой-то клюдч? или он автоматом создается. Я просто что-то не понимаю
    id_user integer references users ON DELETE RESTRICT ON UPDATE RESTRICT,
    id_fairy_tale integer references fairy_tale ON DELETE RESTRICT ON UPDATE RESTRICT,
    primary key(id_user, id_fairy_tale)
);
