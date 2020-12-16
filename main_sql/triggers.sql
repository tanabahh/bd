CREATE OR REPLACE FUNCTION delete_characteristic() RETURNS TRIGGER AS
$$
BEGIN
    DELETE FROM princess WHERE princess.id_character = OLD.id_character;
    DELETE FROM bogatyr WHERE bogatyr.id_character = OLD.id_character;
    DELETE FROM animal WHERE animal.id_character = OLD.id_character;
    DELETE FROM commander WHERE commander.id_commander = OLD.id_character;
    DELETE FROM villain WHERE villain.id_character = OLD.id_character;
    DELETE FROM wizard WHERE wizard.id_character = OLD.id_character;
    DELETE FROM king WHERE king.id_character = OLD.id_character;
    DELETE FROM story_character WHERE story_character.id_character = OLD.id_character;
    DELETE FROM resident WHERE resident.id_character = OLD.id_character;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER character_delete
    AFTER DELETE
    ON character
    FOR EACH ROW
EXECUTE PROCEDURE delete_characteristic();


CREATE OR REPLACE FUNCTION delete_story() RETURNS TRIGGER AS
$$
BEGIN
    DELETE FROM story_character WHERE story_character.id_fairy_tale = OLD.id_fairy_tale;
    DELETE FROM story_location WHERE story_location.id_fairy_tale = OLD.id_fairy_tale;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER fairy_tale_delete
    AFTER DELETE
    ON fairy_tale
    FOR EACH ROW
EXECUTE PROCEDURE delete_story();




CREATE OR REPLACE FUNCTION delete_user() RETURNS TRIGGER AS
$$
BEGIN
    DELETE FROM fairy_tale WHERE fairy_tale.id_author = OLD.id_user;
    DELETE FROM bookshelf WHERE bookshelf.id_user = OLD.id_user;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER user_delete
    AFTER DELETE
    ON users
    FOR EACH ROW
EXECUTE PROCEDURE delete_user();