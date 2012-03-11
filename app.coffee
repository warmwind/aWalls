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
  res.render 'story/new', layout: false, story: new Story, title: 'Create a new story card', button: 'Create', action: '/story/create'

app.get '/story/edit/:id', (req, res) ->
  Story.find req.params.id, (doc) ->
    res.render 'story/new', layout: false, story: doc, title: 'Edit story', button: 'Update', action: "/story/update/#{req.params.id}"
  
app.post '/story/update/:id', (req, res) ->
  Story.update req.param.id, req,  ->
    res.redirect '/'

app.post '/story/create', (req, res) ->
  story = new Story (req.param 'storyNo'), (req.param 'title'), (req.param 'owner'), (req.param 'description')
  story.create ->
    res.redirect '/'

app.get '/story/delete/:id', (req, res) ->
  Story.delete req.params.id, ->
    res.redirect '/' 

app.listen port, host 

console.log('Server running at ' + host + ":" + port);
