# Andmebaasid
Andmebaasisüsteemide alused TiTpv23

1. **teksti või sümboolid** - VARCHAR(50), CHAR(3), TEXT (текстовые)
   Näited: nimi, nimetus, telefoniNumber, isikukood - Varchar (11)
2. **ARVULISED** (чесловые) - int, bigint, smallint, decimal(5,2) - 5 kokku, 2-peale komat
   Näited: vanus, palk, temperatuur, kall, pikkus, jne.
3. **Kuupäeva** - DATE, TIME, date/time
   Näited: sünniaeg, kohtumise aeg, tellimuse kuupäev, sündmuse algus/aeg
4. **Loogilised** - bit,bool,boolean
   Näited:kasOnAktiveeritud, kasOnKohustuslik, kasOnLõpetatud, kasTehtud

## Piiranguid - Ограничение
1. Primary key - ei anna või võimalust lisada topelt väärtused
2. UNIQUE - unikaalsus
3. NOT NULL ei lubada tühjad väärtused
4. Foreign Key - saab kasutada ainult teise tabeli väärtused
5. CHECK - saab sisestada ainult check määratud väärtused

# Databases
Fundamentals of Database Systems TiTpv23

1. **Text or Symbols** - VARCHAR(50), CHAR(3), TEXT (text fields)
   Examples: name, title, phoneNumber, personalCode - Varchar (11)
2. **Numerical** (integers) - int, bigint, smallint, decimal(5,2) - 5 in total, 2 after the decimal point
   Examples: age, salary, temperature, cost, height, etc.
3. **Date** - DATE, TIME, date/time
   Examples: date of birth, meeting time, order date, event start/time
4. **Logical** - bit, bool, boolean
   Examples: isActivated, isRequired, isCompleted, isDone

## Constraints
1. Primary Key - prevents or disallows duplicate values
2. UNIQUE - uniqueness
3. NOT NULL - disallows null values
4. Foreign Key - can only use values from another table
5. CHECK - allows only values defined by the check constraint

# Базы данных
Основы систем баз данных TiTpv23

1. **Текст или символы** - VARCHAR(50), CHAR(3), TEXT (текстовые поля)
   Примеры: имя, название, номер телефона, личный код - Varchar (11)
2. **Числовые** (целые числа) - int, bigint, smallint, decimal(5,2) - 5 всего, 2 после запятой
   Примеры: возраст, зарплата, температура, стоимость, рост и т.д.
3. **Дата** - DATE, TIME, date/time
   Примеры: дата рождения, время встречи, дата заказа, начало/время события
4. **Логические** - bit, bool, boolean
   Примеры: isActivated, isRequired, isCompleted, isDone

## Ограничения
1. Primary Key - не позволяет добавлять дублирующиеся значения
2. UNIQUE - уникальность
3. NOT NULL - не позволяет значениям быть пустыми
4. Foreign Key - может использовать только значения из другой таблицы
5. CHECK - позволяет вводить только значения, определенные в ограничении check (мужчина или женщина)

Piltit:
1) ![image](https://github.com/user-attachments/assets/353c7d74-6d42-4739-bc38-a199ccdb9a55)

