require "activerecord/propertybase_id"
require "rails"

module ActiveRecord
  module PropertybaseId
    class Railtie < Rails::Railtie
      railtie_name :propertybase_id

      config.to_prepare do
        ActiveRecord::PropertybaseId::Patches.apply!
      end
    end
  end
end
