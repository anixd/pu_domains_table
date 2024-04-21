require 'active_record'
require 'yaml'
require 'pg' # Если вы используете PostgreSQL

# Подключение к БД
db_config = YAML.load_file('config/database.yml')
ActiveRecord::Base.establish_connection(db_config)




def create_database
  db_name = DB_CONFIG['database']
  begin
    ActiveRecord::Base.connection.create_database(db_name, DB_CONFIG)
    puts "Database '#{db_name}' created."
  rescue ActiveRecord::StatementInvalid => e
    puts "Database creation failed: #{e.message}"
  end
end

def drop_database
  db_name = DB_CONFIG['database']
  begin
    ActiveRecord::Base.connection.drop_database(db_name)
    puts "Database '#{db_name}' dropped."
  rescue ActiveRecord::StatementInvalid => e
    puts "Database dropping failed: #{e.message}"
  end
end




# Методы для работы с миграциями и моделями
def create_migration(name, &block)
  migration_class = Class.new(ActiveRecord::Migration[7.1], &block)
  migration_name = "#{Time.now.strftime('%Y%m%d%H%M%S')}_#{name}"
  migration_class.new(migration_name).migrate(:up)
end

def create_model(name, &block)
  Object.const_set(name, Class.new(ActiveRecord::Base, &block))
end

# Пример создания модели
create_model('User') do
  # Содержимое модели
end

# Пример создания миграции
create_migration('create_users') do
  def change
    create_table :users do |t|
      t.string :name
      # Другие поля
    end
  end
end

# Загрузка и выполнение сидов
require 'seedbank'
Seedbank.load_tasks
Rake::Task['db:seed'].invoke


