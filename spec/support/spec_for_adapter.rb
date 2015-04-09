require "activerecord/propertybase_id"

module ActiveRecord
  module PropertybaseId
    module SpecSupport
      class SpecForAdapter
        def initialize
          @specs = {}
        end

        [:sqlite3, :postgresql].each do |name|
          send :define_method, name do |&block|
            @specs[name] = block
          end
        end

        def run(connection)
          name = connection.adapter_name.downcase.to_sym
          @specs[name].call() if(@specs.include? name)
        end
      end
    end
  end
end
