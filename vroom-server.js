#!/usr/bin/env node

// vroom.js application server.
//
// This program starts a web server on port 3000 for running
// vroom.js applications. 
//
// Applications are located in the public/apps directory and are 
// run by passing the base filename (without directories) as the 
// first argument to this program. For example, to run the 
// application located at public/apps/my-demo.js you would run 
// the following command.
//
//    vroom-server.js my-demo.js
//
// Then simply open http://localhost:3000 any webgl-capable browser
// to interact with the application.

var express = require('express')
  , app = express()
  , http = require('http')
  , server = http.createServer(app)
  , jade = require('jade')
  , io = require('socket.io').listen(server)
  , watch = require('node-watch')
  , fs = require('fs')
  , _ = require('underscore')
  , settings = require('./config.json');

app.use(express.static(__dirname + '/public'));
app.set('view engine', 'jade');
app.set('views', __dirname + '/views');

var defaults = {
   title:  'vroom.js',
   width:  settings.canvas.width,
   height: settings.canvas.height
};

if (process.argv.length > 2) {

   var vroom_app = process.argv[2];
   var app_source = 'public/' + vroom_app;

   app.get('/', function(req, res) {
      options = { source: '/' + vroom_app };
      _.extend(options, defaults);
      res.render('demo', options);
   });

   io.sockets.on('connection', function(socket) {
      console.log('   [vroom-server] watching file ' + app_source);

      watch(app_source, function() {
         socket.emit('update', { filename: app_source });
      });

   });
}

app.get('/:root/', function(req, res) {
   files = fs.readdirSync('public/' + req.params.root);
   files = _(files).reject(function(x) { return x[0] == '.' });
   options = { root: req.params.root, files: files }
   res.render('demo-list', options);
});

app.get('/:root/:name', function(req, res) {
   path = '/' + req.params.root + '/' + req.params.name + '.js';
   var args = null;
   if (Object.keys(req.query).length !=0 ) {
      args = req.query;
   }
   options = { source: path, query: args }
   _.extend(options, defaults);
   res.render('demo', options);
});


var port = process.env.PORT || 3000;
server.listen(port);

console.log('   [vroom-server] running on port 3000')
if (process.argv.length > 2) {
   console.log('   [vroom-server] go to http://localhost:' + port + ' to view your app')
}
console.log('   [vroom-server] go to http://localhost:' + port + '/examples for example apps')

