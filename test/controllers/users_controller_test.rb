require 'test_helper'

module MyModule
  include Capybara::DSL

  def login!
    within(:xpath, ".//form[@id='session']") do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
    end
    p 'really?'
    click_button 'Sign in'
  end
end
