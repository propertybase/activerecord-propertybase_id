module ActiveRecord
  module PropertybaseId
    module Patches
      PB_ID_SQL_TYPE = "char(#{::PropertybaseId.max_length})"

      module Migrations
        def propertybase_id(*column_names)
          options = column_names.extract_options!
          column_names.each do |name|
            primary_key = options.delete(:primary_key) || name.to_s == "id"
            column(name, "#{PB_ID_SQL_TYPE}#{' PRIMARY KEY' if primary_key}", options)
          end
        end
      end

      module AddPropertybaseIdColumn
        extend ActiveSupport::Concern

        included do
          def add_column_with_propertybase_id(name, type, options)
            type = PB_ID_SQL_TYPE if type.to_sym == :propertybase_id
            add_column_without_propertybase_id(name, type, options)
          end

          alias_method_chain :add_column, :propertybase_id
        end
      end

      def self.apply!
        ActiveRecord::ConnectionAdapters::Table.send :include, Migrations if defined? ActiveRecord::ConnectionAdapters::Table
        ActiveRecord::ConnectionAdapters::TableDefinition.send :include, Migrations if defined? ActiveRecord::ConnectionAdapters::TableDefinition
        ActiveRecord::ConnectionAdapters::AlterTable.send :include, AddPropertybaseIdColumn
      end
    end
  end
end
