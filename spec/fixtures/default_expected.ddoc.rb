class IgnoredSuperClass
  def instance_method
    #shouldn't be documented
  end
end

module IgnoredModule
  def instance_method
    #shouldn't be documented
    super
  end
end

class TestClass < IgnoredSuperClass
  include IgnoredModule

  # DDOC 2018-06-17
  # @return [String] Example "class_method return value"
  # @caller [/Users/richardlynch/Development/ddoc/ddoc/spec/ddoc_spec.rb:22:in `block (3 levels) in <top (required)>']
  def self.class_method
    return "class_method return value"
  end

  def self.class_method_with_args(arg1, arg2 = nil, arg3:)
    return arg3
  end

  def self.class_method_with_block
    yield
  end

  # DDOC 2018-06-17
  # @param  [String] ivar Example "foo"
  # @return [String] Example "foo"
  # @caller [/Users/richardlynch/Development/ddoc/ddoc/spec/ddoc_spec.rb:23:in `new']
  def initialize(ivar)
    @ivar = ivar
  end

  def instance_method
    super
    return @ivar
  end

  # DDOC 2018-06-17
  # @param  [Integer] args Example 7
  # @return [Array] Example [7]
  # @caller [/Users/richardlynch/Development/ddoc/ddoc/spec/ddoc_spec.rb:23:in `block (3 levels) in <top (required)>']
  def instance_method_with_args(*args)
    return *args
  end

  def instance_method_with_args_and_block(arg1)
    yield arg1
  end

  Ddoc.document! self, File.dirname(__FILE__) + '/default_result.ddoc.rb'
end

