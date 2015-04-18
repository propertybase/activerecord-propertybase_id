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

      module PostgreSQLType
        extend ActiveSupport::Concern

        included do
          def type_to_sql_with_propertybase_id(*args)
            return "character(#{::PropertybaseId.max_length})" if args.first.to_s == "propertybase_id"

            type_to_sql_without_propertybase_id(*args)
          end

          alias_method_chain :type_to_sql, :propertybase_id
        end
      end

      module SqliteType
        extend ActiveSupport::Concern

        included do
          def new_column_with_propertybase_id(name, default, cast_type, sql_type = nil, null = true)
            sql_type = "char(#{::PropertybaseId.max_length})" if sql_type == "propertybase_id"
            new_column_without_propertybase_id(name, default, cast_type, sql_type, null)
          end

          alias_method_chain :new_column, :propertybase_id
        end
      end

      def self.apply!
        ActiveRecord::ConnectionAdapters::Table.send :include, Migrations if defined? ActiveRecord::ConnectionAdapters::Table
        ActiveRecord::ConnectionAdapters::TableDefinition.send :include, Migrations if defined? ActiveRecord::ConnectionAdapters::TableDefinition
        ActiveRecord::ConnectionAdapters::PostgreSQL::SchemaStatements.send :include, PostgreSQLType if defined? ActiveRecord::ConnectionAdapters::PostgreSQL::SchemaStatements
        ActiveRecord::ConnectionAdapters::AbstractAdapter.send :include, SqliteType if defined? ActiveRecord::ConnectionAdapters::AbstractAdapter
      end
    end
  end
end
