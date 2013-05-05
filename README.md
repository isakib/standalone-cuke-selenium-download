= Standalone Cucumber Test Suite with Selenium Download

== Introduction

 As growing interest in BDD and continous integration, standalone cucumbers became good start for making test suite for non rails projects too. 
 
 This repo contains additional setups for selenium (click and) download and more step_definitions to accomdate
  - to check there is no traditional javascript popups opened
  - debugging : debugging was very useful to find xpath to locate the interested elements
  - javascript ajax requests check
  - javascript change event trigger

 Pull requests with updates/enhancements/bug fixes/adding bugs too are always welcome!

== References

 This is extension of standalone-cucumber; https://github.com/thuss/standalone-cucumber

 Download module is modified from the original version available in https://github.com/ninjapanzer/cuke-capy-chrome

== Project Layout

* features/*.feature : cucumber features
* features/step_definitions/web_steps.rb : generic steps that apply to all features
* features/step_definitions/[feature]_steps.rb : steps specific to an individual feature file
* features/step_definitions/debug_steps.rb : generic debug steps, debug 
* support/env.rb : configures the driver (download settings) and the hostname to use
* support/hooks.rb : pause step
* support/download.rb : download file checkings and cleanups
* support/javascript.rb : javascript triggers and ajax request completion check
* tmp/downloads : download directory
* config/cucumber.yml : default cuke running setups
* .rdebugrc : debugger setups

== Prerequisites

* Ruby http://www.ruby-lang.org/en/downloads/
* Ruby Gems http://rubygems.org/
* Bundler: gem install bundler rake

== Configuration

* bundle install

== Running Features

* To run all features: rake
* To run a specific feature: cucumber features/search.feature

== Debugging

* To debug a specific step call save_and_open_page within the step
* Use 'I debug' step
* Use 'debugger' in step definitions 

== Selenium profile configuration

* Use Firefox -> Preferences/Options -> Application tab for finding suitable file type to be added in 'browser.helperApps.neverAsk.saveToDisk' list
* More info mozilla {about:config}[http://kb.mozillazine.org/Firefox_:_FAQs_:_About:config_Entries]
  

== Additional Documentation

* http://cukes.info (for general cucumber information)
* http://github.com/jnicklas/capybara (for actions such as click_link, click_button, etc...)
* Person sitting next to you, who may know more about your skills!

== More info

 Visit https://github.com/thuss/standalone-cucumber 
 
 Visit https://github.com/ninjapanzer/cuke-capy-chrome
 
 Visit http://cukes.info/
 
 Visit https://github.com/sivajankan/standalone-cuke-selenium-dwnld
 
== Contributor

* {Siva Kandasamy}[http://www.linkedin.com/pub/siva-kandasamy/7/19b/483]

