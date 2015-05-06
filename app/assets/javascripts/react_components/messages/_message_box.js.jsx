var MessageBox = React.createClass({
  getInitialState: function () {
    return JSON.parse(this.props.presenter);
  },

  handleMessageSubmit: function ( formData, action ) {
    $.ajax({
      data: formData,
      url: action,
      type: "POST",
      dataType: "json",
      success: function ( data ) {
        this.setState({ messages: data });
      }.bind(this)
    });
  },

  render: function () {
    return (
      <div className="message-box">
        <img src={ this.props.imgSrc } alt={ this.props.imgAlt } />
        <MessageList messages={ this.state.messages } />
        <hr />
        <h2>post a message</h2>
        <MessageForm form={ this.state.form } onMessageSubmit={ this.handleMessageSubmit } />
      </div>
    );
  }
});
