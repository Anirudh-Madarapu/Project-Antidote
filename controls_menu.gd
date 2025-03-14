extends Control

func _ready():
	MusicManager.play_music("res://sound/music/minor-bosses-sux.mp3")

func _on_back_pressed():
	print("Back (Controls) pressed")
	get_tree().change_scene_to_file("res://options_menu.tscn")
