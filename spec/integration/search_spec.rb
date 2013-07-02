require "spec_helper"

feature "Search for RSpec" do

  scenario "should find the RSpec homepage" do
    #debugger
    visit "http://www.google.com"
    fill_in "q", :with => "RSpec"
    find_field("q").native.send_key("return".to_sym)

    page.should have_content("RSpec.info")
  end

end
