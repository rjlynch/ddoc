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

  def self.class_method
    return "class_method return value"
  end

  def self.class_method_with_args(arg1, arg2 = nil, arg3:)
    return arg3
  end

  def self.class_method_with_block
    yield
  end

  def initialize(ivar)
    @ivar = ivar
  end

  def instance_method
    super
    return @ivar
  end

  def instance_method_with_args(*args)
    return *args
  end

  def instance_method_with_args_and_block(arg1)
    yield arg1
  end

  Ddoc.document! self, File.dirname(__FILE__) + '/default_result.ddoc.rb'
end
