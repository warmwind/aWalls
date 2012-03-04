doctype 5
html ->
  head ->
    meta charset: 'utf-8'

    title @title 
    link rel: 'stylesheet', href: '../stylesheets/style.css' 
    script src: 'http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js'

  body ->
    h2 @subject
    table ->
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
