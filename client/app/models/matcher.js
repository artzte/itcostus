import DS from 'ember-data';

export default DS.Model.extend({
  category: DS.belongsTo('category'),
  transaction: DS.belongsTo('transaction'),
  words: DS.attr('string'),
});
