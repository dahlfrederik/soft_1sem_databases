const express = require("express");

const TwitterCtrl = require("../controllers/tweet-ctrl");

const router = express.Router();

router.post("/tweet", TwitterCtrl.createTweet);
//router.get("/tweets", TwitterCtrl.getTweets);
router.get("/tweets", TwitterCtrl.getTopTenHastags);
router.get("/tweetsmost", TwitterCtrl.getMostRetweeted);

module.exports = router;
