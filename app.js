const http = require('http');
const express = require('express');
const path = require('path');
const fs = require('fs');

const hostname = '0.0.0.0';
const port = 8481; // Use the PORT environment variable, or 43881 if PORT is not set
const app = express();

app.use(express.json());
app.use(express.static(__dirname + '/public'));
app.use('/', function(req,res) {
    res.sendFile(path.join(__dirname+'/dkroell/index.html'));
});

const server = http.createServer(app)
server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});
