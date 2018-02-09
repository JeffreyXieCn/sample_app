require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  #Capybara::Selenium::Driver.new(app, :browser => :chrome,:driver_path => "D:\Bitnami\rubystack-2.3.4-6\chromedriver_win32\chromedriver.exe")
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome,:driver_path => "D:\Bitnami\rubystack-2.3.4-6\chromedriver_win32\chromedriver.exe")
  end

  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
end