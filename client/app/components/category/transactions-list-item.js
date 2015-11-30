import Ember from 'ember';

export default Ember.Component.extend({
  tagName: 'tr',
  actions: {
    setEdit: function() {
      this.toggleProperty('isEditing');
    },
    cancelEdit: function() {
      this.get('transaction').rollbackAttributes();
      this.send('setEdit');
    },
    save: function() {
      const transaction = this.get('transaction');
      const promise = transaction.save();
      this.set('isSaving', true);
      promise.then(function() {
        window.alert('done');
      }).finally(function() {
        this.set('isSaving', false);
      }.bind(this));
      console.log('do save', this.get('transaction'));
    }
  }
});
