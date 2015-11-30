import Ember from 'ember';

export default Ember.Route.extend({
  model: function() {
    return this.store.findAll('category');
  },
  //setupController: function(controller, model) {
    //var unassigned;
    //this._super(controller, model);
    //unassigned = controller.get('unassigned');
    //this.controllerFor('category').set('model', unassigned);
    //this.controllerFor('transactions').setProperties({
      //page: 1
    //});
  //},
  renderTemplate: function() {
    this.render('categories');
    //this.render('categories.show', {
      //into: 'categories',
      //controller: this.controllerFor('categories.show')
    //});
    //return this.render('transactions', {
      //into: 'categories.show',
      //outlet: 'transactions',
      //controller: this.controllerFor('transactions')
    //});
  }
});
