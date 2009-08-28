#! /usr/bin/ruby -s
#
# examples --- extract code examples from Pharo by Example LaTeX source
#
# $Id: examples.rb 12123 2007-09-22 09:04:38Z oscar $
# ============================================================
Header = <<eof

===== PHARO BY EXAMPLE ==========

Below follow all the (displayed) code examples from the book "Pharo by
Example".

For details about this book, see: http://pharo-project.org/PharoByExample

The examples are provided, as is, for your convenience, in case you want
to copy and paste fragments to Pharo to try out.

Note that in almost all cases the annotation "--> ..." suggests that you
can select and apply <print it> to the previous expression and you should
obtain as a result the value following the arrow.

Many of these actually serve as test cases for the book. For more details
about testing, see the Wiki link under:

http://www.squeaksource.com/SBEtesting.html
eof
# ============================================================
def main
  puts Header
  ARGV.each do |arg|
    ch = Chapter.new arg
    puts ch
  end
end
# ============================================================
class Chapter
  attr_reader :name, :title, :code
  # ----------------------------------------------------------
  def initialize name
    @name = name
    @title = "<unknown>"
    @code = ""
    file_name = name + "/" + name + ".tex"
    file = File.open file_name
    while !(file.eof?)
      line = file.readline
      case
      # grab chapter title
      when line =~ /\\chapter\{([^}]*)\}/
        @title = $1
        @title.gsub!(/\\pharo/, "Pharo") # Expand macros
        @title.gsub!(/\\st/, "Smalltalk")
      # look for the code listing environments
      when line =~ /^\\begin\{(code|example|script|classdef|methods?|numMethod)\}/
        @code << get_code(file)
      end
    end
  end
  # ----------------------------------------------------------
  private
  def get_code file
    code = String.new
    line = file.readline
    while !(line =~ /^\\end\{/)
      # comment out --> incantation
      line.gsub!(/\s*(-->[^"\r\n]*)/, ' "\1" ')
      # translate listings macros
      line.gsub!(/>>>/, '>>')
      line.gsub!(/BANG/, '!')
      line.gsub!(/UNDERSCORE/, '_') # not needed ?
      # compact extra space around comments
      line.gsub!(/" +/, '"')
      line.gsub!(/""/, '')
      line.gsub!(/ +"/, ' "')
      code << line
      line = file.readline
    end
    return code + "-----\n"
  end
  # ----------------------------------------------------------
  public
  def to_s
    "\n===== CHAPTER: " + @title + " ==========\n\n-----\n" + code
  end
  # ----------------------------------------------------------
end
# ============================================================
main
# ============================================================
