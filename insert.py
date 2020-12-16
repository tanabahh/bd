from datetime import datetime, timedelta
from random import random, choice, randint

USERS = 1000
VOTE = 1000
START = 1000
CHARACTERS = START*8
LOCATION = 1000
FAIRY_TALE = 1000
PARTICIPATION = 1000


def get_random_date(start_date, interval_days):
    return (datetime.strptime(start_date, '%Y-%m-%d %H:%M')
            + timedelta(days=randint(0, interval_days), hours=randint(0, 23),
                        minutes=randint(0, 59), seconds=randint(0, 59)))


def insert_into(table, fields, values, file):
    for i in range(len(values)):
        if isinstance(values[i], str) and values[i] != 'NULL':
            values[i] = '\'' + values[i] + '\''
        else:
            values[i] = str(values[i])
    values = [str(v) for v in values]
    command = f'INSERT INTO {table} ({", ".join(fields)}) VALUES ({", ".join(values)});\n'
    with open(file, 'a', encoding='utf-8') as f:
        f.write(command)


def generate_character(index, names, family_status):
    values_for_character = list()
    #values_for_character.append(index)
    name = names[choice(range(0, len(names)))]
    values_for_character.append(name[0])
    values_for_character.append(family_status[choice(range(0, len(family_status)))])
    values_for_character.append(get_random_date('2015-01-01 00:00', 5 * 365).strftime('%Y-%m-%d %H:%M:%S'))
    values_for_character.append(name[1])
    return values_for_character


