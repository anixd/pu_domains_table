require 'active_record'
require 'yaml'
require 'rake'
require 'erb'
require 'active_support'


DB_CONFIG = YAML.load_file('config/database.yml')

ActiveRecord::Base.establish_connection(DB_CONFIG.merge('database' => 'postgres'))

namespace :db do
  desc "Create the database from config/database.yml"
  task :create do
    db_name = DB_CONFIG['database']
    begin
      ActiveRecord::Base.connection.create_database(db_name, DB_CONFIG)
      puts "Database '#{db_name}' created."
    rescue ActiveRecord::StatementInvalid => e
      puts "Database creation failed: #{e.message}"
    end
  end

  desc "Drop the database from config/database.yml"
  task :drop do
    db_name = DB_CONFIG['database']
    begin
      ActiveRecord::Base.connection.drop_database(db_name)
      puts "Database '#{db_name}' dropped."
    rescue ActiveRecord::StatementInvalid => e
      puts "Database dropping failed: #{e.message}"
    end
  end
end

namespace :gen do
  desc "Create a new model (and according migration)"
  task :model, [:name, :attributes] do |t, args|
    model_name = args[:name]
    # Преобразуем строку атрибутов в хэш {имя_атрибута => тип_атрибута}
    attributes = args[:attributes].split(',').map { |attr| attr.split(':') }.to_h

    # Загружаем шаблоны
    model_template = ERB.new(File.read('config/model_template.erb'))
    migration_template = ERB.new(File.read('config/migration_template.erb'))

    # Генерация модели
    model_content = model_template.result(binding)
    FileUtils.mkdir_p("models")
    File.write("models/#{model_name.underscore}.rb", model_content)

    # Генерация миграции
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    migration_content = migration_template.result(binding)
    FileUtils.mkdir_p("db/migrate") # Создаем папку если не существует
    File.write("db/migrate/#{timestamp}_create_#{model_name.pluralize.underscore}.rb", migration_content)

    puts "Model and Migration for #{model_name} generated successfully."
  end

  desc "Create a new migration"
  task :migration, [:name, :change_type, :attributes] do |t, args|
    migration_name = args[:name]
    change_type = args[:change_type] # 'add', 'remove', 'create'
    attributes = args[:attributes].split(',')
    migration_template = ERB.new(File.read('config/migration_template.erb'))

    # Generate Migration
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    migration_content = migration_template.result(binding)
    File.write("db/migrate/#{timestamp}_#{change_type}_#{migration_name.underscore}.rb", migration_content)

    puts "Migration for #{migration_name} generated successfully."
  end
end
