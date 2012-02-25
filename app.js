(function() {
  var app, host, port;

  app = require('express').createServer();

  host = process.env.VCAP_APP_HOST || '127.0.0.1';

  port = process.env.VCAP_APP_PORT || 1337;

  app.set('view engine', 'coffee');

  app.register('.coffee', require('coffeekup').adapters.express);

  app.get('/', function(req, res) {
    return res.render('index');
  });

  app.listen(port, host);

  console.log('Server running at ' + host + ":" + port);

}).call(this);
