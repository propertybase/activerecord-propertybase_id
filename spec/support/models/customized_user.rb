class CustomizedUser < ActiveRecord::Base
  include Activerecord::PropertybaseId

  propertybase_object :user
end
