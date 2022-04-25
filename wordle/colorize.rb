require 'colorize'

module Colorize
  def green(string)
    string.colorize(background: :light_green)
  end

  def yellow(string)
    string.colorize(background: :light_yellow)
  end

  def gray(string)
    string.colorize(background: :light_white)
  end

  def red(string)
    string.colorize(color: :red)
  end
end
