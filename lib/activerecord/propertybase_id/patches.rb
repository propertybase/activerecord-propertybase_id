module ActiveRecord
  module PropertybaseId
    module Patches
      module Migrations
        def propertybase_id(*column_names)
          options = column_names.extract_options!
          column_names.each do |name|
            type = "char(#{::PropertybaseId.max_length})"
            primary_key = options.delete(:primary_key) || name.to_s == "id"
            column(name, "#{type}#{' PRIMARY KEY' if primary_key}", options)
          end
        end
      end

      module AbstractAdapter
        extend ActiveSupport::Concern

        included do
          def initialize_type_map_with_propertybase_id(m)
            initialize_type_map_without_propertybase_id(m)
            register_class_with_limit m, /char\(#{::PropertybaseId.max_length}\)/i, ::ActiveRecord::Type::PropertybaseId
          end

          alias_method_chain :initialize_type_map, :propertybase_id
        end
      end

      def self.apply!
        ActiveRecord::ConnectionAdapters::Table.send :include, Migrations if defined? ActiveRecord::ConnectionAdapters::Table
        ActiveRecord::ConnectionAdapters::TableDefinition.send :include, Migrations if defined? ActiveRecord::ConnectionAdapters::TableDefinition
      end
    end
  end
end
