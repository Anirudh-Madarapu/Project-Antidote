extends Node2D

var camera_shake = 0
var camera_center = Vector2(150, 100)

@onready var press_b = $PressB
@onready var floor_number = $FloorNumber
@onready var camera = $Camera2D
@onready var elevator_door = $elevator_door

@export var levels : Array[PackedScene]

var lift_stage = 0
var floor_number_position

signal end_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	reset()
	floor_number_position = floor_number.position
	camera.position = camera_center
	start_lift()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(camera_shake > 0):
		camera.position = camera_center + Vector2(randf_range(-camera_shake, camera_shake), randf_range(-camera_shake, camera_shake))
		camera_shake -= delta*5
	else:
		camera_shake = 0
	
	# Elevator at rest
	if(lift_stage == 0):
		floor_number.position = floor_number_position
		floor_number.modulate.a = 1
	# Start to accelerate up
	elif(lift_stage == 1):
		floor_number.position.y += delta*50
		floor_number.modulate.a -= delta
	# Start to deaccelerate
	elif(lift_stage == 2):
		floor_number.position.y = lerp(floor_number.position.y, 74.0, delta)#(.00001**delta)/200) #delta
		floor_number.modulate.a += delta/2
		print_debug(floor_number.position.y)
		# Bring elevator to a stop
		if(floor_number_position.y - floor_number.position.y < 3):
			shake_camera(3)
			$DoorTimer.start()
			lift_stage = 0
	

func shake_camera(amount):
	camera_shake = amount

#Wait a bit before starting to rise
func start_lift():
	$PreLiftWait.start()

#Start the elvator rise
func _on_pre_life_wait_timeout():
	lift_stage = 1
	shake_camera(3)
	$LiftTimer.start()

#Slow down elevator
func _on_lift_timer_timeout():
	floor_number.text = str($"/root/Autoload".parts_collected + 1)
	floor_number.modulate.a = 0
	floor_number.position.y = -50
	lift_stage = 2

#Open the door
func _on_door_timer_timeout():
	elevator_door.open()

func _on_elevator_door_at_door():
	press_b.show()

func _on_elevator_door_leave_door():
	press_b.hide()

func reset():
	elevator_door.close()
	lift_stage = 0
	floor_number.text = str($"/root/Autoload".parts_collected)

func _on_elevator_door_entered_door():
	$"/root/Autoload".level_handler.set_level($"/root/Autoload".parts_collected+1)
	#get_tree().change_scene_to_packed(levels[$"/root/Autoload".parts_collected])
	#end_scene.emit()
