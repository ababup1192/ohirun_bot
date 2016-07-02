KEY_TOPIC = "topic"
NO_TOPIC_MSG = "何やってるんだろー？ おひるねさんに聞いて\n @ohirun_bot topic 配信内容\nで教えて！"
GET_TOPIC_MSG = (topic) -> "今日は、「#{topic}」をやってるよ♪"
SET_TOPIC_MSG = (topic) -> "今日は、「#{topic}」をやってるんだね！教えてくれてありがとう♪"

Twitter = require('twitter')
client = new Twitter {
  consumer_key: 'CJDCqrk0k1CZUYwYoXaXg11Od',
  consumer_secret: 'dN45msTM8AyUDw7c0WB4iDLBpHulQZFA7qlDtOn5KFVHi8napL',
  access_token_key: '749223952652734464-8xVPAj2gsGB2BL04T1K20QlRZYrM92L',
  access_token_secret: '8aQMHFpuciRawopYszc46PjwMWnmgJVNsS2vkW3cm1zmS'
}
params = {screen_name: 'ohirune'}
say_schedule = (res) ->
  client.get('statuses/user_timeline', params, ((error,  tweets,  response) ->
    if !error
      res.send tweets[0].text
    else
      res.send 'おひるねさんのツイートが取得出来ないみたい＞＜'
  ).bind(this))

# bot process
module.exports = (robot) ->
  # Greeting
  robot.respond /こにわ/ig, (res) ->
    res.reply "こにわ~♪ "
  # Get topic
  robot.respond /topic$/, (res) ->
    topic = robot.brain.get KEY_TOPIC
    msg = if topic == null then NO_TOPIC_MSG else GET_TOPIC_MSG(topic)
    res.send msg
  # Set topic
  robot.respond /topic (.*)/, (res) ->
    topic = res.match[1]
    robot.brain.set KEY_TOPIC, topic
    res.send SET_TOPIC_MSG(topic)
  # Get schedule
  robot.respond /schedule$/, (res) ->
    say_schedule(res)

