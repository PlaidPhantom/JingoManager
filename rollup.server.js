import babel from 'rollup-plugin-babel';
import uglify from 'rollup-plugin-uglify';
import commonjs from 'rollup-plugin-commonjs';

export default {
    plugins: [
        babel({
            exclude: 'node_modules/**'
        }),
        uglify(),
        commonjs()
    ],
    external: ['express', 'body-parser', 'ws', 'source-map-support']
};
r
