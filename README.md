# ohirun_bot

# Launch

```
# Twitch (https://www.twitch.tv/ababup1192)
./bin/heroku
# freenode (chat.freenode.net, #abab-room)
./bin/heroku_test
```

## Deploy to Heroku

```
git push heroku master
# Lanunch
heroku ps:scale bot=1
# Stop
heroku ps:scale bot=0
```

## Heroku config (Schedule)

```
heroku config:add HUBOT_HEROKU_WAKEUP_TIME=6:00
heroku config:add HUBOT_HEROKU_SLEEP_TIME=24:00
heroku config:add TZ="Asia/Tokyo"
```
