class RegularUser < ActiveRecord::Base
  belongs_to :regular_team
  has_one :regular_listing
end
