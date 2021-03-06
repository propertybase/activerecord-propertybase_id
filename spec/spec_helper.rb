require "rubygems"
require "bundler/setup"

Bundler.require :development

require "active_record"
require "active_support/all"

ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")
ActiveRecord::Base.configurations = YAML::load(File.read(File.dirname(__FILE__) + "/support/database.yml"))
ActiveRecord::Base.establish_connection((ENV["DB"] || "sqlite3").to_sym)
ActiveRecord::Base.connection.tables.each do |table|
  ActiveRecord::Base.connection.drop_table(table)
end

require "activerecord/propertybase_id"

ActiveRecord::Migrator.migrate(File.dirname(__FILE__) + "/support/migrate")
ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, STDOUT)

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  def spec_for_adapter(&block)
    switcher = ActiveRecord::PropertybaseId::SpecSupport::SpecForAdapter.new
    yield switcher
    switcher.run(connection)
  end
end
