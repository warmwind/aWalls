if process.env.VCAP_SERVICES
  env = JSON.parse process.env.VCAP_SERVICES
  mongo = env['mongodb-1.8'][0]['credentials']
else
  mongo = {
    "hostname":"localhost",
    "port":27017,
    "username":"",
    "password":"",
    "name":"",
    "db":"db"
  }

mongo.hostname = mongo.hostname or 'localhost'
mongo.port = mongo.port or 27017
mongo.db = mongo.db or 'test'

if mongo.username and mongo.password
  url = "mongodb://#{mongo.username}:#{mongo.password}@#{mongo.hostname}:#{mongo.port}/#{mongo.db}"
else
  url = "mongodb://#{mongo.hostname}:#{mongo.port}/#{mongo.db}"

exports.url = url

