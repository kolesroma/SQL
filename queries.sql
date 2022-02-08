# // //
# LAB 2
# \\ \\


# створення таблиць
create table armament
(
    id     int auto_increment
        primary key,
    name   varchar(32) not null,
    weight int         null,
    damage int         null,
    constraint armament_name_uindex
        unique (name)
);

create table army
(
    id          int auto_increment
        primary key,
    maxQuantity int         null,
    armyName    varchar(32) not null
);

create table commander
(
    id       int auto_increment
        primary key,
    age      int         null,
    weight   int         null,
    birthday date        null,
    surname  varchar(32) not null
);

create table division
(
    id          int auto_increment
        primary key,
    maxQuantity int  null,
    dateForming date null,
    armyID      int  null,
    constraint division_army_id_fk
        foreign key (armyID) references army (id)
);

create table district
(
    id          int auto_increment
        primary key,
    maxQuantity int  null,
    dateForming date null,
    divisionID  int  null,
    constraint district_division_id_fk
        foreign key (divisionID) references division (id)
);

create table militaryEquipment
(
    id            int auto_increment
        primary key,
    EquipmentName varchar(32) null,
    weight        int         null,
    speed         int         null,
    constraint militaryEquipment_EquipmentName_uindex
        unique (EquipmentName)
);

create table part
(
    id          int auto_increment
        primary key,
    maxQuantity int null,
    partCypher  int null,
    districtID  int null,
    constraint part_partCypher_uindex
        unique (partCypher),
    constraint part_district_id_fk
        foreign key (districtID) references district (id)
);

create table armament_part
(
    id         int auto_increment
        primary key,
    partID     int null,
    armamentID int null,
    constraint armament_part_armament_id_fk
        foreign key (armamentID) references armament (id),
    constraint armament_part_part_id_fk
        foreign key (partID) references part (id)
);

create table militaryEquipment_part
(
    id                  int auto_increment
        primary key,
    partID              int null,
    militaryEquipmentID int null,
    constraint militaryEquipment_part_militaryEquipment_id_fk
        foreign key (militaryEquipmentID) references militaryEquipment (id),
    constraint militaryEquipment_part_part_id_fk
        foreign key (partID) references part (id)
);

create table squadron
(
    id          int auto_increment
        primary key,
    maxQuantity int  null,
    dateForming date null,
    commanderID int  null,
    partID      int  null,
    constraint squadron_commander_id_fk
        foreign key (commanderID) references commander (id),
    constraint squadron_part_id_fk
        foreign key (partID) references part (id)
);

create table platoon
(
    id          int auto_increment
        primary key,
    maxQuantity int                       null,
    dateForming date default '2000-01-01' null,
    commanderID int                       null,
    squadronID  int                       null,
    constraint platoon_commander_id_fk
        foreign key (commanderID) references commander (id),
    constraint platoon_squadron_id_fk
        foreign key (squadronID) references squadron (id)
);

insert into commander
values (5, 60, 80, '2000-12-12', 'zukov');

create table department
(
    id          int auto_increment
        primary key,
    maxQuantity int  null,
    commanderID int  null,
    dateForming date null,
    platoonID   int  null,
    constraint department_commander_id_fk
        foreign key (commanderID) references commander (id),
    constraint department_platoon_id_fk
        foreign key (platoonID) references platoon (id)
);


# 1 додати поле в відділення
alter table platoon
    add column randomField varchar(32) not null;


# 2 прибрати це ж поле
alter table platoon
    drop column randomField;


# 3 зміна дефолтного значення
alter table platoon
    alter column dateForming set default '2000-01-01';


# 3б зміна дефолтного значення
alter table commander
    alter column birthday set default '2000-01-01';


# 4 розширення поля
alter table platoon
    modify column randomField varchar(100);


# 5 додати первинний ключ
alter table platoon
    add primary key (id);


# 6 додати вторинний ключ
alter table district
    add foreign key (divisionID) references division (id);


# 7 видалити первинний ключ
alter table platoon
    drop foreign key platoon_squadron_id_fk;


# 8 видалити вторинний ключ
alter table district
    drop primary key;


# 9 видалити таблицю
drop table log;


