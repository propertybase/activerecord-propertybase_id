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
            type = PB_ID_SQL_TYPE if type.to_s == "propertybase_id"
            add_column_without_propertybase_id(name, type, options)
          end

          alias_method_chain :add_column, :propertybase_id
        end
      end

      module AddReferencePropertybaseIdColumn
        extend ActiveSupport::Concern

        included do
          def add_reference_with_propertybase_id(table_name, ref_name, options = {})
            options.merge!(type: PB_ID_SQL_TYPE) if options[:type].to_s == "propertybase_id"
            add_reference_without_propertybase_id(table_name, ref_name, options)
          end

          alias_method_chain :add_reference, :propertybase_id
        end
      end

      module ReferencesPropertybaseIdColumn
        extend ActiveSupport::Concern

        included do
          def references_with_propertybase_id(*args)
            options = args.extract_options!
            options.merge!(type: PB_ID_SQL_TYPE) if options[:type].to_s == "propertybase_id"
            args << options
            references_without_propertybase_id(*args)
          end

          alias_method_chain :references, :propertybase_id
        end
      end

      def self.apply!
        ActiveRecord::ConnectionAdapters::Table.send :include, Migrations if defined? ActiveRecord::ConnectionAdapters::Table
        ActiveRecord::ConnectionAdapters::Table.send :include, ReferencesPropertybaseIdColumn if defined? ActiveRecord::ConnectionAdapters::Table
        ActiveRecord::ConnectionAdapters::TableDefinition.send :include, Migrations if defined? ActiveRecord::ConnectionAdapters::TableDefinition
        ActiveRecord::ConnectionAdapters::TableDefinition.send :include, ReferencesPropertybaseIdColumn if defined? ActiveRecord::ConnectionAdapters::TableDefinition
        ActiveRecord::ConnectionAdapters::AlterTable.send :include, AddPropertybaseIdColumn

        ActiveRecord::ConnectionAdapters::SchemaStatements.send :include, AddReferencePropertybaseIdColumn
      end
    end
  end
end
