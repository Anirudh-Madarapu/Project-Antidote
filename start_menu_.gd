extends Control

func _ready():
	MusicManager.play_music("res://sound/music/minor-bosses-sux.mp3")

func _on_start_game_pressed():
	print("Start pressed")
	#get_tree().change_scene_to_file("res://levels/elevator.tscn")
	get_tree().change_scene_to_file("res://scenes/level_handler.tscn")


func _on_options_pressed():
	print("Options pressed")
	get_tree().change_scene_to_file("res://options_menu.tscn")


func _on_credits_pressed():
	print("Credits pressed")
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
	


func _on_quit_pressed():
	print("Quit pressed")
	get_tree().quit()
