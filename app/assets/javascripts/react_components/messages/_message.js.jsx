var Message = React.createClass({
  render: function () {
    return (
      <div>
        <h4>{ this.props.message.author }</h4>
        <p>{ this.props.message.content }</p>
      </div>
    )
  }
});

