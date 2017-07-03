Given(/^This is the first page visit$/) do
  @initial_page_loads = jscript('pondoTesting.domLoadCount()').to_i
end

When(/^I click on the '([^']*)' hyperlink$/) do |name|
  find_link(name).click
end

When(/^I check the page loads$/) do
  @last_page_loads_check = jscript('pondoTesting.domLoadCount()').to_i
end

Then(/^the '([^']*)' page should be loaded through ajax$/) do |name|
  expect_nitro_page_fetched(name).to eql(true)
  expect_nitro_page_loaded(name).not_to eql(true)
  expect_page_content_to_be_loaded(name)
end

Then(/^the '([^']*)' page should be loaded from cache$/) do |name|
  expect_nitro_page_fetched(name).not_to eql(true)
  expect_nitro_page_loaded(name).not_to eql(true)
  expect_page_content_to_be_loaded(name)
end
