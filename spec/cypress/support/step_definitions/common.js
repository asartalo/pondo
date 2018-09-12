Given("I'm a regular visitor", (e) => {
	console.log("Nothing to do here")
})

When("I visit the {string} page", (page) => {
	cy.visit("/")
})

Then("I should see {string} page", (page) => {
	cy.contains("Expense Tracking for the Masses")
})
