extends CharacterBody2D

const SPEED = 100.0  # Zombie movement speed
const DETECTION_RANGE = 200  # How close the player needs to be for the zombie to chase
const ATTACK_RANGE = 50  # How close the player needs to be for the zombie to be attacked
var player = null  # Store reference to player
var is_dead = false  # Track if the zombie is dead

@onready var anim = $AnimatedSprite2D  # Get animated sprite reference

func _ready():
	anim.play("idle")  # Default animation

func _physics_process(delta):
	if is_dead:
		return  # Skip processing if the zombie is dead
	
	# Ensure we have a reference to the player
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * SPEED
		anim.play("walk")  # Play walking animation
		move_and_slide()
		
		# Check if the player is attacking and within attack range

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player = body  # Set player reference

func _on_area_2d_body_exited(body):
	if body == player:
		player = null  # Remove reference when player leaves range

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
	anim.hide()  # Play death animation (optional)
	await anim.animation_finished  # Wait for animation to finish
	queue_free()  # Remove zombie from the scene

func _on_enemy_hitbox_body_entered(body):
	body = player
	anim.hide()
	pass # Replace with function body.

func _on_enemy_hitbox_body_exited(body):
	pass # Replace with function body.

func zombie():
	pass
