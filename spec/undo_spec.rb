require "spec_helper_lite"

describe Undo do
  let(:object) { double :object, change: true }
  subject { described_class }

  describe "pass through options to serializer" do
    let(:serializer) { double :serializer }

    specify "from #wrap" do
      expect(serializer).to receive(:serialize).with(object, foo: :bar)

      wrapper = subject.wrap object,
        serializer: serializer,
        store_on: [:change],
        foo: :bar

      wrapper.change
    end
  end

  describe "pass through options to storage" do
    let(:storage) { double :storage }

    specify "from #wrap" do
      expect(storage).to receive(:store).with(anything, object, foo: :bar)

      wrapper = subject.wrap object,
        storage: storage,
        store_on: [:change],
        foo: :bar

      wrapper.change
    end
  end

  describe "#wrap" do
    before do
      subject::Wrapper.configure do |config|
        config.store_on = [:change]
      end
    end

    it "is a decorator" do
      object = %w[hello world]

      decorator = subject.wrap object
      expect(object).to receive(:some_method)
      decorator.some_method

      expect(decorator.class).to eq Array
      expect(decorator).to be_a Array
    end

    describe "restores" do
      specify "using provided uuid" do
        uuid = "uniq_identifier"
        model = subject.wrap object, uuid: uuid
        model.change

        expect(subject.restore uuid).to eq object
      end

      specify "using gerenated uuid" do
        uuid = object.object_id
        model = subject.wrap object, uuid_generator: -> object { object.object_id }
        model.change

        expect(model.undo_uuid).to eq uuid
        expect(subject.restore uuid).to eq object
      end
    end
  end
end
