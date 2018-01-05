import replace from 'rollup-plugin-replace';

export default {
    plugins: [
        replace({
            'process.env.NODE_ENV': JSON.stringify(process.env.BUILD || 'development')
        })
    ],
    external: ['express', 'source-map-support'],
    watch: {
        clearScreen: false
    }
};
