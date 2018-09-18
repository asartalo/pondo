describe('Visiting the homepage', () => {
	it('works', () => {
		cy.app('clean');
		cy.visit('/');
	});
});

