doctype 5
html ->
  head ->
    meta charset: 'utf-8'

    title @title 
    
    script src: 'http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js'

  body ->
    @mainContent
