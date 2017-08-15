When(/^I invite "(.+)"$/) do |email_address|
  find_link("Menu").click
  find_link("Invite Subscribers").click
  within '#invite-section' do
    fill_in "Email", with: email_address
    click_button "Send Invitation"
  end
end

Then(/^the system should send an invite to "(.+)"$/) do |email_address|
  expect(page).to have_content("Invitation Sent")
  email = ActionMailer::Base.deliveries.first
  expect(email).not_to be_blank
  expect(email.to.first).to eql(email_address)
end
