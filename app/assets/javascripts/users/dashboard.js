$(document).ready(function() {
  $('#datepicker-start-new-event').datetimepicker({
    format: 'DD-MM-YYYY HH:mm',
    minDate: new Date(),
    sideBySide: true,
  });

// End date date and time picker
  $('#datepicker-end-new-event').datetimepicker({
    format: 'DD-MM-YYYY HH:mm',
    minDate: new Date(),
    sideBySide: true,
    useCurrent: false
  });

  $("#datepicker-start-new-event").on("dp.change", function(e) {
    $('#datepicker-end-new-event').data("DateTimePicker").minDate(e.date);
  });
  $("#datepicker-end-new-event").on("dp.change", function(e) {
    $('#datepicker-start-new-event').data("DateTimePicker").maxDate(e.date);
  });
});
