extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	MusicManager.play_music("res://sound/music/Ethics.mp3")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://start_menu_.tscn")
