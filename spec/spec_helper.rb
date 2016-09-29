$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'zygote'
require 'pry'

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: File.dirname(__FILE__) + "/test.sqlite3"
)

require 'database_cleaner'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

def define_table(table_name, &table_definition)
  ActiveRecord::Schema.define version: 0 do
    create_table(table_name, {force: true}, &table_definition)
  end
end

def define_active_record_class(class_name, &definition)
  stub_const(class_name.classify, Class.new(ActiveRecord::Base, &definition))
  class_name.classify.constantize.reset_column_information
end

def active_record_class(class_name, &table_definition)
  define_table(class_name.tableize, &table_definition)
  define_active_record_class(class_name.classify)
end
