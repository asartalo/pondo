import users from '../../fixtures/users';
const shared = {};

const pages = {
  home: {
    path: '/',
    content: 'Expense Tracking for the Masses',
  },

  welcome: {
    path: '/welcome',
    content: 'Welcome to Pondo!',
  },
};

Given("I'm a regular visitor", () => {
  console.log("Nothing to do here");
});

Given("I own a ledger", () => {
  cy.app('create_ledger', users.jane);
});

export function visitPage(page) {
  cy.visit(pages[page].path);
}

When("I visit the {string} page", visitPage);

Then("I should see the {string} page", page => {
  cy.contains(pages[page].content);
});

Then(/^I should see (.+) ledger page$/, ledger_called => {
  cy.pondoTest('ledger', {email: users.jane.email}).then(ledger => {
    return cy.url().should('include', `/ledgers/${ledger.id}`);
  });
});
