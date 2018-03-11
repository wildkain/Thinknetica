require_relative 'lib/modules/accessors.rb'

class Test
  extend Accessors

  attr_accessors_with_history :one, :two, :three
  strong_attr_accessor :strong, Fixnum
end

try1 = Test.new

try1.one = 15
try1.one = 2
p try1.one_history

try1.strong = 12

p try1.strong
