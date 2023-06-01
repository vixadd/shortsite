const http = require('http');
const express = require('express');
const path = require('path');

const hostname = '0.0.0.0';
const port = process.env.PORT || 43881; // Use the PORT environment variable, or 43881 if PORT is not set
const app = express();

app.use(express.json());
app.use(express.static(__dirname + '/public'));
app.use('/', function(req,res) {
    res.sendFile(path.join(__dirname+'/dkroell/index.html'));
});

app.use('/index.css', function(req,res) {
    res.send("ok")
});

const server = http.createServer(app)
server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});
