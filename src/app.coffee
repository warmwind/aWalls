express = require('express')
app = express.createServer()
app.use(express.bodyParser())
db = require('./db')
Story = require('./models/story').Story
mongoose = require('mongoose')
mongoose.connect db.url


host = process.env.VCAP_APP_HOST || '127.0.0.1'
port = process.env.VCAP_APP_PORT || 1337

app.set 'view engine', 'coffee'
app.register '.coffee', require('coffeekup').adapters.express


app.get '/', (req, res) ->
  Story.findAll (docs) ->
    res.send docs
  
app.get '/story/new', (req, res) ->
  res.render 'story/new', {layout: false}

app.post '/story/create', (req, res) ->
  story = new Story (req.param 'storyNo'), (req.param 'title'), (req.param 'owner'), (req.param 'description')
  story.create()
  res.redirect '/'

app.listen port, host 

console.log('Server running at ' + host + ":" + port);
