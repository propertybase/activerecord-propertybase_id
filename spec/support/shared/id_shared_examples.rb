shared_examples "a regular AR object" do
  context "model" do
    its(:all) { is_expected.to eq([compare_to]) }
    its(:first) { is_expected.to eq(compare_to) }
  end

  context "existance" do
    subject { compare_to }
    its(:id) { is_expected.to be_a(id_type) }
  end

  context ".find" do
    specify { expect(model.find(id)).to eq(compare_to) }
  end

  context ".where" do
    specify { expect(model.where(id: id).first).to eq(compare_to) }
  end

  context "#destroy" do
    subject { compare_to }
    its(:delete) { is_expected.to be_truthy }
    its(:destroy) { is_expected.to be_truthy }
  end

  context "#save" do
    subject { compare_to }

    its(:save) { is_expected.to be_truthy }
  end
end

shared_examples "an AR object with Propertybase ID" do |object_type|
  describe "#propertybase_id" do
    context "valid Propertybase ID" do
      subject { compare_to.propertybase_id }

      it { is_expected.to be_a(::PropertybaseId) }
    end

    context "Object Type" do
      subject { compare_to.propertybase_id }
      let(:expected_object) { object_type }

      its(:object) { is_expected.to eq(expected_object) }
    end
  end

  describe "#create" do
    context "no ID provieded" do
      it "generates an ID by default" do
        expect(model.create.id).not_to be_empty
      end
    end

    context "ID provided" do
      let(:custom_id) { "zzzzzzzzzzzzzzzzzz" }

      before { model.create(id: custom_id) }

      it "overrides on providing an ID" do
        expect(model.find(custom_id)).not_to be_nil
      end
    end
  end
end

shared_examples "references" do
  context "references" do
    it "child references parent correctly" do
      expect(child_record.send(foreign_key)).to eq(parent_record.id)
    end
  end
end
