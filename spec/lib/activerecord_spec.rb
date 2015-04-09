require "spec_helper"

describe RegularTeam do
  let!(:compare_to) { FactoryGirl.create(:regular_team) }
  let(:id) { compare_to.id }
  let(:model) { RegularTeam }
  let(:id_type) { Integer }
  subject { model }

  it_behaves_like "a regular AR object"
end

describe Team do
  let!(:compare_to) { FactoryGirl.create(:team) }
  let(:id) { compare_to.id }
  let(:model) { Team }
  let(:id_type) { String }
  subject { model }

  it_behaves_like "a regular AR object"
  it_behaves_like "an AR object with Propertybase ID", "team"
end

describe CustomizedUser do
  let!(:compare_to) { FactoryGirl.create(:customized_user) }
  let(:id) { compare_to.id }
  let(:model) { CustomizedUser }
  let(:id_type) { String }
  subject { model }

  it_behaves_like "a regular AR object"
  it_behaves_like "an AR object with Propertybase ID", "user"
end
