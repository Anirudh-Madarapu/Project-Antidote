extends CharacterBody2D

const SPEED = 100.0  # Zombie movement speed
const DETECTION_RANGE = 200  # How close the player needs to be for the zombie to chase
const ATTACK_RANGE = 50  # How close the player needs to be for the zombie to be attacked

var is_dead = false  # Track if the zombie is dead
var player = null
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = $AnimatedSprite2D  # Get animated sprite reference

func _ready():
	anim.play("idle")  # Default animation

func _physics_process(delta):
	if is_dead:
		return  # Skip processing if the zombie is dead	
	# Ensure we have a reference to the player
	move_and_slide()
	zombie()
		
		# Check if the player is attacking and within attack range



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
		anim.hide()
		$enemy_hitbox/CollisionShape2D.disabled = true
		$CollisionShape2D.disabled = true
	pass
