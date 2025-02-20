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
		
		# Check if the player is attacking and within attack range

func _on_enemy_hitbox_body_entered(body):
	print('hello')
	player = body
	pass # Replace with function body.


func _on_enemy_hitbox_body_exited(body):
	player = null
	pass # Replace with function body.

func zombie():
	pass
