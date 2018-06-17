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
        formated_params,
        formated_return
      ].compact.join("\n")
    end

    private

    def formated_params
      out = params.zip(args).map do |(type, name), arg|
        "# @param  [#{arg.class}] #{name} Example #{arg.inspect}"
      end.join("\n")
      out.empty? ? nil : out
    end

    def formated_return
      "# @return [#{value.class}] Example #{value.inspect}"
    end
  end
end
