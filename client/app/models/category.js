import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr('string'),
  usage: DS.attr('string'),
  transactions: DS.hasMany('transaction', {
    embedded: true
  }),
  matchers: DS.hasMany('matcher'),
  amount: DS.attr('number'),
  count: DS.attr('number'),
});
