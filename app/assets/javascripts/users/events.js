// $(document).ready(function () {
//   var start = $('#event_start_time').attr('data-time');
//   var end = $('#event_end_time').attr('data-time');

//   $('#datepicker-start-edit').datetimepicker({
//     format: 'DD-MM-YYYY HH:mm',
//     minDate: new Date(),
//     sideBySide: true,
//     date: moment(start).add(-7, 'hours')
//   });

// // End date date and time picker
//   $('#datepicker-end-edit').datetimepicker({
//     format: 'DD-MM-YYYY HH:mm',
//     minDate: new Date(),
//     sideBySide: true,
//     useCurrent: false,
//     date: moment(end).add(-7, 'hours')
//   });

//   $("#datepicker-start-edit").on("dp.change", function (e) {
//     $('#datepicker-end-edit').data("DateTimePicker").minDate(e.date);
//   });
//   $("#datepicker-end-edit").on("dp.change", function (e) {
//     $('#datepicker-start-edit').data("DateTimePicker").maxDate(e.date);
//   });
// });

// NEW CODE

// $(document).ready(function () {
//   var start = $('#event_start_time').text();
//   var end = $('#event_end_time').text();

//   $('#datepicker-start-edit').datetimepicker({
//     format: 'DD-MM-YYYY HH:mm',
//     minDate: new Date(),
//     sideBySide: true,
//   });

// // End date date and time picker
//   $('#datepicker-end-edit').datetimepicker({
//     format: 'DD-MM-YYYY HH:mm',
//     minDate: new Date(),
//     sideBySide: true,
//     useCurrent: false,
//   });

//   $("#datepicker-start-edit").on("dp.change", function (e) {
//     $('#datepicker-end-edit').data("DateTimePicker").minDate(e.date);
//   });
//   $("#datepicker-end-edit").on("dp.change", function (e) {
//     $('#datepicker-start-edit').data("DateTimePicker").maxDate(e.date);
//   });

//   $('#datepicker-start-edit').val(start);
//   $('#datepicker-end-edit').val(end);
// });
