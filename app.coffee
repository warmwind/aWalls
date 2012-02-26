app = require('express').createServer();
db = require('./db')

host = process.env.VCAP_APP_HOST || '127.0.0.1'
port = process.env.VCAP_APP_PORT || 1337

app.set 'view engine', 'coffee'
app.register '.coffee', require('coffeekup').adapters.express

app.get '/', (req, res) ->
  db.record_visit req, res

app.get '/history', (req, res) ->
  db.print_visits req, res
  
app.listen port, host 

console.log('Server running at ' + host + ":" + port);
