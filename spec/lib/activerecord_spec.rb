require "spec_helper"

describe RegularTeam do
  let(:model) { described_class }
  let!(:compare_to) { RegularTeam.create(name: "a Regular Team") }
  let(:id) { compare_to.id }
  let(:id_type) { Integer }
  subject { model }

  it_behaves_like "a regular AR object"
end

describe Team do
  let(:model) { described_class }
  let!(:compare_to) { model.create(name: "a Propertybase Team") }
  let(:id) { compare_to.id }
  let(:id_type) { String }
  subject { model }

  it_behaves_like "a regular AR object"
  it_behaves_like "an AR object with Propertybase ID", "team"
end

describe CustomizedUser do
  let(:model) { described_class }
  let!(:compare_to) { model.create(email: "user@propertybase.com") }
  let(:id) { compare_to.id }
  let(:id_type) { String }
  subject { model }

  it_behaves_like "a regular AR object"
  it_behaves_like "an AR object with Propertybase ID", "user"
end

describe "Created with #references in migration" do
  context "Properybase ID" do
    let(:foreign_key) { :team_id }
    let(:parent_record) { Team.create(name: "the testers") }
    let(:child_record) { User.create(email: "no1@thetesters.com", team: parent_record) }

    include_examples "references"
  end

  describe "Regular ID" do
    let(:foreign_key) { :regular_team_id }
    let(:parent_record) { RegularTeam.create(name: "the testers") }
    let(:child_record) { RegularUser.create(email: "no1@thetesters.com", regular_team: parent_record) }

    include_examples "references"
  end
end

describe "Created with #add_reference in migration" do
  describe "Properybase ID" do
    let(:foreign_key) { :user_id }
    let(:parent_record) { User.create(email: "no1@thetesters.com") }
    let(:child_record) { Listing.create(address: "1 Infinite Loop", user: parent_record) }

    include_examples "references"
  end

  describe "Regular ID" do
    let(:foreign_key) { :regular_user_id }
    let(:parent_record) { RegularUser.create(email: "no1@thetesters.com") }
    let(:child_record) { RegularListing.create(address: "1 Infinite Loop", regular_user: parent_record) }

    include_examples "references"
  end
end

describe ActiveRecord::Base do
  context ".connection" do
    let!(:connection) { ActiveRecord::Base.connection }
    let(:table_name) { :test_propertybase_id_field_creation }

    before do
      connection.drop_table(table_name) if connection.table_exists?(table_name)
      connection.create_table(table_name)
    end

    after do
      connection.drop_table table_name
    end

    specify { expect(connection.table_exists?(table_name)).to be_truthy }

    context "#add_column" do

      let(:column_name) { :test_propertybase_id_field_creation }
      let(:column) { connection.columns(table_name).detect { |c| c.name.to_sym == column_name } }

      before { connection.add_column table_name, column_name, :propertybase_id }

      specify { expect(connection.column_exists?(table_name, column_name)).to be_truthy }
      specify { expect(column).not_to be_nil }

      it "has proper sql type" do
        spec_for_adapter do |adapters|
          adapters.sqlite { expect(column.sql_type).to eq("char(15)") }
          adapters.postgresql { expect(column.sql_type).to eq("character(15)") }
        end
      end
    end
  end
end
