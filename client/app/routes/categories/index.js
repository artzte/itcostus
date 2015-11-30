import Ember from 'ember';

export default Ember.Route.extend({
  redirect: function(categories) {
    const unassigned = categories.findBy('usage', 'unassigned');
    this.transitionTo('category', unassigned);
  }
});
