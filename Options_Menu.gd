extends Control

func _ready():
	MusicManager.play_music("res://sound/music/minor-bosses-sux.mp3")

func _on_controls_pressed():
	print("Controls pressed")
	get_tree().change_scene_to_file("res://controls_menu.tscn")


func _on_music_sfx_pressed():
	print("Music/SFX pressed")
	get_tree().change_scene_to_file("res://scenes/music sfx control.tscn")



func _on_back_pressed():
	print("Back (Options) pressed")
	get_tree().change_scene_to_file("res://start_menu_.tscn")
