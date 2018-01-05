import 'babel-polyfill';
import Vue from 'vue/dist/vue.js';
import env from '../lib/Environments.js';

var app = new Vue({
    el: '#main',
    data: {
        name: 'World',
        val:  0
    },
    computed: {

    },
    methods: {
        async getVal() {
            var response = await fetch(`${env.apiUrl}/api/test`);
            var json = await response.json();
            this.val += json.val;
        }
    },
    watch: {

    },
    created() {

    },
    beforeDestroy() {

    }
});
