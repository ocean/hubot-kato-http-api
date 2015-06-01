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
    katoRoomURL: process.env.HUBOT_KATO_ALL_URL

  robot.on 'kato-http-post', (katoHttpPost) ->
    console.log 'Event detected:'
    console.log katoHttpPost
    sendMessage katoHttpPost

  sendMessage = (katoHttpPost) ->
    
    data = JSON.stringify(
      text: katoHttpPost.text,
      from: katoHttpPost.from or robot.name,
      color: katoHttpPost.color or 'grey',
      renderer: 'markdown'
    )
    
    robot.http(config.secrets.katoRoomURL)
      .header('Content-Type', 'application/json')
      .post(data) (err, res, body) ->
        console.log res, body
        if err
          #robot.emit 'error', err, res, body
          console.log 'HTTP error:'
          console.log err, res, body
          return
        #robot.emit res, body


