// Dependencies
const express = require("express"),
  si = require( "systeminformation"),
  gpu_utils = require("./hw_info.js"),
  parseString = require("xml2js").parseString;

// REST app base
const app = express();

// Disable CORS
app.use(function (req, res, next) {
    // TODO Parametrized Central Motitor Server's address to allow CORS request
    res.setHeader('Access-Control-Allow-Origin', "*");
    res.setHeader('Access-Control-Allow-Methods', 'GET');
    res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');
    res.setHeader('Access-Control-Allow-Credentials', true);
    next();
});

app.get( "/get_online", function( req, res) {
  res.end("true");
});

app.get( "/get_hostinfo", function( req, res) {
  si.osInfo().then( function( data) {
    // TODO: Filter useless info
    res.end( JSON.stringify( data));
  }).catch( function( error) {
    console.log( error);
    res.send(500);
  });
});

app.get( "/get_meminfo", function( req, res) {
  // TODO: Filter useless info
  si.mem().then( data => {
    res.end( JSON.stringify( data));
  }).catch( error => {
    console.log( error);
    res.send(500);
  });
});

app.get( "/get_cpuinfo", function( req, res) {
  // TODO: Filter useless info
  si.cpu().then( data => {
    res.end( JSON.stringify( data));
  }).catch( error => {
    console.log( error);
    res.send(500);
  });
});

app.get( "/get_gpuinfo", function( req, res) {
  // TODO: Filter useless info
  gpu_utils.get_gpu_usage().then( data => {
    parseString( data,  function( error, result) {
      if (error) {
        res.end(500);
      } else {
        // console.log( result);
        res.end( JSON.stringify( result));
      }
    });
    // res.end( JSON.stringify( data));
  }).catch( error => {
    console.log( error);
    res.send(500);
  });
});

app.get( "/get_load", function( req, res) {
  // TODO: Filter useless info
  si.currentLoad().then( data => {
    // console.log( data);
    res.end( JSON.stringify( data));
  }).catch( error => {
    console.log( error);
    res.send(500);
  });
});

app.get( "/get_fsinfo", function( req, res) {
  // TODO: Filter useless info
  si.fsSize().then( data => {
    // console.log( data);
    res.end( JSON.stringify( data));
  }).catch( error => {
    console.log( error);
    res.send(500);
  });
});

// Add port parametrization at app launch
var port = 9701;
const server = app.listen( port, "0.0.0.0", function() {
  console.log( "Server status running ...");
});
