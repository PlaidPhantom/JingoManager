import { install } from 'source-map-support';
import express from 'express';
import bodyParser from 'body-parser';

install();

var app = express();

app.use('/styles', express.static('styles'));
app.use('/scripts', express.static('scripts'));
//app.use('/nm', express.static('node_modules'))

app.use(bodyParser.json({ strict: false }));

app.get('/', function(request, response) {
    response.sendFile('index.html', { root: 'views/' });
});

var port = process.argv[2] || 8080;

app.listen(port, function() {
    console.log(`Running on port ${port}...`);
});
