$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'zygote'

# ENV["DB"] ||= 'sqlite3'

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: File.dirname(__FILE__) + "/test.sqlite3"
)

require 'database_cleaner'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    # DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
