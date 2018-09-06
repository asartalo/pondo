Given(/^A user invited me to a ledger$/) do
  @inviter = User.where(email: "jane.doe@gmail.com").first_or_create
  builder = LedgerBuilder.make(@inviter)
  @invited_ledger = builder.create_ledger(currency: "USD")
  manager = LedgerManager.new(@invited_ledger, @inviter)
  manager.invite("john.doe@gmail.com")
  @subscription = Subscription.last
end

Given(/^the invite is used$/) do
  @subscription.update(done: true)
end

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

Then(/^I should see a link to subscribe to the ledger$/) do
  expect(page).to have_content("You have been invited to contribute to:")
  expect(page).to have_content(@invited_ledger.name)
  find_link("Subscribe")
end

When(/^I follow the ledger subscription link$/) do
  visit(subscription_path(@subscription))
end

Then(/^I should see the ledger$/) do
  expect(page).to have_content(@invited_ledger.name)
end

Then(/^I should be able to subscribe to the ledger$/) do
  find_link("Subscribe").click
  expect(page).to have_content(@invited_ledger.name)
  me = User.find_by(email:"john.doe@gmail.com")
  subscribed = me.subscribed_ledgers.find(@invited_ledger.id)
  expect(subscribed).not_to be_blank
end
