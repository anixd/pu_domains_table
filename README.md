## Simple Rake (ruby) scenario set for creating/managing SQL DB structure/models with `ActiveRecord`


### Prerequisites:
- [Ruby Version Manager (rvm)](https://rvm.io/rvm/install)

After installing/configuring `rvm` install `ruby` and create gemset:

```shell
rvm install 3.1.4
```

```shell
rvm gemset create pinup_dodmains_table && rvm use 3.1.4@pinup_dodmains_table
```


### Invocation:

#### Generating Model (will create Model and its Migration)

```shell
rake "gen:model[student, firstname:string, lastname:string, age:integer]"
```

where
- **student** -- model name
- **firstname:string** -- firstname (attribute name), string (attribute type)


#### Generating Migration

```shell
rake "gen:migration[student, change, age:bigint, graduated:boolean]"
```


### Data types supported by ActiveRecord migrations:

- **:string** - короткая строка (обычно ограничена 255 символами).
- **:text** - длинная строка (подходит для хранения больших текстов).
- **:boolean** - boolean тип данных (true/false).
- **:integer** - целое число.
- **:bigint** - большое целое число.
- **:float** - число с плавающей точкой.
- **:decimal** - точное десятичное значение, можно указать `precision` и `scale`.
- **:date** - для хранения дат (год, месяц, день).
- **:time** - только время.
- **:datetime** - для хранения даты и времени.
- **:timestamp** - алиас для `:datetime`,.
- **:binary** - для хранения двоичных данных.
- **:primary_key** - тип для первичного ключа.
- **:references** - добавляет столбец для внешнего ключа в другую таблицу (FK).
- **:json** - для хранения JSON-данных (postgres).
- **:jsonb** - для хранения JSON-данных с индексацией на уровне БД (postgres).
- **:array** - поддержка массивов (обычно требует указания типа данных элементов массива, например, `integer[]`).

