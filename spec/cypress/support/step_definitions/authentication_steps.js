import Pending from 'mocha/lib/pending';

const users = {
  john: {
    name: "John Doe",
    email: "john.doe@gmail.com",
    uid: "999999999999999999999",
  },
  jane: {
    name: "Jane Doe",
    email: "jd@gmail.com",
    uid: "888888888888888888888",
  }
};

Given("I am not logged in", () => {
  // nothing to do here
});

Given(/^I have (a|a different) google account$/, (account) => {
  const user = (account == 'a different') ? users.john : users.jane;
  cy.app('stub_auth_response', user);
});

When("I log in", () => {
  cy.get('.button.primary').click();
});

Then("I should see the {string} page", page => {
  cy.contains('Welcome to Pondo!');
});
