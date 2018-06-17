module Ddoc
  class Formatter
    require 'date'

    attr_reader :name, :params, :args, :block, :value, :calls

    def initialize(name, params, args, block, value, calls, source_location)
      @name   = name
      @params = params
      @args   = args
      @block  = block
      @value  = value
      @calls  = calls
    end

    def to_s
      [
        "# DDOC #{Date.today}",
        formatted_params,
        formatted_return,
        formatted_caller
      ].compact.join("\n")
    end

    private

    def formatted_params
      out = params.zip(args).map do |(type, name), arg|
        "# @param  [#{arg.class}] #{name} Example #{arg.inspect}"
      end.join("\n")
      out.empty? ? nil : out
    end

    def formatted_return
      "# @return [#{value.class}] Example #{value.inspect}"
    end

    def formatted_caller
      "# @caller [#{calls.first}]"
    end
  end
end
