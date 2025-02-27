extends Control


func _on_back_pressed():
	print("Back (Controls) pressed")
	get_tree().change_scene_to_file("res://options_menu.tscn")
