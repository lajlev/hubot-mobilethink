# A simple json request to get todays lunch menu from frokost.dk through kimono.
#
# lunch - returns lunch menu details if it exists
#

module.exports = (robot) ->
  robot.respond /lunch/i, (msg) ->
    gemname = escape(msg.match[1])
    msg.http("https://www.kimonolabs.com/api/9adlhc7g?apikey=c8f9ab2a3136ece150fbb950c58ab214")
      .get() (err, res, body) ->
        try
          json = JSON.parse(body)
          msg.send "~ Todays Menu ~\n
          \n
Hot dish: #{json.results.collection1[0].menu}\n
Salat: #{json.results.collection1[1].menu}\n
Green salat: #{json.results.collection1[2].menu}\n
Cold cuts: #{json.results.collection1[3].menu}\n
Cheese: #{json.results.collection1[4].menu}\n
\n
Source: http://e.frokost.dk/menu/6OKBMXsAjS"
        catch error
          msg.send "Lunch menu couldn't be found"
