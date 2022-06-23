// Server information and specification for nodejs

const http = require('http');
const express = require('express');
const path = require('path');

const hostname = '0.0.0.0';
const port = 43881;

/*
const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Hello World');
});
*/


const app = express();
app.use(express.json());
app.use(express.static(__dirname + "/"));// default URL for website

app.use('/', function(req,res){
    res.sendFile(path.join(__dirname+'/dkroell/index.html'));
    //__dirname : It will resolve to your project folder.
});

app.use('/font-awesome.css', function(req,res) {
    res.sendFile(path.join(__dirname+'/node_modules/font-awesome/css/font-awesome.min.css'));
});

app.use('/index.css', function(req,res) {
    res.sendFile(path.join(__dirname+'/dkroell/index.css'));
});

const server = http.createServer(app)

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});
