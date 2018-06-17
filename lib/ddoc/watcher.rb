module Ddoc
  class Watcher
    attr_reader :klass, :subscriber, :instance_module, :klass_module

    def initialize(klass, &block)
      @klass = klass
      @subscriber = block ? block : proc {  }
      @instance_module = Module.new
      @klass_module = Module.new
    end

    def watch!
      watch_class_methods
      watch_instance_methods
    end

    private

    def watch_instance_methods
      instance_methods.each { |sym| capture_method(sym, instance_module, subscriber) }
      klass.send(:prepend, instance_module)
    end

    def instance_methods
      [:initialize, klass.instance_methods - klass.superclass.instance_methods].flatten
    end

    def watch_class_methods
      klass_methods.each { |sym| capture_method(sym, klass_module, subscriber) }
      klass.singleton_class.send(:prepend, klass_module)
    end

    def klass_methods
      klass.methods - klass.superclass.methods
    end

    def capture_method(sym, modulE, subscriber)
      modulE.send(:define_method, sym) do |*args, &block|
        original_method = method(sym).super_method
        source_location = original_method.source_location
        parameters = original_method.parameters
        return_value = original_method.call(*args, &block)
        subscriber.call(sym, parameters, args, block, return_value, caller, source_location)
        return_value
      end
    end
  end
end
