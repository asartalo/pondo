function titleize(string) {
  return string.split(/\s/)
    .map(word => `${word[0].toUpperCase()}${word.slice(1)}`)
    .join(" ");
}

function sectionId(kind) {
  return incomeOrExpense(
    kind, '#add-income-section', '#deduct-expense-section'
  );
}

function incomeOrExpense(kind, first = 'income', second = 'expense') {
  return kind.match(/income/) ? first : second;
}

function dateFieldFriendly(dateString) {
  return dateString.split('/').reverse().join('-');
}

When(/^I select the (add income|deduct expense) section$/, section => {
  cy.findLink(titleize(section)).click();
});

When(/^I set the (income source|expense type) to '([^']*)'$/, (kind, type) => {
  cy.wrap(type).as("moveType");
  const kindText = incomeOrExpense(kind, "Source", "Type");
  cy.get(sectionId(kind))
    .within(() => {
      cy.findField(kindText)
        .select(type);
    });
});

When(/^I (could ){0,1}set the (income|expense) amount to (\d+)$/, (_, kind, amount) => {
  cy.wrap(amount).as("amount");
  cy.get(sectionId(kind))
    .within(() => {
      cy.findField('Amount')
        .clear()
        .type(amount);
    });
});

When(/^I set the (income|expense) date to ([\d\/]+)$/, (kind, date) => {
  cy.wrap(date).as("date");
  cy.get(sectionId(kind))
    .within(() => {
      cy.findField("Date")
        .type(dateFieldFriendly(date));
    });
});

When(/^I add an (income|expense) note to say '([^']*)'$/, (kind, note) => {
  cy.wrap(note).as("notes");
  cy.get(sectionId(kind))
    .within(() => {
      cy.findField("Notes")
        .clear()
        .type(note);
    });
});

When(/^I submit the (income|expense)$/, kind => {
  const buttonText = incomeOrExpense(kind, "Add Income", "Deduct Expense");
  cy.findButton(buttonText)
    .click();
});

Then(
  /^I should see the (income|expense) added to (my own) ledger$/,
  function (kind, theLedger) {
    const typeClass = incomeOrExpense(kind, "IncomeType", "ExpenseType");
    cy.getMulti('@amount', '@notes', '@date', '@moveType', '@ownLedger')
      .spread((amount, notes, date, moveType, ownLedger) => {
        cy.get('#money-moves').should('contain', amount)
        cy.pondoScript('find_money_move', {
          ledger_id: ownLedger.id,
          move_type: moveType,
          type_class: typeClass,
          kind, amount, notes,  date
        }).its('notes').should('eql', notes)
      });
  }
);

Then(/^the (income|expense) form should reset$/, kind => {
  cy.get(sectionId(kind)).within(() => {
    [
      'Amount', 'Date', 'Notes',
      incomeOrExpense(kind, 'Source', 'Type')
    ].forEach(field => {
      cy.findField(field).should('have.value', '');
    });
  });
});

Then(/^I should see the (income|expense) (.+) error$/, (kind, field) => {
  cy
    .get('.field_with_errors')
    .get(sectionId(kind))
    .within(() => {
      cy.findField(titleize(field)).should('match', '.field_with_errors > *');
    });
});
