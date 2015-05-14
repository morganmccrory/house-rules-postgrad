$(document).ready(function() {

  var houseID = window.location.href
  var calendar = $('#calendar')
  var viewEvent = $("#view_event")

  var getSegment = function (url, index) {
   return url.replace(/^https?:\/\//, '').split('/')[index];
  }

  $("#dialog").dialog({
    autoOpen: false,
    maxWidth:800,
    width: 800
  });

  viewEvent.dialog({
    autoOpen: false,
    maxWidth:800,
    width: 800
  });

  calendar.fullCalendar({
    header: {
      left: 'today prev,next title',
      right: 'agendaDay,agendaWeek,month'
    },

    eventSources: [{
      url: '/houses/'+getSegment(houseID, 2)+'/events/source',
      backgroundColor: '#fe9800',
      borderColor: '#ffad32',
    }],

    dayClick: function(date, jsEvent, view) {
    $("#dialog").dialog("open");

    $("#event_start_2i").val(date.month()+1);
    $("#event_start_3i").val(date.date());
    $("#event_start_1i").val(date.year());

    $("#event_end_2i").val(date.month()+1);
    $("#event_end_3i").val(date.date());
    $("#event_end_1i").val(date.year());

    if (title) {
        calendar.fullCalendar('renderEvent',
            {
                title: title,
                start: start,
                end: end,
                description: description,
                allDay: allDay,
                overlap: overlap
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
                description: description,
                allDay: allDay,
                overlap: overlap
            }
        );
    }
      calendar.fullCalendar('unselect');
    },

    eventClick: function(calEvent, jsEvent, view) {
      viewEvent.dialog("open");
      viewEvent.html("")
      viewEvent.append("<b>Title:</b> "+calEvent.title+"<br>");
      viewEvent.append("<b>Starts at:</b> "+calEvent.start._d+"<br>");
      viewEvent.append("<b>Ends at:</b> "+calEvent.end._d+"<br>");
      viewEvent.append("<b>Description:</b> "+calEvent.description+"<br>");
      viewEvent.append("<b>All day event?</b> "+calEvent.allDay+"<br>");
      viewEvent.append("<b>Overlap?</b> "+calEvent.overlap+"<br>");
      viewEvent.append("<div class='event-changes'><a href='#'>Edit </a></div><br>");
      viewEvent.append("<div class='event-changes'><a href='#'> Delete</a></div>");
    }

  });
});