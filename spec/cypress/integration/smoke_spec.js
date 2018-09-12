describe('visit homepage', () => {
	it('works', () => {
		cy.app('clean');
		cy.visit('/');
	});
});

