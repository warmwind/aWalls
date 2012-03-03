doctype 5
html ->
  head ->
    meta charset: 'utf-8'

    title "aWalls" 
    
    script src: 'http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js'

  body ->
    h1 'Create a new story card'

    form action: '/story/create', method: 'post', ->
      div class: 'field', ->
        label for: 'storyNo', -> 'Story No.: '
        input id: 'storyNo', name: 'storyNo'
    
      div class: 'field', ->
        label for: 'title', -> 'Title: '
        input id: 'title', name: 'title'
    
      div class: 'field', ->
        label for: 'owner', -> 'Owner: '
        input id: 'owner', name: 'owner'
    
      div class: 'field', ->
        label for: 'description', -> 'Description: '
        textarea id: 'description', name: 'description'

        input type:'submit', name: 'Create'
