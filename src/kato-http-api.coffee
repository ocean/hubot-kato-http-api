# Description:
#   Enable Hubot to post messages to Kato rooms using the HTTP API, allowing for messages with a coloured background and varying poster name.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   Emit event "kato-http-message" from your script, after setting Kato "All" room URL in environment variables.
#   
#
# Notes:
#   
#
# Author:
#   ocean

module.exports = (robot) ->

  config = secrets:
    katoRoomURL: process.env.HUBOT_KATO_ALL_ROOM_HTTP_POST_URL

  robot.on 'kato-http-post', (kato-http-post) ->
    sendMessage kato-http-post

  sendMessage = (message) ->
    
    data = JSON.stringify({
      text: message.text,
      from: message.from || robot.name,
      color: message.color || 'grey',
      renderer: 'markdown'
    })
    
    robot.http(config.secrets.katoRoomURL)
      .header('Content-Type', 'application/json')
      .post(data) (err, res, body) ->
        if err
          robot.emit 'error', err, res, body
          return
        robot.emit res, body
