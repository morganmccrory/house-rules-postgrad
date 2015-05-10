$(document).ready(function() {

  $('#calendar').fullCalendar({
    header: {
      left: 'today prev,next title',
      right: 'agendaDay,agendaWeek,month'
    },

    eventSources: [{
      url: '/houses/1/events/source',
    }]
  });
});
