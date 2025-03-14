extends Sprite2D

var phase = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(phase == 0):
		modulate.a = move_toward(modulate.a, 1, delta)
	if(modulate.a == 1 && phase == 0):
		phase = 1
		Autoload.level_handler.set_level_with_scene_path("res://celebrate.tscn")
	if(phase == 1):
		await get_tree().create_timer(2.0).timeout
		modulate.a = move_toward(modulate.a, 0, delta)

func start_fade():
	set_process(true)

