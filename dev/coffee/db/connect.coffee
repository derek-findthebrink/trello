console.log('trello file init')

request = require("request")
fs = require("fs")

fsReadOpts = {
	encoding: "utf8"
}

applicationName = "brink-trello"

readKey = (cb)->
	fs.readFile("./.cred", fsReadOpts, (err, data)->
		if err
			throw err
		json = JSON.parse(data)
		key = json.key
		cb(key)
		)

aRequest = (key)->
	url = "https://api.trello.com/1/board/4d5ea62fd76aa1136000000c"
	urlWKey = url + "?key=" + key
	# console.log(urlWKey)
	request(urlWKey, (err, response, body)->
		if err
			throw err
		console.log(body)
		)

getToken = (key)->
	url = "https://trello.com/1/authorize"
	opts = {
		qs:
			callback_method: "postMessage"
			scope: "read"
			expiration: "1hour"
			name: applicationName
			key: key
	}
	request.get(url, opts, (err, response, body)->
		if err
			throw err
		console.log(body)
		)

# download the today list from the kanban board


download = ()->
	# console.log("download ran!")
	readKey(getToken)

module.exports = exports = {
	download: download
}