module Ddoc
  class Documenter
    Annotation = Struct.new(:line_number, :content)

    def initialize(in_file_name, out_file_name, &block)
      @in_file_name  = in_file_name
      @out_file_name = out_file_name
      @annotations   = []
      @formatter     = block

      ObjectSpace.define_finalizer(self, proc { finalize! })
    end

    def call(name, params, args, block, value, calls, source_location)
      _, line_number = source_location
      content = @formatter.call(name, params, args, !!block, value, calls, source_location).to_s
      @annotations << Annotation.new(line_number, content)
    end

    def to_proc
      proc { |*args| call(*args) }
    end

    private

    def finalize!
      original_file = File.read(@in_file_name)
      lines = original_file.to_s.split("\n")
      documented_lines = lines.each_with_index.map do |line, i|
        annotation_for_line(line, i)
      end
      File.write @out_file_name, documented_lines.join("\n")
    end

    def annotation_for_line(line, line_number)
      annotation = @annotations.detect { |a| a.line_number == line_number + 1 }
      if annotation
        content = indent(annotation.content, line)
        "#{content}\n#{line}"
      else
        line
      end
    end

    def indent(content, line)
      leading_white_space_count = line[/\A */].size
      leading_spaces = " " * leading_white_space_count
      indented_content = content.split("\n").map do |content_line|
        leading_spaces + content_line
      end.join("\n")
    end
  end
end
