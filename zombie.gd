extends CharacterBody2D

const SPEED = 100.0  # Zombie movement speed
const DETECTION_RANGE = 200  # How close the player needs to be for the zombie to chase
var player = null  # Store reference to player

@onready var anim = $AnimatedSprite2D  # Get animated sprite reference

func _ready():
	anim.play("idle")  # Default animation

func _physics_process(delta):
	# Ensure we have a reference to the player
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * SPEED
		anim.play("walk")  # Play walking animation
		move_and_slide()
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player = body  # Set player reference

func _on_area_2d_body_exited(body):
	if body == player:
		player = null  # Remove reference when player leaves range

# Function to make the zombie disappear
func die():
	anim.play("die")  # Play death animation (optional)
	await anim.animation_finished  # Wait for animation to finish
	queue_free()  # Remove zombie from the scene