def generate_all_characters():
    female_names = []
    names = []
    male_names = []
    nicknames = []
    family_status = ['женат/замужем', 'холост/а', 'вдовец/вдова', 'жених/невеста', 'влюблен/а']
    with open('character_name.csv', 'r', encoding='utf-8') as f:
        for s in f.readlines():
            arr = s.replace('\n', '').split(';')
            names.append(arr)
            if arr[1] == 'Ж':
                female_names.append(arr)
            else:
                male_names.append(arr)

    with open('character_nickname.csv', 'r', encoding='utf-8') as f:
        for s in f.readlines():
            arr = s.replace('\n', '')
            nicknames.append(arr)

    field = ['name', 'family_status', 'date_of_birth',
             'gender']
    # generate kings
    for i in range(START):
        king_field = ['id_character', 'start_time', 'end_time', 'wisdom']
        values_for_character = generate_character(i, male_names, family_status)
        values_for_king = list()
        values_for_king.append(i)
        start_time = get_random_date('2015-01-01 00:00', 5 * 365)
        values_for_king.append(start_time.strftime('%Y-%m-%d %H:%M:%S'))
        values_for_king.append((start_time + timedelta(days=randint(0, 365*10))).strftime('%Y-%m-%d %H:%M:%S'))
        values_for_king.append(randint(0, 100))
        insert_into('character', field, values_for_character, 'SQL/character.sql')
        insert_into('king', king_field, values_for_king, 'SQL/king.sql')

    # generate animal
    animals = list()
    with open('animal.csv', 'r', encoding='utf-8') as f:
        for s in f.readlines():
            arr = s.replace('\n', '')
            animals.append(arr)

    for i in range(START, START*2):
        animal_field = ['id_character', 'type', 'wisdom']
        values_for_character = generate_character(i, names, family_status)
        values_for_animal = list()
        values_for_animal.append(i)
        values_for_animal.append(animals[choice(range(0, len(animals)))])
        values_for_animal.append(randint(0, 100))
        insert_into('character', field, values_for_character, 'SQL/character.sql')
        insert_into('animal', animal_field, values_for_animal, 'SQL/animal.sql')

    # generate princess
    for i in range(START * 2, START * 3):
        princess_fields = ['id_character', 'sobriquet', 'beauty_level', 'mind_level']
        values_for_character = generate_character(i, female_names, family_status)
        values_for_princess = list()
        values_for_princess.append(i)
        nick = nicknames[choice(range(0, len(nicknames)))].replace('ый', 'ая')
        values_for_princess.append(nick)
        values_for_princess.append(randint(0, 100))
        values_for_princess.append(randint(0, 100))
        insert_into('character', field, values_for_character, 'SQL/character.sql')
        insert_into('princess', princess_fields, values_for_princess, 'SQL/princess.sql')

    # generate commander
    for i in range(START * 3, START * 4):
        commander_fields = ['id_commander','id_character', 'sobriquet', 'mind_level', 'number_of_conquests']
        values_for_character = generate_character(i, male_names, family_status)
        values_for_commander = list()
        values_for_commander.append(i - START*3)
        values_for_commander.append(i)
        values_for_commander.append(nicknames[choice(range(0, len(nicknames)))])
        values_for_commander.append(randint(0, 100))
        values_for_commander.append((randint(0, 100)))
        insert_into('character', field, values_for_character, 'SQL/character.sql')
        insert_into('commander', commander_fields, values_for_commander, 'SQL/commander.sql')

    # generate bogatyr
    for i in range(START * 4, START * 5):
        bogatyr_fields = ['id_character', 'id_commander', 'name']
        #values_for_character = generate_character(i, male_names, family_status)
        values_for_bogatyr = list()
        values_for_bogatyr.append(i)
        values_for_bogatyr.append(randint(0, START - 1))
        values_for_bogatyr.append(nicknames[choice(range(0, len(nicknames)))])
        #insert_into('character', field, values_for_character, 'SQL/character.sql')
        insert_into('bogatyr', bogatyr_fields, values_for_bogatyr, 'SQL/bogatyr.sql')

    # generate wizard
    for i in range(START * 5, START * 6):
        wizard_fields = ['id_character', 'ward', 'magic_level']
        values_for_character = generate_character(i, names, family_status)
        values_for_wizard = list()
        values_for_wizard.append(i)
        values_for_wizard.append(randint(0, 100))
        values_for_wizard.append(randint(0, 100))
        insert_into('character', field, values_for_character, 'SQL/character.sql')
        insert_into('wizard', wizard_fields, values_for_wizard, 'SQL/wizard.sql')

    # generate villian
    for i in range(START * 6, START * 7):
        villain_fields = ['id_character', 'enemies', 'damage']
        values_for_character = generate_character(i, names, family_status)
        values_for_villain = list()
        values_for_villain.append(i)
        values_for_villain.append(randint(0, 100))
        values_for_villain.append(randint(0, 100))
        insert_into('character', field, values_for_character, 'SQL/character.sql')
        insert_into('villain', villain_fields, values_for_villain, 'SQL/villain.sql')


def generate_users():
    roles = ['Медный статус', 'Серебрянный статус', 'Золотой статус', 'Платиновый статус', 'Бриллиантовый статус']
    names = []
    with open('user_name.csv', 'r', encoding='utf-8') as f:
        for s in f.readlines():
            arr = s.replace('\n', "").split(';')
            names.append(arr[1])

    for i in range(USERS):
        table_name = 'users'
        field = ['role', 'nick', 'score', 'registration_date']
        values = list()
        # values.append(i)
        values.append(roles[choice(range(0, len(roles)))])
        values.append(
            names[choice(range(0, len(names)))] + str(i))
        values.append(randint(0, 100))
        values.append(get_random_date('2015-01-01 00:00', 5 * 365).strftime('%Y-%m-%d %H:%M:%S'))
        insert_into(table_name, field, values, 'SQL/insert_user.sql')


def generate_vote(fairy_tale):
    type = ['Создание', 'Редактирование', 'Удаление']
    table_name = 'vote'
    field = ['type', 'start_time', 'end_time', 'content', 'bet']
    for i in range(VOTE):
        values = list()
        # values.append(i)
        values.append(type[choice(range(0, len(type)))])
        start_time = get_random_date('2015-01-01 00:00', 6 * 365)
        values.append(start_time.strftime('%Y-%m-%d %H:%M:%S'))
        values.append((start_time + timedelta(days=randint(0, 90))).strftime('%Y-%m-%d %H:%M:%S'))
        values.append(fairy_tale[choice(range(0, len(fairy_tale)))])
        values.append(randint(1, 10))
        insert_into(table_name, field, values, 'SQL/vote.sql')


