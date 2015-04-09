module ActiveRecord
  module PropertybaseId
    module Decorator
      extend ActiveSupport::Concern

      def to_param
        to_s
      end

      def as_json(options)
        to_s
      end

      module ClassMethods
        def serialize(value)
          case value
          when self
            value
          when String
            parse value
          else
            nil
          end
        end
      end
    end
  end
end
