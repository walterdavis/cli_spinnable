# frozen_string_literal: true

module CliSpinnable
  class Line
    class Error < CliSpinnableError; end

    CARRIAGE_RETURN = "\r"
    NEWLINE = "\n"

    attr_accessor :newline

    def initialize(str = nil, sign = nil, newline = nil)
      @arr = [str]
      @sign = Sign.new(sign)
      self.newline = newline
    end

    def sign=(sym)
      sign.sign = sym
    end

    def <<(arg)
      arr << ensure_single_line(String(arg))
    end

    def str=(arg)
      self.arr = [ensure_single_line(String(arg))]
    end

    def to_s_resetting_newline
      [CARRIAGE_RETURN, sign, str, newline_with_reset].join
    end
    
    def str
      arr.join
    end

    private

    attr_reader :sign
    attr_accessor :arr

    def ensure_single_line(str)
      raise Error, 'Multiline strings not allowed' if str.include?(NEWLINE)

      str
    end

    def newline_with_reset
      return unless newline

      self.newline = false
      NEWLINE
    end
  end
end
