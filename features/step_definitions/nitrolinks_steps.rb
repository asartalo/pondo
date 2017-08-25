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
  wait_for_page_load
  expect_nitro_page_fetched(name).to eql(true)
  expect_nitro_page_loaded(name).not_to eql(true)
  expect_page_content_to_be_loaded(name)
end

Then(/^the '([^']*)' page should be loaded from cache$/) do |name|
  wait_for_page_load
  expect_nitro_page_restored(name).to eql(true), "Page #{name} (#{pondo_page(name)}) has not been restored from cache"
  expect_page_content_to_be_loaded(name)
end

Then(/^the '([^']*)' page should be loaded normally$/) do |name|
  expect_nitro_page_loaded(name).to eql(true)
  expect_page_content_to_be_loaded(name)
end

When(/^I enter '([^']*)' on the '([^']*)' text field$/) do |value, field|
  fill_in(field, with: value)
end

When(/^I hit the '([^']*)' button$/) do |value|
  find_button(value).click
  sleep 0.2
end

When(/^I check the random uuid value on page$/) do
  @nitro_page_uuid = page.find_by_id("unique").text
end

Then(/^I should see a new uuid value on page$/) do
  current_nitro_page_uuid = page.find_by_id("unique").text
  expect(current_nitro_page_uuid).not_to eql(@nitro_page_uuid)
end

Then(/^I should not see a new uuid value on page$/) do
  current_nitro_page_uuid = page.find_by_id("unique").text
  expect(current_nitro_page_uuid).to eql(@nitro_page_uuid)
end

Then(/^The '([^']*)' page should not be loaded in anyway$/) do |name|
  expect_nitro_page_fetched(name).not_to eql(true)
end

Then(/^There should not be any javascript errors$/) do
  expect_no_js_errors
end

Then(/^the nitro load event should fire (\d+) times?$/) do |times|
  expect_nitro_load_count.to eql(times.to_i)
end

Then(/^I should see the "(\d+)" page?$/) do |the_page|
  if the_page == "404"
    # suppress_warnings
    expect(page).to have_content("The page you were looking for does not exist")
  end
end
