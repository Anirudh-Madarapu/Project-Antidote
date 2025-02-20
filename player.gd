extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -400.0
const MAX_HEALTH = 100
const DAMAGE_AMOUNT = 10
var health = MAX_HEALTH

var is_attacking = false  # Track if the player is attacking
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimatedSprite2D
@onready var health_bar = $CanvasLayer/ProgressBar
@onready var armour_bar = $"../../CanvasLayer/ProgressBar2"

var attack_in_range = false

func handle_attack():
	if Input.is_action_just_pressed("attack"):  # Make sure to set up "attack" action as "A" key in project settings
		is_attacking = true
		anim.play("attack")  # Play attack animation
		await anim.animation_finished  # Wait for attack animation to finish
		is_attacking = false
		
func _ready():
	anim.play("idle")
	

func _physics_process(delta):
	# Handle attack first
	if Input.is_action_just_pressed("attack"):
		handle_attack()
		return  # Skip movement while attacking
		
	# Skip movement processing if currently attacking
	if is_attacking:
		return
		
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_down", "ui_up")
	
	# Handle horizontal movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	# Handle vertical movement
	if direction_y:
		velocity.y = -direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	# Animation
	if direction_y > 0:
		anim.play("run_up")
	elif direction_y < 0:
		anim.play("run_down")
	elif direction > 0:
		anim.play("run_right")
	elif direction < 0:
		anim.play("run_left")
	
		
	# If there's no movement and not attacking, revert to idle animation
	if velocity.x == 0 and velocity.y == 0 and !is_attacking:
		anim.play("idle")
		
	# Move and check for collisions
	move_and_slide()
	attack()

func update_health():
	health_bar.value = health 
	

	  # Wait for 1 second (optional delay)
		
func player():
	pass

func simulate_damage():
	for i in range(10):  # Loop 10 times
		if health <= 0 and attack_in_range:  # Stop the loop if health is 0 or below
			print("Health reached 0. Stopping loop.")
			break
		if attack_in_range:
			health -= 10  # Subtract 10 from health
			update_health()  # Update the health bar
			print("Health after iteration ", i + 1, ": ", health)  # Print current health
			await get_tree().create_timer(1.0).timeout  # Wait for 1 second (optional delay)
		
func _on_player_hit_box_body_entered(body):
	if body.has_method("zombie"):
		attack_in_range = true
		simulate_damage()

	pass # Replace with function body.


func _on_player_hit_box_body_exited(body):
	if body.has_method("zombie"):
		attack_in_range = false
	pass # Replace with function body. pass # Replace with function body.


func attack():
	if attack_in_range:
		
		print('')
