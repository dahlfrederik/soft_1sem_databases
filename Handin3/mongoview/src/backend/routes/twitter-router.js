const express = require('express')

const TwitterCtrl = require('../controllers/tweet-ctrl')

const router = express.Router()

router.post('/tweet', TwitterCtrl.createTweet)
router.get('/tweets', TwitterCtrl.getTweets)

module.exports = router