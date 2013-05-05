Then(/^I clear the dowloaded files$/) do
  clear_downloads
end

Given /^I should see the "([^"]*)" file in downloads folder$/ do |filename|
  File.exists?(ENV['DOWNLOAD_DIR']+'/'+file_name).should be_true
end