import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('category/transactions-list-item', 'Integration | Component | category/transactions list item', {
  integration: true
});

test('it renders', function(assert) {
  
  // Set any properties with this.set('myProperty', 'value');
  // Handle any actions with this.on('myAction', function(val) { ... });" + EOL + EOL +

  this.render(hbs`{{category/transactions-list-item}}`);

  assert.equal(this.$().text().trim(), '');

  // Template block usage:" + EOL +
  this.render(hbs`
    {{#category/transactions-list-item}}
      template block text
    {{/category/transactions-list-item}}
  `);

  assert.equal(this.$().text().trim(), 'template block text');
});
