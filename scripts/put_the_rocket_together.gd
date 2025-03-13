extends Node2D

@export var parts : Array[Node]
var distance = 30
var light_phase = 0
var lift = false
var lift_speed = -.1;
var lift_accel = -.1;
var start_y = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Rocket.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(light_phase == 0):
		for i in parts:
			if(i.global_position.distance_to($CenterPoint.global_position) < distance):
				light_phase = 1
	elif(light_phase == 1):
		$CenterPoint.scale += Vector2(delta*.6, delta*.6)
		if($CenterPoint.scale.x > 1.5):
			light_phase = 2
	elif(light_phase == 2):
		$Rocket.global_position = $CenterPoint.global_position
		$Rocket.show()
		$Rocket/CollisionShape2D.set_deferred("disabled", false)
		$Rocket/InteractionArea/CollisionShape2D.set_deferred("disabled", false)
		start_y = position.y
		light_phase = 3
	elif(light_phase == 3):
		$CenterPoint.modulate.a -= delta
	$CenterPoint/Light1.rotation += delta
	$CenterPoint/Light2.rotation -= delta*2
	if(lift):
		lift_speed += delta*lift_accel
		$Rocket.position.y += lift_speed #-60
		$Rocket/RocketSprite.position = Vector2(randi_range(-2, 2), randi_range(-2, 2))
		$Rocket/CPUParticles2D.gravity.y = 250# - (position.y - start_y)/100
		$Rocket/CPUParticles2D.orbit_velocity_min = -1 #/ (position.y - start_y)
		$Rocket/CPUParticles2D.orbit_velocity_max = 1 #/ (position.y - start_y)

func _on_button_button_down():
	start()
		
func start():
	for i in parts:
		i.start($CenterPoint.global_position)
	
func lift_off():
	$Rocket/CPUParticles2D.emitting = true
	lift = true
	$Rocket/CollisionShape2D.set_deferred("disabled", true)
	$Rocket.z_index = 5
	
	 # Add a delay before changing the scene (optional)
	await get_tree().create_timer(2.0).timeout  # Adjust the delay as needed
	get_tree().change_scene_to_file("res://celebrate.tscn")
	
	#$Rocket.velocity = Vector2(0, -5)

func _on_interaction_area_interaction_initiated():
	lift_off()
