(function() {
  var Story, app, compile, db, express, host, mongoose, port, stylus;

  express = require('express');

  app = express.createServer();

  app.use(express.bodyParser());

  db = require('./lib/db');

  stylus = require('stylus');

  Story = require('./lib/models/story').Story;

  mongoose = require('mongoose');

  mongoose.connect(db.url);

  compile = function(str, path, fn) {
    return stylus(str).set('filename', path).set('compress', true);
  };

  app.use(stylus.middleware({
    src: "" + __dirname + "/public",
    dest: "" + __dirname + "/public",
    compress: true,
    force: true,
    compile: compile
  }));

  app.configure('development', function() {
    app.use(express.static(__dirname + '/public'));
    return app.use(express.errorHandler({
      dumpExceptions: true,
      showStack: true
    }));
  });

  app.configure('production', function() {
    var oneYear;
    oneYear = 31557600000;
    app.use(express.static(__dirname + '/public', {
      maxAge: oneYear
    }));
    return app.use(express.errorHandler());
  });

  host = process.env.VCAP_APP_HOST || '127.0.0.1';

  port = process.env.VCAP_APP_PORT || 1337;

  app.set('view engine', 'coffee');

  app.register('.coffee', require('coffeekup').adapters.express);

  app.get('/', function(req, res) {
    return Story.findAll(function(docs) {
      return res.render('index', {
        mainContent: docs
      });
    });
  });

  app.get('/story/new', function(req, res) {
    return res.render('story/new', {
      layout: false,
      story: new Story,
      title: 'Create a new story card',
      button: 'Create',
      action: '/story/create'
    });
  });

  app.get('/story/edit/:id', function(req, res) {
    return Story.find(req.params.id, function(doc) {
      return res.render('story/new', {
        layout: false,
        story: doc,
        title: 'Edit story',
        button: 'Update',
        action: "/story/update/" + req.params.id
      });
    });
  });

  app.post('/story/update/:id', function(req, res) {
    return Story.update(req.param.id, req, function() {
      return res.redirect('/');
    });
  });

  app.post('/story/create', function(req, res) {
    var story;
    story = new Story(req.param('storyNo'), req.param('title'), req.param('owner'), req.param('description'));
    return story.create(function() {
      return res.redirect('/');
    });
  });

  app.get('/story/delete/:id', function(req, res) {
    return Story["delete"](req.params.id, function() {
      return res.redirect('/');
    });
  });

  app.listen(port, host);

  console.log('Server running at ' + host + ":" + port);

}).call(this);
