# constants
KEY_TOPIC = "topic"
GREETING_MSGS = ["こにわ~♪  こんな日はコーラを飲みたいですね♪", "こにわ~♪  まったりしていってくださいね♪"]
NO_TOPIC_MSG = "何やってるんだろー？ おひるねさんに聞いて、 「@ohirun_bot topic 配信内容」 で教えて！"
GET_TOPIC_MSG = (topic) -> "今日は、「#{topic}」をやってるよ〜♪ まったりみていってくださいね♪"
SET_TOPIC_MSG = (topic) -> "今日は、「#{topic}」をやってるんですね！ 教えてくれてありがとう♪"
GET_TWEET_ERR_MSG = "おひるねさんのツイートが取得出来ないみたい＞＜"

# utility methods 
shuffle_array = (array) -> 
  shuffle = () -> Math.random() - 0.5
  array.sort(shuffle)

# Twitter client
Twitter = require('twitter')
client = new Twitter {
  consumer_key: 'CJDCqrk0k1CZUYwYoXaXg11Od',
  consumer_secret: 'dN45msTM8AyUDw7c0WB4iDLBpHulQZFA7qlDtOn5KFVHi8napL',
  access_token_key: '749223952652734464-8xVPAj2gsGB2BL04T1K20QlRZYrM92L',
  access_token_secret: '8aQMHFpuciRawopYszc46PjwMWnmgJVNsS2vkW3cm1zmS'
}
params = {screen_name: 'ohirune'}
# Say schedule function
say_schedule = (res) ->
  client.get('statuses/user_timeline', params, ((error,  tweets,  response) ->
    schedule_tweets = tweets.filter (tweet) -> tweet.text.match(/#schedule|#スケジュール/) != null
    if !error && schedule_tweets.length > 0
      res.send schedule_tweets[0].text
    else
      res.send GET_TWEET_ERR_MSG
  ).bind(this))

# bot process
module.exports = (robot) ->
  # Greeting
  robot.respond /こにわ/ig, (res) ->
    res.reply shuffle_array(GREETING_MSGS)[0]
  # Get topic
  robot.respond /topic|トピック$/, (res) ->
    topic = robot.brain.get KEY_TOPIC
    msg = if topic == null then NO_TOPIC_MSG else GET_TOPIC_MSG(topic)
    res.send msg
  # Set topic
  robot.respond /topic|トピック[ 　](.*)/, (res) ->
    topic = res.match[1]
    robot.brain.set KEY_TOPIC, topic
    res.send SET_TOPIC_MSG(topic)
  # Get schedule
  robot.respond /schedule|スケジュール$/, (res) ->
    say_schedule(res)

