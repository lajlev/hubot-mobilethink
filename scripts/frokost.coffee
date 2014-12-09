# A simple json request to get todays lunch menu from frokost.dk through kimono.
#
# lunch - returns lunch menu details if it exists
#

provider = "MuMs"

positiveWords = [
  "an appealing",
  "a beautiful",
  "a creamy",
  "an exceptional",
  "a fab",
  "an incredible",
  "a mouthwatering",
  "an outstanding",
  "a slick",
  "a terrific",
  "a timeless",
  "a spectacular",
  "an absorbing",
  "a brilliant",
  "a delicious",
  "a juicy"
]

intro = [
  "Today #{provider} is serving us",
  "It's gonna be wild. Today #{provider} is serving us",
  "Jackpot. #{provider} is presenting us",
  "#{provider} has created",
  "Today #{provider} is serving us",
  "Today #{provider} is serving us",
]
randomIntroString = Math.floor(Math.random() * intro.length)
randomPositiveWordString = Math.floor(Math.random() * positiveWords.length)

module.exports = (robot) ->
  robot.respond /lunch|todays lunch|lunch today|lunch menu/i, (msg) ->
    gemname = escape(msg.match[1])
    msg.http("https://www.kimonolabs.com/api/9adlhc7g?apikey=c8f9ab2a3136ece150fbb950c58ab214")
      .get() (err, res, body) ->
        try
          json = JSON.parse(body)
          msg.send msg.random intro " #{positiveWords[randomPositiveWordString]} #{json.results.collection1[0].menu}\n
Side dishes: #{json.results.collection1[1].menu} · #{json.results.collection1[2].menu} · #{json.results.collection1[3].menu} · #{json.results.collection1[4].menu}"
        catch error
          msg.send "Lunch menu couldn't be found"
