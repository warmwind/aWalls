doctype 5 
html lang: 'en', ->
  head ->
    meta charset: 'utf-8'
    title 'aWalls'
    meta name: 'description', content: ''
    meta name: 'author', content: ''

    link href: '../public/stylesheets/bootstrap.css', rel: 'stylesheet'
    link href: '../public/stylesheets/walls.css', rel: 'stylesheet'
    style type: 'text/css', '/* Override some defaults */\n      html, body {\n        background-color: #eee;\n      }\n      body {\n        padding-top: 40px; /* 40px to make the container go all the way to the bottom of the topbar */\n      }\n      .container > footer p {\n        text-align: center; /* center align it with the container */\n      }\n      .container {\n        width: 820px; /* downsize our container to make the content feel a bit tighter and more cohesive. NOTE: this removes two full columns from the grid, meaning you only go to 14 columns and not 16. */\n      }\n\n      /* The white background content wrapper */\n      .container > .content {\n        background-color: #fff;\n        padding: 20px;\n        margin: 0 -20px; /* negative indent the amount of the padding to maintain the grid system */\n        -webkit-border-radius: 0 0 6px 6px;\n           -moz-border-radius: 0 0 6px 6px;\n                border-radius: 0 0 6px 6px;\n        -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.15);\n           -moz-box-shadow: 0 1px 2px rgba(0,0,0,.15);\n                box-shadow: 0 1px 2px rgba(0,0,0,.15);\n      }\n\n      /* Page header tweaks */\n      .page-header {\n        background-color: #f5f5f5;\n        padding: 20px 20px 10px;\n        margin: -20px -20px 20px;\n      }\n\n      /* Give a quick and non-cross-browser friendly divider */\n      .content {\n        margin-left: 0;\n        padding-left: 19px;\n        border-left: 1px solid #eee;\n\t\tposition: relative;\n      }\n\n      .topbar .btn {\n        border: 0;\n      }'

    link rel: 'touch-icon', href: 'images/touch-icon.png'

  body ->
    div '.topbar', ->
      div '.fill', ->
        div '.container', ->
          a '.brand' href: '#', 'aWalls'
          ul '.nav', ->
            li ->
              a href: '#about', 'About'
    div '.container', ->
      div '.content', ->
        div '.page-header', ->
          h1 'Subs-Reporting'
      div '.left', ->
        div '.left-column', ->
          h3 'Kick Off'
        div '.left-column', ->
          h3 'In Dev'
        div '.left-column', ->
          h3 'Dev Done'
        div '.left-column', ->
          h3 'In QA'
        div '.left-column', ->
          h3 'BAT'
      div '.right', ->
        div '.right-column', ->
          h3 'Team In Xi\'an'
    comment '/container'
    footer ->
      p '&copy; Xi\'an 2012'
