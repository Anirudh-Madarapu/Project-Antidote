extends Node2D


signal at_door
signal leave_door
signal entered_door

# Called when the node enters the scene tree for the first time.
func _ready():
	close()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func close():
	$InteractionArea/CollisionShape2D.set_deferred("disabled", true)

func open():
	$"security door".play()

func _on_security_door_animation_finished():
	$InteractionArea/CollisionShape2D.set_deferred("disabled", false)
	print_debug("hi")
	
func _on_interaction_area_area_entered(area):
	at_door.emit()

func _on_interaction_area_area_exited(area):
	leave_door.emit()

func _on_interaction_area_interaction_initiated():
	entered_door.emit()
