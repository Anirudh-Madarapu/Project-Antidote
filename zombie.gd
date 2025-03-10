extends CharacterBody2D

const SPEED = 50.0  # Zombie movement speed
const DETECTION_RANGE = 200  # How close the player needs to be for the zombie to chase
const ATTACK_RANGE = 50  # How close the player needs to be for the zombie to be attacked

var is_dead = false  # Track if the zombie is dead
var player = null
var pursuit_distance = 100
var attack_distance = 40
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var target: Node2D = null 
@onready var anim = $Animation  # Get animated sprite reference
@onready var navigation_agent_2d = $NavigationAgent2D


func _ready():
	set_physics_process(false)
	call_deferred("zombie_setup")
	#anim.play("idle_left")  # Default animation

func _physics_process(delta):
	if target:
		navigation_agent_2d.target_position = target.global_position
	else:
		target = Autoload.player
		
	if navigation_agent_2d.is_navigation_finished():
		return
	
	if global_position.distance_to(Autoload.player.global_position) > pursuit_distance:
		anim.play("idle_left")
		return
		
	#if target:
	var current_agent_position = global_position
	var next_path_position = navigation_agent_2d.get_next_path_position()
	var new_velocity = current_agent_position.direction_to(next_path_position) * SPEED
		#print_debug(navigation_agent_2d.distance_to_target())
	
	if navigation_agent_2d.avoidance_enabled:
		navigation_agent_2d.set_velocity(new_velocity)
	else:
		_on_navigation_agent_2d_velocity_computed(new_velocity)
	
	if is_dead:
		return  # Skip processing if the zombie is dead	
	# Ensure we have a reference to the player

	# Animation
	anim.flip_h = Autoload.player.global_position.x > global_position.x
	if(global_position.distance_to(Autoload.player.global_position) < attack_distance):
		anim.play("attack_left")
	elif(global_position.distance_to(Autoload.player.global_position) < pursuit_distance):
		anim.play("walk_left")
		
	
	move_and_slide()
	zombie()
		
		# Check if the player is attacking and within attack range

func zombie_setup(): #setup for the zombie pathfinding
	await get_tree().physics_frame
	
	if target:
		navigation_agent_2d.target_position = target.global_position
	set_physics_process(true)
# Check if the player is attacking

# Check if the player is within attack range
func is_player_in_attack_range():
	if player:
		var distance_to_player = global_position.distance_to(player.global_position)
		return distance_to_player <= ATTACK_RANGE
	return false

# Function to make the zombie disappear
func die():
	is_dead = true
	await anim.animation_finished  # Wait for animation to finish
	queue_free()  # Remove zombie from the scene

func _on_enemy_hitbox_body_entered(body):
	player = body
	print('hi')
	

	pass # Replace with function body.

func _on_enemy_hitbox_body_exited(body):
	player = null
	pass # Replace with function body.

func zombie():
	if player != null and Input.is_action_just_pressed("attack"):  # Check if 'A' key is pressed
		$"zombie damage".play()
		anim.hide()
		$enemy_hitbox/CollisionShape2D.disabled = true
		$CollisionShape2D.disabled = true
		$"Zombie death".play()
		is_dead = true
	pass

func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity


func _on_animation_frame_changed():
	if anim.animation == "attack_left" && anim.frame == 2 && !is_dead:
		$"zombie attack".play()
