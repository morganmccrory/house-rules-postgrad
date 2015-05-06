var RuleList = React.createClass({
  render: function () {
    var ruleNodes = this.props.rules.map(function ( rule ) {
      return <Rule rule={ rule } key={ rule.id } />
    });

    return (
      <div className="rule-list row">
        { ruleNodes }
      </div>
    )
  }
});
