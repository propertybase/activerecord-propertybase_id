class Team < ActiveRecord::Base
  include ActiveRecord::PropertybaseId

  has_one :user
end
