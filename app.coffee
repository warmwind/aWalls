express = require('express')
app = express.createServer()
app.use(express.bodyParser())
db = require('./lib/db')
stylus = require('stylus')
Story = require('./lib/models/story').Story
mongoose = require('mongoose')
mongoose.connect db.url

compile = (str, path, fn) ->
  stylus(str).set('filename', path).set('compress', true)

app.use(stylus.middleware({
  src: "#{__dirname}/public"
  dest:  "#{__dirname}/public"
  compress: true
  debug: true
  force: true
  compile:compile
}))

app.configure 'development', -> 
    app.use(express.static(__dirname + '/public'))
    app.use(express.errorHandler({ dumpExceptions: true, showStack: true }))


app.configure 'production', ->
  oneYear = 31557600000;
  app.use(express.static(__dirname + '/public', { maxAge: oneYear }))
  app.use(express.errorHandler())

host = process.env.VCAP_APP_HOST || '127.0.0.1'
port = process.env.VCAP_APP_PORT || 1337

app.set 'view engine', 'coffee'
app.register '.coffee', require('coffeekup').adapters.express


app.get '/', (req, res) ->
  Story.findAll (docs) ->
    res.render 'index', mainContent: docs 
  
app.get '/story/new', (req, res) ->
  res.render 'story/new', {layout: false}

app.post '/story/create', (req, res) ->
  story = new Story (req.param 'storyNo'), (req.param 'title'), (req.param 'owner'), (req.param 'description')
  story.create ->
    res.redirect '/'

app.get '/story/delete/:id', (req, res) ->
  Story.delete req.params.id, ->
    res.redirect '/' 

app.listen port, host 

console.log('Server running at ' + host + ":" + port);
