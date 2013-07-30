When 'I debug' do
  require 'ruby-debug'; Debugger.start; Debugger.settings[:autoeval] = 1; Debugger.settings[:autolist] = 1; debugger
  $cucumber_debugged = true
end

When /^(?:|I )wait (#{CAPTURE_A_NUMBER}) seconds?$/ do |seconds|
  sleep seconds
end

When /^(?:|I )wait 1\/(#{CAPTURE_A_FLOAT})(?:|rd|th) of a second?$/ do |fraction| 
  sleep 1/fraction
end

Then /^show me the page$/ do
  save_and_open_page
end
