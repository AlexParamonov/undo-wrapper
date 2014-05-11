require "spec_helper_lite"
require "undo"
require 'undo/wrapper'
require_relative '../../../undo/integration/shared_undo_integration_examples.rb'

describe Undo do
  include_examples "undo integration"
end