def generate_location():
    field = ['id_state', 'name']
    countries = []
    with open('country.csv', 'r', encoding='utf-8') as f:
        for s in f.readlines():
            arr = s.replace('\n', "").split(';')
            countries.append(arr[2].replace('\"', ""))
    for i in range(LOCATION):
        values = list()
        # values.append(i)
        state = randint(-10000, i-1)
        if state > 0:
            values.append(state)
        else:
            values.append('NULL')
        values.append(countries[choice(range(0, len(countries)))])
        insert_into('location', field, values, 'SQL/location.sql')


def generate_fairy_tale(fairy_tale):
    names = []
    with open('character_name.csv', 'r', encoding='utf-8') as f:
        for s in f.readlines():
            arr = s.replace('\n', '').split(';')
            names.append(arr[0])
    field = ['name', 'id_author', 'rating', 'content', 'creating_date']
    for i in range(FAIRY_TALE):
        values = list()
        # values.append(i)
        values.append('Cказка о '+names[choice(range(0, len(names)))])
        values.append(randint(0, USERS - 1))
        values.append(randint(0, 100))
        index = choice(range(0, len(fairy_tale)-3))
        content = fairy_tale[index] + fairy_tale[index+1] + fairy_tale[index+2]
        values.append(content)
        values.append(get_random_date('2015-01-01 00:00', 6 * 365).strftime('%Y-%m-%d %H:%M:%S'))
        insert_into('fairy_tale', field, values, 'SQL/fairy_tale.sql')


def generate_participation():
    status = ['За', 'Против']
    values = list()
    for i in range(PARTICIPATION):
        a = randint(0, VOTE-1)
        b = randint(0, USERS-1)
        values.append([a, b])
    new_values = list()
    for i in values:
        if i not in new_values:
            new_values.append(i)
    for i in range(len(new_values)):
        values_right = new_values[i]
        values_right.append(status[choice(range(0, len(status)))])
        insert_into('participating', ['id_vote', 'id_user', 'user_status'], values_right, 'SQL/participation.sql')


def generate_mane_to_many(max_index_1, max_index_2, table_name, field, file_name, count):
    values = list()
    for i in range(count):
        a = randint(0, max_index_1 - 1)
        b = randint(0, max_index_2 - 1)
        values.append([a, b])
    new_values = list()
    for i in values:
        if i not in new_values:
            new_values.append(i)
    for i in range(len(new_values)):
        insert_into(table_name, field, new_values[i], file_name)


if __name__ == '__main__':
    fairy_tale = []
    with open('fairy_tale.csv', 'r', encoding='utf-8') as f:
        for s in f.readlines():
            arr = s.replace('\n', "").replace('     ', '').replace("\"", '').replace("\'", '')
            fairy_tale.append(arr)
    generate_users()
    generate_all_characters()
    generate_vote(fairy_tale)
    generate_location()
    generate_fairy_tale(fairy_tale)
    generate_mane_to_many(VOTE, FAIRY_TALE, 'requests', ['id_vote', 'id_fairy_tale'], 'SQL/requests.sql', 100)
    generate_mane_to_many(CHARACTERS, LOCATION, 'resident', ['id_character', 'id_location'], 'SQL/resident.sql', 100)
    generate_mane_to_many(FAIRY_TALE, LOCATION, 'story_location', ['id_fairy_tale', ' id_location'], 'SQL/story_location.sql', 100)
    generate_mane_to_many(FAIRY_TALE, CHARACTERS, 'story_character', ['id_fairy_tale', 'id_character'], 'SQL/story_character.sql', 100)
    generate_mane_to_many(USERS, FAIRY_TALE, 'bookshelf', ['id_user', 'id_fairy_tale'], 'SQL/bookshelf.sql', 100)
    generate_participation()
    print('eee')

