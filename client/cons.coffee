#
# Use this to startup the http server:
#
#  	node /usr/local/lib/node_modules/http-server/bin/http-server "/Users/andrewstern/Developer/AudioServer/"

Meteor.startup () ->
	# Since there is only one page for now, setting this in Session.setDefault is fine, but
	# this should really be reset whenever a user browses to a new page.
	Session.setDefault 'sampleIdx', 0
	Session.setDefault 'vstReadyForSounds', false

# Change this to be whatever samples are in the AudioServer directory.
samples = [ "SD1","RIM1","Perc8","Perc7","Perc6","Perc5","Perc4","Perc3","Perc2","Perc1","HH3","HH2","HH1","CYM1","CLAP2"]

# Change this to be the correct server and port num of the AudioServer directory
root = "http://localhost:8080/"

# The vst only handles .wav files for now so this should remain as is
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

PlaySound = (sound)->
	if console? then console.log sound
	idx = _.indexOf(samples, sound)
	playMsg = "play " + idx
	# temporary hack to trick the vst into sending an update when
	# the user click the same sound twice
	bogus = "play 65"
	window.VST.log(bogus)
	window.VST.log(playMsg)

window.onVstReadyForSounds = ()->
	# This is called by the vst when it has finished loading the previous sound.
	# It is also called once before any sounds have been loaded in
	# response to a call to window.VST.log to signify that the VST is
	# initialized and ready to accept the first sound to load.
	Session.set 'vstReadyForSounds', true
	LoadSounds()

Template.urlList.rendered = ()->
	# This should be called once the page has defined a window.onVstReadyForSounds callback
	# The VST will take "ready" to mean it can start calling onVstReadyForSounds
	window.VST.log "ready"


Template.urlList.helpers
	urls : ->
		return samples
	soundLoaded : ->
		return Session.get 'sampleIdx'
	vstReady : ->
		return Session.get 'vstReadyForSounds'


Template.url.events =
	"click #sample": (e,t)->
		e.preventDefault()
		sound = t.data.toString()
		PlaySound(sound)
