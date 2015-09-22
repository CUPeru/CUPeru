  @Message = React.createClass
    render: ->
      React.DOM.tr null,
        React.DOM.td null, @props.message.to
        React.DOM.td null, @props.message.from
        React.DOM.td null, @props.record.created_at
        React.DOM.td null, @props.record.body
