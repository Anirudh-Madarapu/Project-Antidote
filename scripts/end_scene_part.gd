extends Sprite2D

var started = false
var velocity = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate.a = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if started:
		modulate.a += .2*delta
		move_local_x(velocity.x*delta)
		move_local_y(velocity.y*delta)


func start(center):
	started = true
	velocity = global_position.direction_to(center)*global_position.distance_to(center)/5


