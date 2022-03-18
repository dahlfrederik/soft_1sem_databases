const mongoose = require('mongoose')
const Schema = mongoose.Schema

const Tweet = new Schema(
    {
        text: { type: String, required: true },
        user: { type: Object, required: true},
        retweet_count: {type: Object, required: true}
    },
    { timestamps: true },
)

module.exports = mongoose.model('tweets', Tweet)