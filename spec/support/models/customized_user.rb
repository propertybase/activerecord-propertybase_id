class CustomizedUser < ActiveRecord::Base
  include ActiveRecord::PropertybaseId

  propertybase_object :user
end
