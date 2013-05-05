When /^(?:|I )reload the page$/ do
  case Capybara::current_driver
  when :selenium
    visit page.driver.browser.current_url
  when :racktest
    visit [ current_path, page.driver.last_request.env['QUERY_STRING'] ].reject(&:blank?).join('?')
  when :culerity
    page.driver.browser.refresh
  else
    raise "unsupported driver, use rack::test or selenium/webdriver"
  end
end

Given /^test suite is using "([^"]*)" driver$/ do |driver|
  Capybara.current_driver = driver.to_sym
end

Given /^(?:|I am )on the "([^"]*)" page$/ do |url|
  visit(url)
end

Given /^I am on the home page$/ do
  visit('/ncr')
end

Given /^I have entered "([^"]*)" into the "([^"]*)" field$/ do |text, field|
  fill_in field, :with => text
end

When /^I click the "([^"]*)" button$/ do |button_text|
  click_button button_text
end

Then /^(?:|I )should (not )?see "([^"]*)"$/ do |should_not, text|
  if should_not.present?
    page.should have_no_content(text)
  else
    page.should have_content(text)
  end
end

When /^(?:|I )choose "([^"]*)"$/ do |radio_button|
  choose(radio_button)
end

Then /^(?:|I )should see "([^"]*)" is filled with "([^"]*)"$/ do |field, value|
  find_field(field).value.should == value
end

Then /^(?:|I )should see "([^"]*)" is selected with "([^"]*)"$/ do |field, value|
  status = page.has_select?(field, :selected => value).should be_true
end

# image check
Then /^(?:|I )should see "([^"]*)" image$/ do |image|
  page.should have_selector("img[src*=#{image}]")
end

# exact matches
When /^(?:|I )click the button which has text exactly as "([^"]*)"$/ do |button_text|
  page.find(:xpath, "//input[@type='button'][@value='#{button_text}']").click
end

# alerts
When /^(?:|I )have accepted the confirmation dialog$/ do 
  page.driver.browser.switch_to.alert.accept
end

When /^(?:|I )have dismissed the confirmation dialog$/ do
  page.driver.browser.switch_to.alert.dismiss
end

Then /^(?:|I )should see popup message includes "([^"]*)"$/ do |msg|
  page.driver.browser.switch_to.alert.text.should include(msg)
end

Then /^(?:|I )should not see any popup message$/ do
  msg = page.driver.browser.switch_to.alert rescue $!
  msg.to_s.should include('No alert is present')
end

#http://www.quora.com/How-can-I-detect-if-a-popup-new-window-is-open-or-not
#didnt work for alert messages!
Then /^no popups should be open$/ do   
  page.driver.browser.window_handles.length.should == 1
  msgs = page.driver.browser.window_handles.last
end

# pop-up windows
Then /^tests focus on popup window$/ do
  popup = page.driver.browser.window_handles.last
  page.driver.browser.switch_to.window(popup)
end

Then /^(?:|I )close the focused page$/ do
  page.driver.browser.close
end



