doctype 5
html ->
  head ->
    meta charset: 'utf-8'

    title @title 
    link rel: 'stylesheet', href: '../stylesheets/style.css' 
    script src: 'http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js'
    script src: 'http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.9/jquery-ui.min.js'
    script src: '../scripts/extras/coffee-script.js'
    script src: '../scripts/draggable.coffee', type: 'text/coffeescript'


  body ->
    h2 @subject
    table 'ui-draggable', ->
      for column in @columns
        th -> column
      th -> 
        a href: 'story/new/', -> 'Add New'
      for doc in @mainContent
        tr ->
          for key in @keys
            td -> doc[key]
          td ->
            a href: '/story/delete/' + doc['_id'], -> 'Remove'

    for doc in @mainContent
      div '.ui-draggable.card', ->
        for key in @keys
          p "#{key}: #{doc[key]}"
        a href: '/story/delete/' + doc['_id'], -> 'Remove'
