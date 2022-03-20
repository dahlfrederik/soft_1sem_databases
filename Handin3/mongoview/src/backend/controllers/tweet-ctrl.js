const Tweet = require("../models/tweet-model");

const createTweet = (req, res) => {
  const body = req.body;

  if (!body) {
    return res.status(400).json({
      success: false,
      error: "You must provide a tweet",
    });
  }

  const tweet = new Tweet(body);

  if (!tweet) {
    return res.status(400).json({ success: false, error: err });
  }

  tweet
    .save()
    .then(() => {
      return res.status(201).json({
        success: true,
        id: tweet._id,
        message: "Tweet Saved!",
      });
    })
    .catch((error) => {
      return res.status(400).json({
        error,
        message: "Tweet not created!",
      });
    });
};

//TODO limit 10
const getTweets = async (req, res) => {
  await Tweet.find({}, (err, tweets) => {
    if (err) {
      return res.status(400).json({ success: false, error: err });
    }
    if (!tweets.length) {
      return res
        .status(404)
        .json({ success: false, error: `Tweets not found` });
    }
    console.log("Tweets found: ", tweets);
    return res.status(200).json({ success: true, data: tweets });
  }).catch((err) => console.log(err));
};

const getMostRetweeted = async (req, res) => {
  const tweets = await mostRetweeted();
  return res.status(200).json({ data: tweets });
};

async function mostRetweeted() {
  const pipeline = [
    {
      $match: { retweet_count: { $gt: 0 } },
    },
    {
      $group: { _id: "$user.name", retweetcount: { $max: "$retweet_count" } },
    },
    {
      $sort: {
        retweetcount: -1,
      },
    },
    {
      $limit: 10,
    },
  ];

  const aggCursor = await Tweet.aggregate(pipeline);
  let mostRetweets = [];

  aggCursor.forEach((retweet) => {
    mostRetweets.push(retweet);
  });
  return mostRetweets;
}

module.exports = {
  createTweet,
  getTweets,
  getMostRetweeted,
};
