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
	$Block/CollisionShape2D.set_deferred("disabled", false)

func open():
	$"security door".play()

func _on_security_door_animation_finished():
	$Block/CollisionShape2D.set_deferred("disabled", true)
	print_debug("hi")

