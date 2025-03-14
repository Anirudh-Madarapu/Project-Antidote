extends Node

var current_music: String = "" 
@onready var player = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_music(music_file: String): 
	if current_music==music_file: 
		return 
		
	current_music = music_file
	player.stream=load(music_file)
	player.play()

func stop_music(): 
	player.stop()
	current_music = ""
