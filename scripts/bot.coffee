KEY_TOPIC = "topic"
NO_TOPIC_MSG = "何やってるんだろー？ おひるねさんに聞いて\n @ohirun_bot topic 配信内容\nで教えて！"
GET_TOPIC_MSG = (topic) -> "今日は、「#{topic}」をやってるよ♪"
SET_TOPIC_MSG = (topic) -> "今日は、「#{topic}」をやってるんだね！教えてくれてありがとう♪"

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

