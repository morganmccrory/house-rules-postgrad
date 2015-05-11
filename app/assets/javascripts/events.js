$(document).ready(function() {

  var houseID = window.location.href
  var calendar = $('#calendar')

  var getSegment = function (url, index) {
   return url.replace(/^https?:\/\//, '').split('/')[index];
  }

  $("#dialog").dialog({
    autoOpen: false
  });

  calendar.fullCalendar({
    header: {
      left: 'today prev,next title',
      right: 'agendaDay,agendaWeek,month'
    },

    eventSources: [{
      url: '/houses/'+getSegment(houseID, 2)+'/events/source',
    }],

    dayClick: function(start, end, allDay) {
    $("#dialog").dialog("open");

    if (title) {
        calendar.fullCalendar('renderEvent',
            {
                title: title,
                start: start,
                end: end,
                allDay: allDay
            },
            true // make the event "stick"
        );
        /**
         * ajax call to store event in DB
         */
        jQuery.post(
            '/houses/'+getSegment(houseID, 2)+'/events/source', // your url
            { // re-use event's data
                title: title,
                start: start,
                end: end,
                allDay: allDay
            }
        );
    }
      calendar.fullCalendar('unselect');
    }

  });
});
