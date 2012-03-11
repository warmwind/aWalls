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


  body 'main-content', ->
    h2 ->
      span @subject
      span -> 
        a href: 'story/new/', -> 'Add New'

    for doc in @mainContent
      div 'card ui-draggable', ->
        table ->
          for key in @keys
            tr ->
              td 'title', ->
                "#{key}:"
              td 'content', ->
                doc[key]
          tr ->
            td ->
            td ->
              p ->
                a href: '/story/edit/' + doc['_id'], -> 'Edit'
              p ->
                a href: '/story/delete/' + doc['_id'], -> 'Remove'
