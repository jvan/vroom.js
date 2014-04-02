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
  , _ = require('underscore');

app.use(express.static(__dirname + '/public'));
app.set('view engine', 'jade');
app.set('views', __dirname + '/views');

var vroom_app = process.argv[2];
var app_source = 'public/apps/' + vroom_app;

var defaults = {
   title:  'vroom.js',
   width:  '800',
   height: '600'
};

app.get('/', function(req, res) {
   options = { source: '/apps/' + vroom_app };
   _.extend(options, defaults);
   res.render('demo', options);
});

app.get('/examples/:name', function(req, res) {
   options = { source: '/examples/' + req.params.name + '.js'}
   _.extend(options, defaults);
   res.render('demo', options);
});

io.sockets.on('connection', function(socket) {
   console.log('   [vroom-server] watching file ' + app_source);

   watch(app_source, function() {
      socket.emit('update', { filename: app_source });
   });

});

var port = process.env.PORT || 3000;
server.listen(port);

console.log('   [vroom-server] running on port 3000')
console.log('   [vroom-server] open http://localhost:3000 to view your app')
