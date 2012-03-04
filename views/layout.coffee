doctype 5
html ->
  head ->
    meta charset: 'utf-8'

    title @title 
    
    script src: 'http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js'

  body ->
    table ->
      for column in @columns
        th -> column
      for doc in @mainContent
        tr ->
          for key in @keys
            td -> doc[key]
          td ->
            a href: '/story/delete/' + doc['_id'], -> 'remove'
