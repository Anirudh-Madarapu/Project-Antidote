extends Node2D

@export var parts : Array[Node]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if(parts.any(is_near_center($CenterPoint.global_position, 50))):
	#	hide()
	pass

func _on_button_button_down():
	start()
		
func start():
	for i in parts:
		i.start($CenterPoint.global_position)
	

func is_near_center(center, distance):
	return global_position.distance_to(center) < distance
