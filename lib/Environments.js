var prod = process.env.NODE_ENV === 'production';

export default {
    apiUrl: prod ? '.' : 'http://localhost:8081'
};
