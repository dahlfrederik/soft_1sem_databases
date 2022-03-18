const mongoose = require('mongoose')

mongoose
    .connect('mongodb://127.0.0.1:27017/dayOne', { useNewUrlParser: true })
    .catch(e => {
        console.error('Connection error', e.message)
    })

const dbconf = mongoose.connection

module.exports = dbconf