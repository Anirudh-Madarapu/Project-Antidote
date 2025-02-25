extends CanvasLayer
var lev = "2"

# Called when the node enters the scene tree for the first time.


func _on_retry_pressed():
	#get_tree().change_scene_to_file("res://levels/level 1 16x16.tscn")
	if lev == "1":
		get_tree().change_scene_to_file("res://levels/level 1 16x16.tscn")
	elif lev == "2":
		get_tree().change_scene_to_file("res://levels/level_2_16x_16.tscn")
	elif lev == "3":
		get_tree().change_scene_to_file("res://levels/level 3 16x16.tscn")
	pass # Replace with function body.



func _on_quit_pressed():
	pass # Replace with function body.
