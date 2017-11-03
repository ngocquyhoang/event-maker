$(document).ready(function () {
  $('#datepicker-start').datetimepicker({
    format: 'DD-MM-YYYY',
    minDate: new Date()
  });

// End date date and time picker
  $('#datepicker-end').datetimepicker({
    format: 'DD-MM-YYYY',
    minDate: new Date(),
    useCurrent: false
  });

  $("#datepicker-start").on("dp.change", function (e) {
    $('#datepicker-end').data("DateTimePicker").minDate(e.date);
  });
  $("#datepicker-end").on("dp.change", function (e) {
    $('#datepicker-start').data("DateTimePicker").maxDate(e.date);
  });
});
