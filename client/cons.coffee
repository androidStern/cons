# Use this to startup the http server:
#
#  	node /usr/local/lib/node_modules/http-server/bin/http-server "/Users/andrewstern/Developer/AudioServer/"

Meteor.startup () ->
	Session.setDefault 'sampleIdx', 0
	Session.setDefault 'vstReadyForSounds', false


samples = [ "SD1","RIM1","Perc8","Perc7","Perc6","Perc5","Perc4","Perc3","Perc2","Perc1","HH3","HH2","HH1","CYM1","CLAP2"]
root = "http://localhost:8080/"
ext = ".wav"

makeSoundUrl = (idx)->
	url = root + samples[idx] + ext

LoadSounds = ()->
	idx = Session.get "sampleIdx"
	if idx < samples.length
		url = makeSoundUrl(idx)
		idx += 1
		Session.set 'sampleIdx', idx
		window.VST.log url


window.onVstReadyForSounds = ()->
		Session.set 'vstReadyForSounds', true
		LoadSounds()



Template.urlList.rendered = ()->
	window.VST.log "ready"

Template.urlList.urls = ()->
	return samples

Template.urlList.soundLoaded = ()->
	return Session.get 'sampleIdx'

Template.urlList.vstReady = ()->
	return Session.get 'vstReadyForSounds'

