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

When("I visit the {string} page", page => {
  cy.visit(pages[page].path);
});

Then("I should see {string} page", page => {
  cy.contains(pages[page].content);
});
