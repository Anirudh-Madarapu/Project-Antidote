extends Node2D

var camera_shake;
var camera_center = Vector2(150, 100)

# Called when the node enters the scene tree for the first time.
func _ready():
	start_lift()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(camera_shake > 0):
		$Camera2D.position = camera_center + Vector2(randf_range(-camera_shake, camera_shake), randf_range(-camera_shake, camera_shake))
		camera_shake -= delta*5
	else:
		camera_shake = 0

func shake_camera(amount):
	camera_shake = amount
	
func start_lift():
	shake_camera(3)
	$LiftTimer.start()


func _on_lift_timer_timeout():
	shake_camera(3)
	$DoorTimer.start()


func _on_door_timer_timeout():
	$elevator_door.open()

func _on_elevator_door_at_door():
	$Label.show()

func _on_elevator_door_leave_door():
	$Label.hide()

