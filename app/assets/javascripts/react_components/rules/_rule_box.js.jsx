var RuleBox = React.createClass({
  getInitialState: function () {
    return JSON.parse(this.props.presenter);
  },

  handleRuleSubmit: function ( formData, action ) {
    $.ajax({
      data: formData,
      url: action,
      type: "POST",
      dataType: "json",
      success: function ( data ) {
        this.setState({ rules: data });
      }.bind(this)
    });
  },

  render: function () {
    return (
      <div className="rule-box">
      <div className="row">
        <div className="large-3 columns"><br /></div>
        <div className="large-6 columns">
        <h1>House Rules </h1>
        <RuleList rules={ this.state.rules } />
        <RuleForm form={ this.state.form } onRuleSubmit={ this.handleRuleSubmit } />
        </div>
        <div className="large-3 columns"><br /></div>
      </div>

      </div>
    );
  }
});
