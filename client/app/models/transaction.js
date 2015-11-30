import DS from 'ember-data';
const attr = DS.attr;

export default DS.Model.extend({
  amount: attr('number'),
  account: attr('string'),
  postedAt: attr('date'),
  note: attr('string'),
  description: attr('string'),
  transactionType: attr('string'),
});