# 10 видалення значення з логів
delete
from log
where row_id = '0';


# 11 додати поле в роту
alter table squadron
    add column randomField varchar(32) not null;


# 12 прибрати це ж поле
alter table squadron
    drop column randomField;


# 13 зміна дефолтного значення
alter table squadron
    alter column dateForming set default '2000-01-01';


# 14 додати поле в відділення
alter table department
    add column randomField varchar(32) not null;


# 15 прибрати це ж поле
alter table department
    drop column randomField;


# 16 зміна дефолтного значення
alter table department
    alter column dateForming set default '2000-01-01';


# 17 додати поле в округу
alter table district
    add column randomField varchar(32) not null;


# 18 прибрати це ж поле
alter table district
    drop column randomField;


# 19 зміна дефолтного значення
alter table district
    alter column dateForming set default '2000-01-01';


# 20 зміна дефолтного значення в округ на айді командира vorobiy
alter table district
    alter column divisionID set default (select id
                                         from commander
                                         where surname = 'vorobiy');


# 21 перевірка піль максимальної численності
alter table army
    add constraint count_check
        check ( maxQuantity > 50000 );


# 22 перевірка піль шкоди
alter table armament
    add constraint damage_check
        check ( armament.damage != 0 );


# 23 перевірка піль віку народження
alter table commander
    add constraint age_check
        check ( age > 0 and birthday < '2021-12-12' );


# 24 перевірка піль маси озброоєння
alter table militaryEquipment
    add constraint weight_check
        check ( militaryEquipment.weight > 100 );


# 25 перевірка піль максимальної кількості
alter table part
    add constraint maxQuantity_check
        check ( maxQuantity >= 350 );


# 26 перевірка піль максимальної кількості
alter table division
    add constraint maxQuantity_division_check
        check ( maxQuantity >= 10000 );


# 27 перевірка валідності прізвища
alter table commander
    add constraint surname_check
        check ( length(surname) >= 4 );


# 28 перевірка валідності назви зброї
alter table armament
    add constraint weapon_check
        check ( length(name) >= 4 );


# 29 перевірка валідностіназви армії
alter table army
    add constraint army_check
        check ( length(armyName) < 30 );


# 30 перевірка валідності шифру
alter table part
    add constraint part_cypher_check
        check ( part.partCypher regexp '1%');


# # # 30 перевірка піль за допомогою однієї функції
# create function multi_checking_function() returns boolean
# begin
#     if (subdate((select all(dateForming) from department), 3650) > '2000-01-01')
#     then
#         return true;
#     else
#         return false;
#     end if;
# end;
#
# select true from department
# where (select dateForming from department where dateForming > '2000-01-01');
#
# where subdate((select dateForming from department), 3650);
#
# drop function multi_checking_function;
#
# select multi_checking_function();
#
# alter table department
#     add constraint func_check
#         check (multi_checking_function);


# ALTER TABLE commander
#     ADD CONSTRAINT commander_check
#         CHECK (
#             IF(surname regexp 'v%', IF(age >= 18, 1, 0), 1) = 1
#             );

# // //
# LAB 3
# \\ \\


# 1. озброєння, маса якого 20-120 кг
select name, weight, damage
from armament
where weight between 20 and 120;


# 2. озброєння, шкода якого конкретно 1 або 300, відсортоване за шкодою
select name, weight, damage
from armament
where damage in (1, 300)
order by damage;


# 3. озброєння, ім'я якого починається на "k"
select name, weight, damage
from armament
where name like 'k%';


# 4. озброєння, ім'я якого містить цифру та шкоду != null
select name, weight, damage
from armament
where name regexp '[1-9]'
  and damage is not null;


# 5. озброєння, у якого вагово-шкодний коефіцієнт більше за 0.05 з лімітом 3
select name, damage, weight, weight / armament.damage as koef
from armament
where weight / armament.damage > .05
order by koef desc
limit 3;


# 6. середня шкода озброєння з масою понад 10 кг
select AVG(damage) as averageArmyDamage
from armament
where weight > 10;


# 7. загальна кількість відділень
select count(*)
from department;


# 8. максимальна швидкість, що її розвиває військова техніка
select MAX(speed)
from militaryEquipment;


