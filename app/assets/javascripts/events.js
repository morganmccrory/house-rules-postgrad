$(document).ready(function() {

  var eventHouseID = window.location.href
  var segment = window.location.href.split("/")
  var calendar = $('#calendar')
  var viewEvent = $("#view_event")
  var editEvent = $(".event-edit-form")

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

  editEvent.dialog({
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
      url: '/houses/'+getSegment(eventHouseID, 2)+'/events/source',
      backgroundColor: '#e58900',
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
      viewEvent.append("<div class='event-edit'><a href='#'>Edit </a></div><br>");
      viewEvent.append("<div class='event-delete'><div id='/houses/"+segment[4]+"/events/"+calEvent.id+"'><a href='#'> Delete</a></div></div>");
    }
  });

    $("#dialog").unbind("click").on("click", "#create-event-button", function(e) {
      e.preventDefault();
      e.stopPropagation();

      var url = $(this).parent().attr("action")

      $.ajax({
        url: url,
        method: 'POST',
        data: $(this).parent().serialize(),
        success: function(theEvent) {
          $("#dialog").dialog("close");

          calendar.fullCalendar( 'renderEvent', {
              id: theEvent.event.id,
              title: theEvent.event.title,
              start: theEvent.event.start,
              end: theEvent.event.end,
              description: theEvent.event.description,
              allDay: theEvent.event.allDay,
              overlap: theEvent.event.overlap,
              backgroundColor: '#e58900',
              borderColor: '#ffad32'
          }, true );
        }
      });
  });

  $("body").unbind("click").on("click", ".event-edit", function(e) {
    e.preventDefault();
    e.stopPropagation();

    var eventID = $(this).parent().find(".event-delete").children().attr("id").split("/")[4]

    viewEvent.dialog("close");
    editEvent.load("/houses/"+segment[4]+"/events/"+eventID+"/edit", function() {
        editEvent.dialog("open");
    });

  });

  editEvent.unbind("click").on("click", "#update-event-button", function(e) {
    e.preventDefault();
    e.stopPropagation();

    var url = $(this).parent().attr("action")
    var eventID = $(this).parent().attr("action").split("/")[4]

    $.ajax({
      url: url,
      method: 'POST',
      data: $(this).parent().serialize(),
      success: function(theEvent) {
        editEvent.dialog("close");
        calendar.fullCalendar( 'removeEvents', [ eventID ] );
        calendar.fullCalendar( 'renderEvent', {
            id: eventID,
            title: theEvent.event.title,
            start: theEvent.event.start,
            end: theEvent.event.end,
            description: theEvent.event.description,
            allDay: theEvent.event.allDay,
            overlap: theEvent.event.overlap,
            backgroundColor: '#e58900',
            borderColor: '#ffad32'
        }, true );
      }
    });
  });

  viewEvent.unbind("click").on("click", ".event-delete", function(e) {
    e.preventDefault();
    e.stopPropagation();

    var url = $(this).children().attr("id")
    var confirmed = confirm("Are you sure?");
    var eventID = $(this).children().attr("id").split("/")[4]

    if(confirmed) {
      $.ajax({
        type: 'DELETE',
        url: url,
        success: function() {
          viewEvent.dialog("close");
          calendar.fullCalendar( 'removeEvents', [ eventID ] );
        }
      });
    };
  });
});