extends Control


func _on_start_game_pressed():
	print("Start pressed")
	get_tree().change_scene_to_file("res://levels/elevator.tscn")


func _on_options_pressed():
	print("Options pressed")
	get_tree().change_scene_to_file("res://options_menu.tscn")


func _on_credits_pressed():
	print("Credits pressed")


func _on_quit_pressed():
	print("Quit pressed")
	get_tree().quit()
