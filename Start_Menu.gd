extends Control



func _on_play_game_pressed():
	pass # Replace with function body.
	#add start scene/level1/intro scene to this button after it is created
#get_tree().change_scene_to_file(scene file here)


func _on_options_pressed():
	get_tree().change_scene_to_file("res://options_menu.tscn")



func _on_credits_pressed():
	pass # Replace with function body.
	#currently does not work; operates as a quit button
	#need to add credits scene so it operates properly

func _on_quit_pressed():
	get_tree().quit()
