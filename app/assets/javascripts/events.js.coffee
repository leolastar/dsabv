# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', -> $('.datepicker').pickadate({
  format: '   mmmm d, yyyy',
  formatSubmit: 'mm/dd/yyyy',
  hiddenPrefix: 'prefix__',
  hiddenSuffix: '__suffix',
  min: true
});

$(document).on 'ready page:load', -> $('.timepicker').pickatime({
  format: ' h:i A',
  formatSubmit: 'H:i',
  hiddenPrefix: 'prefix__',
  hiddenSuffix: '__suffix',
  min: [8, 0],
  max: [18,0]
});