require "propertybase_id"
require "active_record"
require "active_support/concern"
require "activerecord/propertybase_id/version"
require "activerecord/propertybase_id/patches"
require "activerecord/propertybase_id/railtie" if defined?(Rails::Railtie)

module ActiveRecord
  module PropertybaseId
    extend ActiveSupport::Concern

    included do
      class_attribute :_propertybase_object, instance_writer: false
      self._propertybase_object = self.name.underscore

      before_create :generate_propertybase_id_if_needed
    end

    def propertybase_id
      pb_id_string = send(self.class.primary_key)
      ::PropertybaseId.parse(pb_id_string)
    end

    def generate_propertybase_id
      ::PropertybaseId.generate(object: _propertybase_object.to_s).to_s
    end

    def generate_propertybase_id_if_needed
      primary_key = self.class.primary_key
      send("#{primary_key}=", generate_propertybase_id) unless send("#{primary_key}?")
    end

    module ClassMethods
      def propertybase_object(proeprtybase_object)
        self._propertybase_object = proeprtybase_object
      end
    end
  end
end

ActiveRecord::PropertybaseId::Patches.apply!
