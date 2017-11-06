$(document).ready(function () {
  $('#datepicker-start').datetimepicker({
    format: 'DD-MM-YYYY HH:mm',
    minDate: new Date(),
    sideBySide: true,
  });

// End date date and time picker
  $('#datepicker-end').datetimepicker({
    format: 'DD-MM-YYYY HH:mm',
    minDate: new Date(),
    sideBySide: true,
    useCurrent: false
  });

  $("#datepicker-start").on("dp.change", function (e) {
    $('#datepicker-end').data("DateTimePicker").minDate(e.date);
  });
  $("#datepicker-end").on("dp.change", function (e) {
    $('#datepicker-start').data("DateTimePicker").maxDate(e.date);
  });
});
