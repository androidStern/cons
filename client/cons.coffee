# Use this to startup the http server:
#
#  	node /usr/local/lib/node_modules/http-server/bin/http-server "Users/YOURUSERNAME/cons/Public/"

root = "http://localhost:8080/"
ext = ".wav"
urls = [
	"SD1",
	"SD1",
	"RIM1",
	"Perc8",
	"Perc7",
	"Perc6",
	"Perc5",
	"Perc4",
	"Perc3",
	"Perc2",
	"Perc1",
	"HH3",
	"HH2",
	"HH1",
	"CYM1",
	"CLAP2"
	]

Template.urlList.urls = ()->
	return urls

Template.url.events =
	'click #sample': (e,t)->
		e.preventDefault()
		if window.VST
			currentURL = root + t.data.toString() + ext
			window.VST.log(currentURL)

