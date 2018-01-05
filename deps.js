var fs = require('fs');
var r = require('rollup');

function listDeps(target) {
    r.rollup({
        input: target,
        external: m => m !== target && /^.*\.js$/.test(m)
    }).then(b => {
        //console.log(b);
        b.imports.forEach(m => {
            fs.access(m, err => {
                if(!err) {
                    console.log(m);
                    listDeps(m);
                }
            })
        });
    }).catch(err => {
        console.log(err);
    });
}

listDeps(process.argv[2]);
