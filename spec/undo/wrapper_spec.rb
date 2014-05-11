require "spec_helper_lite"

describe Undo::Wrapper do
  subject do
    described_class.new(
      object,
      store_on: [:change]
    )
  end

  let(:object) { double :object, change: "changed" }

  describe "when mutation method is called" do
    it "calls the method and returns result" do
      expect(subject.change).to eq "changed"
    end

    it "stores object state" do
      expect(Undo).to receive(:store).with(object, anything)
      subject.change
    end

    it "does not store object state on another methods call" do
      expect(Undo).not_to receive(:store)
      subject.object_id
    end
  end
end
