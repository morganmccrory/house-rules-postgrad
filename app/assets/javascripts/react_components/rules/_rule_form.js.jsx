var RuleForm = React.createClass({
  handleSubmit: function ( event ) {
    event.preventDefault();
    var content = this.refs.content.getDOMNode().value.trim();

    // validate
    if (!content) {
      return false;
    }

    // submit
    var formData = $( this.refs.form.getDOMNode() ).serialize();
    this.props.onRuleSubmit( formData, this.props.form.action );

    // reset form
    this.refs.content.getDOMNode().value = "";
  },
  render: function () {
    return (
      <form ref="form" className="rule-form" action={ this.props.form.action } acceptCharset="UTF-8" method="post" onSubmit={ this.handleSubmit }>
        <fieldset>
          <legend>Create a Rule</legend>
          <p><input type="hidden" name={ this.props.form.csrf_param } value={ this.props.form.csrf_token } /></p>
          <p><textarea ref="content" name="rule[content]" placeholder="What's your rule?" /></p>
          <p><button type="submit">Create Rule</button></p>
        </fieldset>
      </form>
    )
  }
});
