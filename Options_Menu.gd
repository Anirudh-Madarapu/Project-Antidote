extends Control



func _on_controls_pressed():
	print("Controls pressed")



func _on_music_sfx_pressed():
	print("Music/SFX pressed")



func _on_back_pressed():
	print("Back pressed")
	get_tree().change_scene_to_file("res://start_menu_.tscn")
