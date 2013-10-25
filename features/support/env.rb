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

Capybara.register_driver :selenium do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile['browser.download.folderList'] = 2
  profile['browser.download.manager.showWhenStarting'] = false
  profile['browser.download.manager.useWindow'] = false
  profile['browser.download.useDownloadDir'] = true
  profile['browser.download.dir'] = ENV['DOWNLOAD_DIR']
  profile['browser.helperApps.neverAsk.saveToDisk'] = "application/x-tar,application/g-zip,application/zip,application/csv,application/excel,text/csv"
  #avoid print dialogs
  profile['capability.policy.default.Window.print'] = "noAccess"
  Capybara::Selenium::Driver.new(app, :profile => profile)  
end

Capybara.register_driver :remote_ie do |app|
  Capybara::Selenium::Driver.new(app,
                                 :browser => :remote,
                                 :url => "http://##IEMACHINEIP##:4444/wd/hub",
                                 :desired_capabilities => :internet_explorer) 
end

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome) 
end

Capybara.register_driver :selenium_safari do |app|
  debugger
  Capybara::Selenium::Driver.new(app, browser: :safari)
end

Capybara.register_driver :chrome_ext do |app|
  args = []
  args << "--window-size=1024,768"
  
  profile = Selenium::WebDriver::Chrome::Profile.new
  profile["download.prompt_for_download"] = false
  profile["download.default_directory"] = ENV['DOWNLOAD_DIR']
  
  chrome_switches = %w[--ignore-certificate-errors --disable-popup-blocking --disable-translate]
  caps_opts = {'chrome.switches' => chrome_switches}
  cap = Selenium::WebDriver::Remote::Capabilities.chrome caps_opts  
  
  Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: cap, args: args)
end

# Capybara.register_driver :selenium do |app|
  # if ENV['BROWSER']
    # if ENV['BROWSER'].downcase == 'ie'
      # Capybara::Selenium::Driver.new(app,
                                     # :browser => :remote,
                                     # :url => "http://##IEMACHINEIP##:4444/wd/hub",
                                     # :desired_capabilities => :internet_explorer) 
    # elsif ENV['BROWSER'].downcase == 'chrome'
      # #debugger
      # profile = Selenium::WebDriver::Chrome::Profile.new
      # profile["download.prompt_for_download"] = false
      # profile["download.default_directory"] = ENV['DOWNLOAD_DIR']
#       
      # #debugger
      # chrome_switches = %w[--ignore-certificate-errors --disable-popup-blocking --disable-translate]
      # caps_opts = {'chrome.switches' => chrome_switches}
      # cap = Selenium::WebDriver::Remote::Capabilities.chrome caps_opts
      # debugger
      # cap.browser_name = 'chrome'
      # cap.firefox_profile = profile
      # cap.javascript_enabled = true
      # args = []
      # args << "--window-size=1024,768"
      # #debugger
      # #Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: cap, args: args)
#       
      # opts = {desired_capabilities: cap, browser: :chrome, args: args}
      # Capybara::Selenium::Driver.new(app, opts)
#       
      # #Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: profile)
      # #args = []
      # #args << "--window-size=1024,768"
      # #prefs = "{'download' => {'default_directory' => #{ENV['DOWNLOAD_DIR']}}"
      # #prefs = '{"download": {"default_directory": "/Users/kandasamy/NewProjects/standalone-cuke-selenium-download/tmp/downloads"}}'
# 
      # #debugger
      # #Capybara::Selenium::Driver.new(app, browser: :chrome, profile: profile, args: args)
    # elsif ENV['BROWSER'].downcase == 'safari'
      # Capybara::Selenium::Driver.new(app, browser: :safari)
    # else
      # STDERR.puts 'INVALID BROWSER selection.'
      # exit 0
    # end
  # else
    # profile = Selenium::WebDriver::Firefox::Profile.new
    # profile['browser.download.folderList'] = 2
    # profile['browser.download.manager.showWhenStarting'] = false
    # profile['browser.download.manager.useWindow'] = false
    # profile['browser.download.useDownloadDir'] = true
    # profile['browser.download.dir'] = ENV['DOWNLOAD_DIR']
    # profile['browser.helperApps.neverAsk.saveToDisk'] = "application/x-tar,application/g-zip,application/zip,application/csv,application/excel,text/csv"
    # #avoid print dialogs
    # profile['capability.policy.default.Window.print'] = "noAccess"
    # Capybara::Selenium::Driver.new(app, :profile => profile)
  # end
# end

Capybara.app_host = 'http://www.google.com' 
Capybara.default_wait_time = 2

if ENV['BROWSER']
  if ENV['BROWSER'].downcase == 'ie'
    Capybara.default_driver = :remote_ie
  elsif ENV['BROWSER'].downcase == 'chrome'
    Capybara.default_driver = Capybara.javascript_driver = :selenium_chrome
  elsif ENV['BROWSER'].downcase == 'chrome_ext'
    debugger
    Capybara.default_driver = Capybara.javascript_driver = :chrome_ext
  elsif ENV['BROWSER'].downcase == 'safari'
    Capybara.default_driver = :selenium_safari
  else
    Capybara.default_driver = :selenium
  end
end

# #IE Config
# Capybara.register_driver :selenium do |app|
  # Capybara::Selenium::Driver.new(app,
    # :browser => :remote,
    # :url => "http://172.16.80.115:4444/wd/hub",
    # :desired_capabilities => :internet_explorer)
# end

Capybara.configure do |config|
  config.match = :one
  config.exact_options = true
  config.ignore_hidden_elements = true
  config.visible_text_only = true
end

World(Capybara) 
