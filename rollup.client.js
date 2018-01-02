import babel from 'rollup-plugin-babel';
import uglify from 'rollup-plugin-uglify';
import commonjs from 'rollup-plugin-commonjs';
import resolve from 'rollup-plugin-node-resolve';
import replace from 'rollup-plugin-replace';
import alias from 'rollup-plugin-alias';

export default {
    plugins: [
        alias({
            'vue': 'node_modules/vue/dist/vue.esm.js'
        }),
        replace({
            'process.env.NODE_ENV': JSON.stringify('development'),
            'process.env.VUE_ENV': JSON.stringify('browser')
        }),
        babel({
            exclude: 'node_modules/**'
        }),
        uglify(),
        resolve(),
        commonjs()
    ]
};
