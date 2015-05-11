$(document).ready(function() {

  var houseID = window.location.href

  var getSegment = function (url, index) {
   return url.replace(/^https?:\/\//, '').split('/')[index];
  }

  $('#calendar').fullCalendar({
    header: {
      left: 'today prev,next title',
      right: 'agendaDay,agendaWeek,month'
    },

    eventSources: [{
      url: '/houses/'+getSegment(houseID, 2)+'/events/source',
    }]
  });
});
