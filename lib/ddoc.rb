require "ddoc/version"
require "ddoc/watcher"
require "ddoc/documenter"
require "ddoc/formatter"

module Ddoc
  def self.document!(klass, out_file_name = nil)
    formatter = proc { |*args| Ddoc::Formatter.new(*args).to_s }

    file_names = caller.map { |file_and_caller| file_and_caller.split(':').first }

    in_file_name = file_names.first

    out_file_name = out_file_name ? out_file_name : in_file_name

    documenter = Ddoc::Documenter.new(in_file_name, out_file_name, &formatter)

    Ddoc::Watcher.new(klass, &documenter).watch!
  end
end
