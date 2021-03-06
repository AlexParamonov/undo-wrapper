require "undo"
require_relative "wrapper/configuration"
require_relative "wrapper_integration"
require "forwardable"

module Undo
  class Wrapper < SimpleDelegator
    def self.configure
      yield config
    end

    def self.config
      @config ||= Configuration.new
    end

    extend Forwardable
    def_delegators :object, :class, :kind_of?

    attr_reader :undo_uuid, :config

    def initialize(object, options)
      @object = object
      @config = Undo::Wrapper.config.with options
      @options = options

      super object
    end

    def method_missing(method, *args, &block)
      store if config.store_on.include? method
      super method, *args, &block
    end

    private
    attr_reader :object, :options

    def store
      @undo_uuid = Undo.store object, options
    end
  end
end
