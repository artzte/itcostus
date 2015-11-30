import Ember from 'ember';
import moment from 'moment';

export default Ember.Component.extend({
  tagName: 'span',
  classNames: 'fmt-date',
  fmtDate: Ember.computed('date', function() {
    const date = this.get('date');
    return moment(date).format(this.get('format') || 'MM-DD-YYYY');
  }),
});
