module Undo
  def self.wrap(object, options = {})
    Wrapper.new object, options
  end
end
