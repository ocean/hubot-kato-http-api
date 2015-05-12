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
#   Emit event "kato-http-message" from your script, after setting room name-id matches in Hubot's brain with
#   
#
# Notes:
#   
#
# Author:
#   ocean

module.exports = (robot) ->
  robot.on 'kato-http-post', (kato-http-post) ->
    sendMessage kato-http-post
  
  robot.brain.data.kato-http-api.rooms or= {}
  
  sendMessage = (message) ->
    
    data = JSON.stringify({
      room: message.room || 'all',
      text: message.text,
      from: message.from || robot.name,
      color: message.color || 'grey',
      renderer: 'markdown'
    })
    
    roomURL = robot.brain.data.kato-http-api.rooms[data.room]
    
    robot.http(roomURL)
      .header('Content-Type', 'application/json')
      .post(data) (err, res, body) ->
        if err
          robot.emit 'error', err, res, body
          return
        robot.emit res, body