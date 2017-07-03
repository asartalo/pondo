Given(/^This is the first page visit$/) do
  @initial_page_loads = page.evaluate_script('pondoTesting.domLoadCount()').to_i
end

When(/^I click on the '([^']*)' hyperlink$/) do |name|
  find_link(name).click
end

When(/^I check the page loads$/) do
  @last_page_loads_check = page.evaluate_script('pondoTesting.domLoadCount()').to_i
end

Then(/^the '([^']*)' page should be loaded through ajax$/) do |page|
  expect(@last_page_loads_check).to eql(@initial_page_loads)
end
