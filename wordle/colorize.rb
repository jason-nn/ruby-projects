require 'colorize'

module Colorize
  def green(string)
    string.black.on_light_green
  end

  def yellow(string)
    string.black.on_light_yellow
  end

  def gray(string)
    string.black.on_light_white
  end

  def red(string)
    string.red
  end
end
