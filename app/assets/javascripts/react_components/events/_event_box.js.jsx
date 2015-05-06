var EventBox = React.createClass({
  getInitialState: function () {
    return JSON.parse(this.props.presenter);
  },

  handleEventSubmit: function ( formData, action ) {
    $.ajax({
      data: formData,
      url: action,
      type: "POST",
      dataType: "json",
      success: function ( data ) {
        this.setState({ events: data });
      }.bind(this)
    });
  },

  render: function () {
    return (
      <div className="event-box">
      <div className="row">
        <div className="large-3 columns"><br /></div>
        <div className="large-6 columns">
        <h1>House Events </h1>
        <ol>
        <EventList events={ this.state.events } />
        </ol>
        <EventForm form={ this.state.form } onEventSubmit={ this.handleEventSubmit } />
        </div>
        <div className="large-3 columns"><br /></div>
      </div>

      </div>
    );
  }
});
