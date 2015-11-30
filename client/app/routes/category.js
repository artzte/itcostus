import Ember from 'ember';

export default Ember.Route.extend({
  model: function(params) {
    return this.store.findRecord('category', params.id, {
      reload: true
    })
  },
  renderTemplate: function(model) {
    this.render('category', {
      into: 'categories',
      outlet: 'category'
    });
  }
});
