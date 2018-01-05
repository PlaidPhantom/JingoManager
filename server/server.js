import { install } from 'source-map-support';
import express from 'express';
import env from '../lib/test.js';

console.log(env);

install();

var app = express();

if(process.env.NODE_ENV === 'production') {
    app.use('/', express.static('dist'));
}
else {
    app.use(function(request, response, next) {
        // set header so running on different port in dev doesn't cause CORS issues.
        response.set('Access-Control-Allow-Origin', '*')
        next();
    });
}

app.use(express.json({ strict: false }));

app.get('/api/test', function(request, response) {
    response.send({ val: 1 });
});

var port = process.argv[2] || 8080;

app.listen(port, function() {
    console.log(`Running on port ${port}...`);
});