# 9. унікальні лідери у роті
select distinct commanderID
from squadron;


# 10. армії, відсортовані у спадному порядку їх численності, окрім найбільшої
select armyName, maxQuantity
from army
order by maxQuantity desc
limit 1, 2;


# 11. командири, старші 45 років і взаємовиключно вага понад 80 кг
select surname, age, weight, birthday
from commander
where age > 45 xor weight > 80;


# 12. військова бронетехника класу bt
select EquipmentName, speed
from militaryEquipment
where EquipmentName like 'bt%';


# 13. щонайбільш рання дивізія
select MIN(dateForming) as DateForming
from division;


# 14. військові округи з максимальною кількістю солдатів понад 2500 та датою формування після 18 вересня 2016
select maxQuantity, dateForming
from district
where maxQuantity > 2500
  and dateForming > '2016-09-18';


# 15. взводи, що засновані до підписання наказу певної дати
select id, dateForming
from platoon
where dateForming < '2010-10-10';


# 16. кількість взводів, згрупованих по максимальність кількості солдатів, їх кількість в групі понад 3
select maxQuantity, count(*) as count
from platoon
group by maxQuantity
having count > 3;


# 17. створює нове відділення з командиром, прізвище якого 'vorobiy'
insert into department (maxQuantity, commanderID, dateForming)
values (19,
        (select id from commander where surname = 'vorobiy'),
        '2021-12-12');


# 18. бронетехника зі швидкістю, більшою за середню
select *
from militaryEquipment
where speed >= (select AVG(speed) from militaryEquipment);


# 19. найстарший командир
select *
from commander
where birthday = (select MIN(birthday) from commander);


# 20. відділення з прізвищами їх командира
select dateForming,
       (select surname
        from commander
        where department.commanderID = commander.id) as commanderSurname
from department;


# 21. уся бронетехніка збройних сил
select (select name
        from armament
        where armament.id = armament_part.armamentID
       )        as armamentName,
       count(*) as count
from armament_part
group by armamentName
order by count desc;


# 22. усе озброєння частини за заданим шифром
select (select name
        from armament
        where armament.id = armament_part.armamentID
       ) as armamentName
from armament_part
where partID = # id частини з шифром 179
      (select id
       from part
       where partCypher = 179);


# 23 інформація про зброю шифру, старшого за 130
select *
from armament_part
where (select id
       from part
       where partCypher > 130) = partID;


# 24. рота з датою формування такою ж, як у однієї з дивізій
select *
from squadron
where dateForming in (select dateForming from division);


# 25. надмножина для дивізій
select *
from army
where maxQuantity > ALL (select maxQuantity from division);


# 26. військове озброєння зі швидкістю, більшою за коефіцієнт
select *
from militaryEquipment
where speed > ANY (select damage / weight from armament);


# 27. збільнення максимальної численності дивізії, якщо її поточна численність перевищує найбільшу серед усіх округів
update division
set maxQuantity = maxQuantity + 200
where maxQuantity > (select MAX(maxQuantity) from district);


# 28. видалення відділень, що не мають закріпленого за ними взводу
delete
from department
where platoonID not in (select id from platoon);


# 29. усе озброєння частини комбіновано за прикріпленим округом
select (select name
        from armament
        where armament.id = armament_part.armamentID
       ) as armamentName
from armament_part
where partID = # id частини з шифром 179
      (select id
       from part
       where partCypher = (select partCypher
                           from part
                           where districtID = 5));


# 30. рота, якщо існує рядок, такий що дата формування дивізії збігається з датою формування роти
select *
from squadron
where exists(select dateForming
             from division
             where division.dateForming = squadron.dateForming);


# 31. об'єдання таблиць
SELECT *
FROM part,
     armament,
     militaryEquipment;


# 32. об'єдання таблиць, якщо виконуться умова рівностей id
SELECT *
FROM part,
     armament,
     militaryEquipment
where part.id = armament.id
  and part.id = militaryEquipment.id;


# 33. об'єдання таблиць, якщо одне є підмножиною іншого
select *
from platoon,
     squadron
where platoon.squadronID = squadron.id;


# 34. відділення з їх командирами
select *
from department
         join commander c on c.id = department.commanderID;


