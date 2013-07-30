#http://coryschires.com/ten-tips-for-writing-better-cucumber-steps/
CAPTURE_A_NUMBER = Transform /^\d+$/ do |number|
  number.to_i
end

CAPTURE_A_FLOAT = Transform /^\d+$/ do |number|
  number.to_f
end
