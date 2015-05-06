var EventList = React.createClass({

  handleDelete: function(eventId){
    return this.props.del(eventId);
  },

  render: function () {
    var eventNodes = this.props.events.map(function ( event ) {
      return <Event event={ event } key={ event.id } nDelete = {this.handleDelete} />
    });

    return (
      <div className="event-list row">
        { eventNodes }
      </div>
    )
  }
});
