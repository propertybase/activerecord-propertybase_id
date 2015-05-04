class User < ActiveRecord::Base
  include ActiveRecord::PropertybaseId

  belongs_to :team
end
