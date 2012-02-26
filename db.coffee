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

generate_mongo_url = (obj) ->
  obj.hostname = obj.hostname or 'localhost'
  obj.port = obj.port or 27017
  obj.db = obj.db or 'test'

  if obj.username and obj.password
    "mongodb://#{obj.username}:#{obj.password}@#{obj.hostname}:#{obj.port}/#{obj.db}"
  else
    "mongodb://#{obj.hostname}:#{obj.port}/#{obj.db}"

mongourl = generate_mongo_url mongo

record_visit = (req, res) ->
  require('mongodb').connect mongourl, (err, conn) ->
    conn.collection 'ips', (err, coll) ->
      object_to_insert = { 'ip': req.connection.remoteAddress, 'ts': new Date() }
      coll.insert object_to_insert, {safe:true}, (err) ->
        res.writeHead 200, {'Content-Type': 'text/plain'}
        res.write JSON.stringify object_to_insert
        res.end '\n'

print_visits = (req, res) ->
  require('mongodb').connect mongourl, (err, conn) ->
    conn.collection 'ips', (err, coll) ->
      coll.find {}, {limit:10, sort:[['_id', 'desc']]}, (err, cursor) ->
        cursor.toArray (err, items) -> 
          res.writeHead 200, {'Content-Type': 'text/plain'}
          for item in items
            res.write (JSON.stringify item) + "\n"
          res.end '\n'


exports.record_visit = record_visit
exports.print_visits = print_visits
