var EventForm = React.createClass({
  handleSubmit: function ( thing ) {
    thing.preventDefault();
    var name = this.refs.name.getDOMNode().value.trim();
    var description = this.refs.description.getDOMNode().value.trim();
    var date = this.refs.date.getDOMNode().value.trim();

    // validate
    if (!name) {
      return false;
    }
    if (!description) {
      return false;
    }
    if (!date) {
      return false;
    }

    // submit
    var formData = $( this.refs.form.getDOMNode() ).serialize();
    this.props.onEventSubmit( formData, this.props.form.action );

    // reset form
    this.refs.name.getDOMNode().value = "";
    this.refs.description.getDOMNode().value = "";
    this.refs.date.getDOMNode().value = "";
  },
  render: function () {
    return (
      <form ref="form" className="event-form" action={ this.props.form.action } acceptCharset="UTF-8" method="post" onSubmit={ this.handleSubmit }>
        <fieldset>
          <legend>Create an Event</legend>
          <p><input type="hidden" name={ this.props.form.csrf_param } value={ this.props.form.csrf_token } /></p>
          <p><input type="text" ref="name" name="event[name]" placeholder="What's your event name?" /></p>
          <p><textarea ref="description" name="event[description]" placeholder="What's going to happen?" /></p>
          <p><input type="datetime-local" ref="date" name="event[date]" placeholder="What's going to happen?" /></p>
          <button type="submit">Create Event</button>
        </fieldset>
      </form>
    )
  }
});
