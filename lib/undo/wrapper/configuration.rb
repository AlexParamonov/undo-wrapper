module Undo
  class Wrapper < SimpleDelegator
    class Configuration
      attr_accessor :store_on

      def initialize(attributes = {})
        @store_on = attributes.fetch :store_on, [:delete, :destroy]
      end

      def with(attribute_updates = {})
        self.class.new store_on: (attribute_updates.delete(:store_on) || store_on)
      end
    end
  end
end
