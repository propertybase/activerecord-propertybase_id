require "activerecord/propertybase_id"
require "rails"

module ActiveUUID
  class Railtie < Rails::Railtie
    railtie_name :propertybase_id

    config.to_prepare do
      ActiveRecord::PropertybaseId::Patches.apply!
    end
  end
end
