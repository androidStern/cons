urls = [
	"http://localhost:8080/SD1.wav",
	"http://localhost:8080/SD1.wav",
	"http://localhost:8080/RIM1.wav",
	"http://localhost:8080/Perc8.wav",
	"http://localhost:8080/Perc7.wav",
	"http://localhost:8080/Perc6.wav",
	"http://localhost:8080/Perc5.wav",
	"http://localhost:8080/Perc4.wav",
	"http://localhost:8080/Perc3.wav",
	"http://localhost:8080/Perc2.wav",
	"http://localhost:8080/Perc1.wav",
	"http://localhost:8080/HH3.wav",
	"http://localhost:8080/HH2.wav",
	"http://localhost:8080/HH1.wav",
	"http://localhost:8080/CYM1.wav",
	"http://localhost:8080/CLAP2.wav"
	]

urlString = urls.join(" ")

Template.urlList.urls = ()->
	return urls

Template.url.events =
	'click #sample': (e,t)->
		e.preventDefault()

		console.log t.data.toString()
		if window.VST
			window.VST.log(t.data.toString())

