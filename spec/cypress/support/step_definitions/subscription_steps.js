import users from '../../fixtures/users';

Given(/^A user invited me to a ledger$/, () => {
  cy.pondoScript('invite', {
    sender: users.jessy,
    my_email: users.jane.email
  }).as('inviteData');
});

When(/^I invite '(.+)'$/, emailAddress => {
  cy.get('[href="#header-menu"]').click();
  cy.findLink('Invite Subscribers').click();
  cy.get('#invite-section').within(() => {
    cy.findField('Email').clear().type(emailAddress);
    cy.findButton('Send Invitation').click();
  });
});

When('I follow the ledger subscription link', () => {
  cy.get('@inviteData').then(data => {
    const { subscription } = data;
    cy.pondoRun(`subscription_path Subscription.find('${subscription.id}')`)
      .then(url => {
        cy.visit(url);
      });
  })
});

When('the invite is used', () => {
  cy.get('@inviteData').then(({ subscription }) => {
    cy.pondoRun(`Subscription.find('${subscription.id}').update(done: true)`);
  });
});

Then(/^the system should send an invite to '(.+)'$/, emailAddress => {
  cy.contains('Invitation Sent');
  cy.pondoScript('last_email_delivery').then(email => {
    cy.wrap(email).should('eql', emailAddress);
  });
});

Then('I should see a link to subscribe to the ledger', () => {
  cy.get('@inviteData').then(inviteData => {
    const { ledger } = inviteData;
    cy.get('body')
      .should('contain', 'You have been invited to contribute to:')
      .and('contain', ledger.name)
  });
  cy.findLink('Subscribe');
});

Then('I should be able to subscribe to the ledger', () => {
  cy.get('.body').within(() => {
    cy.findLink('Subscribe').click();
  });
  cy.get('@inviteData').then(inviteData => {
    const { ledger, subscription } = inviteData;
    cy.get('body').should('contain', ledger.name)
    cy.pondoScript(
      'find_user_subscription',
      {
        email: users.jane.email,
        ledger: ledger.id,
      }
    ).its('id').should('not.eql', null);
  });
});

Then('I should see the ledger', () => {
  cy.get('@inviteData').then(({ ledger }) => {
    cy.get('header').contains(ledger.name);
  });
});
