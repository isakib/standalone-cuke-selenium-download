begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end
require 'capybara' 
require 'capybara/dsl' 
require 'capybara/cucumber'
require 'launchy'
require 'debugger'
require 'capybara/rspec'
require 'selenium/webdriver'

ENV['ROOT_DIR'] = Dir.pwd
ENV['DOWNLOAD_DIR'] = "#{ENV['ROOT_DIR']}/tmp/downloads"

Capybara.default_driver = :selenium
Capybara.app_host = 'http://www.google.com' 
Capybara.default_wait_time = 2

Capybara.register_driver :selenium do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile['browser.download.folderList'] = 2
  profile['browser.download.manager.showWhenStarting'] = false
  profile['browser.download.manager.useWindow'] = false
  profile['browser.download.useDownloadDir'] = true
  profile['browser.download.dir'] = ENV['DOWNLOAD_DIR']
  profile['browser.helperApps.neverAsk.saveToDisk'] = "application/csv,application/excel,text/csv,application/x-tar,application/g-zip"
  Capybara::Selenium::Driver.new(app, :profile => profile)
end

World(Capybara) 
