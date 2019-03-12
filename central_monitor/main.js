const fs = require("fs"),
  express = require("express"),
  ping = require( "net-ping");

const app = express();

// Add port parametrization at app launch
var port = 9700;
app.use( "/", express.static("./tmplt/src"));

// app.get( "/", function( req, res) {
//   res.end("Welcome...");
// });

app.get( "/get_servers_paths", function( req, res) {
  fs.readFile( "./servers.json", function( error, data) {
    if( error) {
      console.log( error);
      res.end(500);
    } else {
      res.end( data);
    }
  });
});

// Unused
app.get( "/ping_server", function( req, res) {
  // TODO: Maybe add error handling here ?
  const session = ping.createSession();
  session.pingHost( req.query.host_ip, function( error, target) {
    if( error) {
      res.end("false");
    } else {
      res.end("true");
    }
  });
});


const server = app.listen( port, function() {
  console.log( "Server status running ...");
});
