// CypressDev: dont remove these command
Cypress.Commands.add('appCommands', function (body) {
  cy.log("APP: " + JSON.stringify(body))
  cy.request({
    method: 'POST',
    url: "/__cypress__/command",
    body: JSON.stringify(body),
    log: true,
    failOnStatusCode: true
  })
});

Cypress.Commands.add('app', function (name, command_options) {
  cy.appCommands({name: name, options: command_options})
});

Cypress.Commands.add('appScenario', function (name) {
  cy.app('scenarios/' + name)
});

Cypress.Commands.add('appEval', function (code) {
  cy.app('eval', code)
});

Cypress.Commands.add('appFactories', function (options) {
  cy.app('factory_bot', options)
});

Cypress.Commands.add('appFixtures', function (options) {
  cy.app('activerecord_fixtures', options)
});

// CypressDev: end

Cypress.Commands.add('pondoTest', function (item, params) {
  cy.log("PONDO_TEST: " + item)
  cy.request({
    method: 'GET',
    url: `/test/${item}`,
    body: params,
    log: true,
    failOnStatusCode: true
  }).then(response => response.body);
});

Cypress.Commands.add('pondoRun', function (code) {
  cy.log("PONDO_RUN: " + code)
  cy.request({
    method: 'POST',
    url: '/test/run',
    body: { code },
    log: true,
    failOnStatusCode: true
  }).then(response => response.body);
});
// The next is optional
// beforeEach(() => {
//  cy.app('clean') // have a look at cypress/app_commands/clean.rb
// });
