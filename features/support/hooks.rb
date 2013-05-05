AfterStep('@pause') do
  print "Press Return to continue..."
  STDIN.getc
end

Before do |scenario|
  debug_stdout "I am before all: #{scenario.name}"
  if ENV.key? 'USE_CLEANER'
    debug_stdout "Starting DatabaseCleaner..."
    DatabaseCleaner.start
  end
  begin
    while page.driver.browser.window_handles.length > 1 
      debug_stdout "CLOSING extra popup windows"
      page.driver.browser.switch_to.window(page.driver.browser.window_handles.last)
      page.driver.browser.close
    end
    # if you actually have to close any lingering popup windows, this next line
    # is necessary to refocus the driver on the main window.
    page.driver.browser.switch_to.window(page.driver.browser.window_handles.first)
  rescue StandardError
  end
end

# cleanup
After do |scenario|
  debug_stdout "I am after all: #{scenario.failed?}"
  if ENV.key? 'USE_CLEANER'
    # note: puts doesn't work in After when pretty printing in use
    # see this: http://stackoverflow.com/questions/10526894/cucumber-puts-in-after-hook-not-outputting-anything
    debug_stdout "Cleaning using DatabaseCleaner..."
    DatabaseCleaner.clean
  else
    debug_stdout "No Clean!"
  end
end

# Note: for some reason After wasn't being executed?
Around do |scenario, block|
  debug_stdout "I am around/before all: #{scenario.name} #{ContentPermission.count}"

  block.call
  
  debug_stdout "Users: #{User.count}"
  debug_stdout "Registries: #{Registry.count}"
  debug_stdout "Centers: #{Center.count}"
  debug_stdout "Regcenters: #{Regcenter.count}"
  debug_stdout "RegcenterUsers: #{RegcenterUser.count}"
  debug_stdout "Userroles: #{UserRole.count}"
  debug_stdout "I am around/after all: #{scenario.failed?} #{ContentPermission.count}"
end


