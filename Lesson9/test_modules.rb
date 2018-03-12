require_relative 'lib/modules/accessors.rb'

class Test
  extend Accessors

  attr_accessors_with_history :one, :two, :three
  strong_attr_accessor :strong, Fixnum

  def initialize(one)
    @one = one
  end

end

try1 = Test.new("FRSTSTATION")

try1.one_history
p try1.one = "FirstValue"
p try1.one_history
try1.one = "SecondValue"
try1.one = "ThirdValue"
p try1.one_history

try1.strong = 12

p try1.strong
