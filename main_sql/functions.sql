--1
create or replace function createNewBook(userId int, bookName text) returns text as $$
declare
    id_ft int;
begin
    insert into fairy_tale(name, id_author) values (bookName, userId) returning id_fairy_tale into id_ft;
    insert into bookshelf values (userId, id_ft);
    return 'Ваша новая книга создана! id - ' || id_ft;
end;
$$ language plpgsql;

--2
create or replace function createKing(characterName text, end_time timestamp, w int) returns text as $$
declare
    id_ch int;
begin
    insert into character(name) values (characterName) returning id_character into id_ch;
    insert into king (id_character, end_time, wisdom) values (id_ch);
    return 'Король создан! id - ' || id_ch;
end;
$$ language plpgsql;

--3
create or replace function createAnimal(characterName text, animalWisdom int, animalType text) returns text as $$
declare
    id_ch int;
begin
    insert into character(name) values (characterName) returning id_character into id_ch;
    insert into animal(id_character, wisdom, type) values (id_ch, animalWisdom, animalType);
    return 'Зверек создан! id - ' || id_ch;
end;
$$ language plpgsql;

--4
create or replace function createPrincess(characterName text, pSobrequet text, pBeuty int, pMind int) returns text as $$
declare
    id_ch int;
begin
    insert into character(name) values (characterName) returning id_character into id_ch;
    insert into princess(id_character, sobriquet, beauty_level, mind_level) values (id_ch, pSobrequet, pBeuty, pMind);
    return 'Принцесса создана! id - ' || id_ch;
end;
$$ language plpgsql;

--4
create or replace function createCommander(characterName text, cSobrequet text, cNum int, cMind int) returns text as $$
declare
    id_ch int;
begin
    insert into character(name) values (characterName) returning id_character into id_ch;
    insert into commander(id_commander, sobriquet, mind_level, number_of_conquests) values (id_ch, cSobrequet, cMind, cNum);
    return 'Командир создан! id - ' || id_ch;
end;
$$ language plpgsql;

--4
create or replace function createBogatyr(characterName text) returns text as $$
declare
    id_ch int;
begin
    insert into character(name) values (characterName) returning id_character into id_ch;
    insert into bogatyr(id_commander, name) values (id_ch, characterName);
    return 'Богатырь создан! id - ' || id_ch;
end;
$$ language plpgsql;

--5
create or replace function createWizard(characterName text, wWard int, wMagic int) returns text as $$
declare
    id_ch int;
begin
    insert into character(name) values (characterName) returning id_character into id_ch;
    insert into wizard(id_character, ward, magic_level) values (id_ch, wWard, wMagic);
    return 'Волшебник создан! id - ' || id_ch;
end;
$$ language plpgsql;

--5
create or replace function createVillain(characterName text, vEnemies int, vDamage int) returns text as $$
declare
    id_ch int;
begin
    insert into character(name) values (characterName) returning id_character into id_ch;
    insert into villain(id_character, enemies, damage) values (id_ch, vEnemies, vDamage);
    return 'Волшебник создан! id - ' || id_ch;
end;
$$ language plpgsql;

--6
create or replace function calculateVotes(idVote int) returns text as $$
declare
    yesCnt int;
    noCnt int;
begin
    select count(*) from participating where id_vote = idVote and user_status = 'За' into yesCnt;
    select count(*) from participating where id_vote = idVote and user_status = 'Против' into noCnt;
    return 'Результаты: За - ' || yesCnt || ', Против - ' || noCnt;
end;
$$ language plpgsql;
