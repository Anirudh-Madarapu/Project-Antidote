extends Node

@export var levels : Array[PackedScene]
@export var levels_to_hide_hud : Array[int]
@export var opening_level : int

var current_scene = null

# Called when the node enters the scene tree for the first time.
func _ready():
	$"/root/Autoload".level_handler = self
	print_debug("Hi, mom!")
	set_level(opening_level)

	
func set_level(level):
	if(current_scene != null):
		current_scene.queue_free()
	current_scene = levels[level].instantiate()
	add_child(current_scene)
	if(levels_to_hide_hud.has(level)):
		$HUD.hide()
	else:
		$HUD.show()
	

