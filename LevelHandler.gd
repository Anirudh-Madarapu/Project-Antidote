extends Node

@export var levels : Array[PackedScene]
@export var death_screen : PackedScene
@export var levels_to_hide_hud : Array[int]
@export var opening_level : int

var current_scene = null
var current_level : int = 0
var global_health: int = 100
var serum_bar_value: int = 60

# Called when the node enters the scene tree for the first time.
func _ready():
	$"/root/Autoload".level_handler = self
	set_level(opening_level)
	$"/root/Autoload".dialogue_handler.conversation_started.connect(pause)
	$"/root/Autoload".dialogue_handler.conversation_ended.connect(resume)
	
func set_level(level):
	current_level = level
	if(current_scene != null):
		current_scene.queue_free()
	current_scene = levels[level].instantiate()
	add_child(current_scene)
	if(levels_to_hide_hud.has(level)):
		$HUD.hide()
	else:
		$HUD.show()

func set_level_with_scene(level):
	current_level = -1
	if(current_scene != null):
		current_scene.queue_free()
	current_scene = level.instantiate()
	add_child(current_scene)

func set_level_with_scene_path(level_path):
	var level = load(level_path)
	current_level = -1
	if(current_scene != null):
		current_scene.queue_free()
	current_scene = level.instantiate()
	add_child(current_scene)

func pause(_c):
	print_debug("paused!")
	get_tree().paused = true

func resume(_c):
	get_tree().paused = false

func die():
	if(current_scene != null):
		current_scene.queue_free()
	current_scene = death_screen.instantiate()
	add_child(current_scene)
	$HUD.hide()

func switch_to_celebrate():
	$FadeEffects/GreenFog.start_fade()
