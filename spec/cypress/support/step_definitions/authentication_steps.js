import { visitPage } from './common';
import users from '../../fixtures/users';

export function logIn() {
  cy.get('.button.primary').click();
};

export function iAmLoggedIn() {
  visitPage('home');
  logIn();
  cy.url().should('not.eql', Cypress.config().baseUrl + '/');
}

Given("I am not logged in", () => {
  // nothing to do here
});

Given("I am logged in", iAmLoggedIn);

Given(/^I have (a|a different) google account$/, account => {
  const user = (account == 'a different') ? users.john : users.jane;
  cy.pondoScript('stub_auth_response', user);
});

Given("I don't have a google account", () => {
  cy.pondoScript('stub_auth_response', { no_account: true });
});

Given("I am a user", () => {
  cy.pondoScript('create_user', users.jane)
  cy.pondoScript('stub_auth_response', users.jane)
});

When("I log in", logIn);
When("I log in for the first time", iAmLoggedIn);
When("I log in from home", iAmLoggedIn);
When("I click link to sign up", () => {
  cy.findLink("Sign in With Google").click();
  cy.url().should('not.eql', Cypress.config().baseUrl + '/');
});
