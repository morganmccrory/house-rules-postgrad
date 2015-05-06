var Event = React.createClass({
  handleClick: function(e){
    e.preventDefault();
    var eventId = this.props.event.id;
    return this.props.onDelete(eventId);
  },
  render: function () {
    return (
      <div>
        <li><p>{ this.props.event.name }<br/>{ this.props.event.description }<br/>{ this.props.event.date }
        <br/>
        <a onClick={this.handleClick}> &times; </a>
        </p></li>
      </div>
    )
  }
});