# 35. взводи з їх відділеннями
select *
from platoon
         left join department on platoon.id = department.platoonID;


# 36. роти з їх взводами та взводи з їх відділеннями
select *
from squadron
         join platoon p on squadron.id = p.squadronID
         join department d on p.id = d.platoonID;


# 37. військова бойова техніка та військова зброя
select EquipmentName, weight
from militaryEquipment
union
select name, weight
from armament
order by weight desc;


# 38. кросжоін командира та департамента
select *
from commander
    cross join department d on commander.id = d.commanderID;


# 39. множення таблиць перерахуванням
select *
from department, commander;


# // //
# LAB 4
# \\ \\


# тестування каленадря
select LPAD('ok', 2, '*');
select QUARTER(now());
select DATE_ADD('2018-05-25 21:31:27', INTERVAL 4 HOUR);
select DATE_FORMAT(now(), '%M');


# 1a. взводи за кількістю, створені в один день
select maxQuantity, dateForming, count(*) as count
from platoon
group by dateForming, maxQuantity
order by count desc;


# 1b. шкода від атакування найсильнішою одиницею військової техніки
select 'the most powerful' as unit,
       SUM(damage)         as maxDamage
from armament;


# 1c. дані про командиірв з великим прізвищем якщо вік старший 60 років та малим прізвищем інакше
select age, weight, birthday, UPPER(surname) as upperSurname
from commander
where datediff(now(), birthday) / 365 > 60
union
select age, weight, birthday, lower(surname)
from commander
where datediff(now(), birthday) / 365 <= 60;


# 1d. дата заснування роти з її тестовим періодом пів року
select id, date_sub(dateForming, interval 6 month) as testPeriod
from squadron;


# 1e. групування по стовпцю максимальної кількості відділення
select maxQuantity, count(*) as count
from department
group by maxQuantity
order by count desc;


# 1f. групування по стовпцях ваги та шкоди
select 'weapon' as type, weight, damage, count(*) as count
from armament
group by weight, damage;


# 1g. максимальна кількість людей взводу, згрупована за максимальною кількістю, де кількість групи бальша за 3
select maxQuantity, count(*) as count
from platoon
group by maxQuantity
having count > 3;


# 1h. загальна шкода від одночасного атакування всіма унікальними одиницями військової техінки, якщо більша за 500
select sum(damage) as totalDamage
from armament
having totalDamage > 500;


# 1i. військова техніка, сортована за іменем
select EquipmentName, weight, speed
from militaryEquipment
order by EquipmentName;


# 2a. представлення округу та частини
create view part_district_view as
select partCypher, districtID, d.maxQuantity, d.dateForming, divisionID
from part
         join district d on part.districtID = d.id;


# 2b. представлення округу, частини та дивізії
create view division_part_district as
select armyID, division.dateForming
from division
         left join part_district_view pdv
                   on division.maxQuantity = pdv.maxQuantity and division.dateForming = pdv.dateForming;

drop view division_part_district;
select * from division_part_district;

# 2c. перезапис view
    alter view division_part_district as
    select division.dateForming, armyID
    from division
             left join part_district_view pdv
                       on division.maxQuantity = pdv.maxQuantity and division.dateForming = pdv.dateForming;


# 2e. довідникова інформація
# https://stackoverflow.com/questions/5006323/sp-help-for-mysql
show columns in division_part_district;


# // //
# LAB 5
# \\ \\


# 1.a / 1.d  таблиця об'єднання командира та його підопічного відділення
create procedure create_temp_table()
begin
    create temporary table IF NOT EXISTS department_commander
    (
        id          int,
        dateForming date,
        age         int,
        name        varchar(32)
    );

    insert into department_commander
    select commander.id, dateForming, age, surname
    from commander
             join department d on commander.id = d.commanderID;

    select *
    from department_commander;
    drop table department_commander;
end;

drop procedure create_temp_table;

call create_temp_table();

# 1.b / 1.e повертає булеве значення чи є командир пенсіонером за прізвищем
create procedure is_retired(currentSurname varchar(32))
begin
    if (
            (select age
             from commander
             where surname = currentSurname) > 50
        )
    then
        select true;
    else
        select false;
    end if;
end;

