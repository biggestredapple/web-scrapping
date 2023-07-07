require 'capybara/dsl'

include Capybara::DSL

Capybara.current_driver = Capybara.javascript_driver
Capybara.app_host = 'http://techcareerbooster-fake-data.herokuapp.com'

visit '/exercises_and_code/students/new'

fill_in 'Name', with: 'John'
fill_in 'Email', with: 'john@mailinator.com'
fill_in 'Street number', with: '46232 Connelly Neck'
fill_in 'City', with: 'North Maudie'
fill_in 'Zip code', with: '62178'
select 'Bolivia', from: 'Country'

click_button 'Create Student'

find('.alert-success', text: 'Right! Student has been registered')