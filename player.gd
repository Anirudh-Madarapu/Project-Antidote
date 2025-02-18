extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_HEALTH = 100
const DAMAGE_AMOUNT = 10
var health = MAX_HEALTH

var is_attacking = false  # Track if the player is attacking
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimatedSprite2D
@onready var health_bar = $"../../CanvasLayer/ProgressBar"
@onready var armour_bar = $"../../CanvasLayer/ProgressBar2"



func handle_attack():
	if Input.is_action_just_pressed("attack"):  # Make sure to set up "attack" action as "A" key in project settings
		is_attacking = true
		anim.play("attack")  # Play attack animation
		await anim.animation_finished  # Wait for attack animation to finish
		is_attacking = false
		
func _ready():
	anim.play("idle")
	update_health_bar()

	
func take_damage(amount):
	health -= amount
	health = max(health, 0) # Prevent health from going below 0
	update_health_bar()
	
func heal(amount):
	health += amount
	health = min(health, MAX_HEALTH) # Prevent overhealing
	update_health_bar()
	
func update_health_bar():
	if health_bar:
		health_bar.value = health


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
		if direction > 0:
			anim.play("run_right")
		else:
			anim.play("run_left")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	# Handle vertical movement
	if direction_y:
		velocity.y = -direction_y * SPEED
		if direction_y > 0:
			anim.play("run_up")
		else:
			anim.play("run_down")
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	# If there's no movement and not attacking, revert to idle animation
	if velocity.x == 0 and velocity.y == 0 and !is_attacking:
		anim.play("idle")
		
	# Move and check for collisions
	move_and_slide()
	
	# Handle collision damage
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider():
			take_damage(0.10)  # Fixed 10 damage per collision