call is_retired('pupin');
call is_retired('lupin');


# 1.с / 1.e вітання за кожен день народження
create procedure wish_for_every_birthday(currentSurname varchar(32))
begin
    declare n int;
    set n = (select age
             from commander
             where surname = currentSurname);
    while (
        n > 0
        )
        do
            set n = n - 1;
            select n, 'HAPPY BIRTHDAY!';
        end while;
end;

drop procedure wish_for_every_birthday;

call wish_for_every_birthday('lupin');


# 1.f повертає максимальну кількість
SET GLOBAL log_bin_trust_function_creators = 1;

create function get_maxQuantity(currentID int) returns int
begin
    declare n int;
    set n = (select maxQuantity
             from squadron
             where id = currentID);
    return n;
end;

drop function get_maxQuantity;

select get_maxQuantity(3);


# 1.g збішьшити крайню чисельнісь армії за іменем на певну кількість
create procedure add_some_quantity_to_army(reserve int, currentArmyName varchar(32))
begin
    update army
    set maxQuantity = maxQuantity + reserve
    where armyName = currentArmyName;
end;

drop procedure add_some_quantity_to_army;

call add_some_quantity_to_army(1000, 'Red army');


# 1.h вибірка даних озброєння за іменем
create procedure select_armament(currentName varchar(32))
begin
    select id, name, weight, damage
    from armament
    where currentName = name;
end;

drop procedure select_armament;

call select_armament('bazooka');


# 2.a шкода всього озброєння частини
create function get_part_damage(currentArmyName varchar(32)) returns int
begin
    declare n int default 0;
    set n = (select sum(damage) as allDamage
             from armament
             where id in
                   (select armamentID
                    from army
                             left join division d on army.id = d.armyID
                             left join district d2 on d.id = d2.divisionID
                             left join part p on d2.id = p.districtID
                             left join armament_part ap on p.id = ap.partID
                    where armyName = currentArmyName
                      and armamentID in (select id from armament)));
    return n;
end;

select get_part_damage('Red army');


# 2.b обирає таблицю з динамічним набором стовпців
create procedure select_columns()
begin
    select surname, birthday
    from commander;
end;

call select_columns();


# 2.c обирає структуровану таблицю з динамічним набором стовпців
create procedure select_columns_structured(lm int, isAscending bool)
begin
    if (isAscending)
    then
        select surname, birthday
        from commander
        order by surname
        limit lm;
    else
        select surname, birthday
        from commander
        order by surname desc
        limit lm;
    end if;
end;

drop procedure select_columns_structured;

call select_columns_structured(1, true);
call select_columns_structured(3, false);


# 3.a / 3.b / 3.c
create procedure testCursor()
begin
    DECLARE done INT DEFAULT FALSE;
    DECLARE a INT;
    DECLARE b VARCHAR(32);
    DECLARE cur1 CURSOR FOR SELECT id, surname FROM commander;
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = TRUE;

    OPEN cur1;
    read_loop:
    LOOP
        FETCH cur1 INTO a, b;
        IF done THEN
            select a, b;
            LEAVE read_loop;
        END IF;
    END LOOP;
    CLOSE cur1;
end;

drop procedure testCursor;

call testCursor();


# 4.a логування при видаленні даних
CREATE TABLE `log`
(
    id     INT(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    msg    VARCHAR(255)     NOT NULL,
    time   TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    row_id INT(11)          NOT NULL
);

DELIMITER |
CREATE TRIGGER logMilitaryEquipment
    AFTER DELETE
    ON militaryEquipment
    FOR EACH ROW
BEGIN
    INSERT INTO log Set msg = 'delete', row_id = id;
END;


# 4.b логування при оновленні даних
DELIMITER |
CREATE TRIGGER logPart
    AFTER UPDATE
    ON part
    FOR EACH ROW
BEGIN
    INSERT INTO log Set msg = 'update', row_id = NEW.id;
END;


# 4.c логування при додаванні даних
DELIMITER |
CREATE TRIGGER logPlatoon
    AFTER INSERT
    ON platoon
    FOR EACH ROW
BEGIN
    INSERT INTO log Set msg = 'insert', row_id = NEW.id;
END;
select *
from armament;
