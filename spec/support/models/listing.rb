class Listing < ActiveRecord::Base
  include ActiveRecord::PropertybaseId

  belongs_to :user
end
