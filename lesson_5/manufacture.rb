module Manufacture
  def set_manufacture
    self.manufacture = gets.chomp
  end
  protected
  attr_accessor :manufacture
end