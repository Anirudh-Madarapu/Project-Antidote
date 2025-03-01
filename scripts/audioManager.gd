extends Node

var music_on: bool = true
var sfx_on: bool = true 

const MUSIC_BUS = "Music"
const SFX_BUS = "SFX"

# Called when the node enters the scene tree for the first time.
func _ready():
	set_music(music_on)
	set_sfx(sfx_on)


func set_music(state: bool): 
	music_on=state
	AudioServer.set_bus_mute(AudioServer.get_bus_index(MUSIC_BUS), not music_on)

func set_sfx(state: bool): 
	sfx_on=state
	AudioServer.set_bus_mute(AudioServer.get_bus_index(SFX_BUS), not sfx_on)
