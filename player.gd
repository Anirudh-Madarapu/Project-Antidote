extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -400.0
const MAX_HEALTH = 100
const DAMAGE_AMOUNT = 10

var enemy_attack_in_range = false
var health = MAX_HEALTH
var player_alive = true

var is_attacking = false  
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimatedSprite2D
@onready var health_bar = $"../PlayerInSuit/health_bar"


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
	
	# Handle collision damage
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider():
			take_damage(0.10)
	enemy_attack() # Ensure this is called in physics process
	
func player():
	pass

func _on_player_hitbox_body_entered(body):
	print('hii')
	if body.has_method("zombie"):
		enemy_attack_in_range = true
	pass # Replace with function body.

func _on_player_hitbox_body_exited(body):
	if body.has_method("zombie"):
		enemy_attack_in_range = false
	pass # Replace with function body.

func enemy_attack():

	if enemy_attack_in_range == true:
			print('player took damage')
			

