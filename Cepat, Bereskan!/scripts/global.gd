extends Node

var game:Game
var ui:UI
var sfx_player:AudioStreamPlayer = AudioStreamPlayer.new()

func play_sfx(sfx:AudioStream):
	sfx_player.stream = sfx
	sfx_player.play()
