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

katoRoomURL = process.env.HUBOT_KATO_ALL_URL

sendMessage = (robot, katoHttpPost) ->
  data = JSON.stringify(
    text: katoHttpPost.text,
    from: katoHttpPost.from or robot.name,
    color: katoHttpPost.color or 'grey',
    renderer: 'markdown'
  )
  #console.log data
  robot.logger.info data

  robot.http(katoRoomURL)
    .headers("Content-Type": "application/json", "Accept": "application/json")
    .post(data) (err, res, body) ->
      #console.log res, body
      if err
        #robot.emit 'error', err, res, body
        console.log 'HTTP error:'
        console.log err, res, body
        return
      #robot.emit res, body

module.exports = (robot) ->

  robot.on 'kato-http-post', (katoHttpPost) ->
    #console.log 'Event detected:'
    #console.log katoHttpPost
    #robot.logger.info "Event detected: #{katoHttpPost}"
    sendMessage robot, katoHttpPost
