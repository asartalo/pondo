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

export function visitPage(page) {
  cy.visit(pages[page].path);
}

function hasContentFor(page) {
  cy.contains(pages[page].content);
}

Given("I'm a regular visitor", () => {
  console.log("Nothing to do here");
});

Given("I own a ledger", () => {
  cy.pondoScript('create_ledger', users.jane).as('ownLedger');
});

When("I visit the {string} page", visitPage);

When("I choose to create a ledger on the welcome page", () => {
  cy.get('#first-time .button.primary').click();
});

Then("I should see the {string} page", page => {
  hasContentFor(page);
});

Then("I should be greeted with a welcome", () => {
  hasContentFor('welcome');
});

Then("I should see the UI to create my first ledger", () => {
  cy.get('#create-ledger').contains('Create Ledger');
});

Then(/^I can set my first ledger's name to '([^']*)'$/, name => {
  cy.findField('Ledger Name')
    .clear()
    .type(name);
});

Then(/^I can set the currency to '([^']*)'$/, currency => {
  cy.findField('Currency').select('PHP');
});

function queryLedgerSize(user, then) {
  return cy.pondoRun(`User.find_by(email: "${user.email}").owned_ledgers.size`)
    .then(then);
}

Then("I can save the ledger", () => {
  queryLedgerSize(users.jane, size => expect(size).to.equal(0));
  cy.findButton('Save Ledger').click();
  queryLedgerSize(users.jane, size => expect(size).to.equal(1));
});

Then(/I can see the '([^']*)' ledger on the header/, name => {
  cy.get('.header-title').should('contain', name);
});

Then(/^I should see (.+) ledger page$/, ledger_called => {
  cy.pondoTest('ledger', {email: users.jane.email}).then(ledger => {
    return cy.url().should('include', `/ledgers/${ledger.id}`);
  });
});
