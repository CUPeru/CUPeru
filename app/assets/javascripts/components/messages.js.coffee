@Messages = React.createClass
  getInitialState: ->
    messages: @props.data
  getDefaultProps: ->
    messages: []
  render: ->
    React.DOM.div
      className: 'messages'
      React.DOM.h2
        className: 'title'
        'Messages'
