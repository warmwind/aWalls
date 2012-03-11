doctype 5
html ->
  head ->
    meta charset: 'utf-8'

    title "aWalls" 
    
    script src: 'http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js'

  body ->
    h1 @title
    form action: @action, method: 'post', ->
      div class: 'field', ->
        label for: 'storyNo', -> 'Story No.: '
        if @story.storyNo == undefined
          input id: 'storyNo', name: 'storyNo'
        else
          input id: 'storyNo', name: 'storyNo', value: @story.storyNo, readonly: true
      div class: 'field', ->
        label for: 'title', -> 'Title: '
        input id: 'title', name: 'title', value: @story.title
    
      div class: 'field', ->
        label for: 'owner', -> 'Owner: '
        input id: 'owner', name: 'owner', value: @story.owner
    
      div class: 'field', ->
        label for: 'description', -> 'Description: '
        textarea id: 'description', name: 'description', ->
          @story.description

        input type: 'submit', name: @button 
