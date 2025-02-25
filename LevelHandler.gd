extends Node

@export var levels : Array[PackedScene]
@export var levels_to_hide_hud : Array[int]
@export var opening_level : int

var current_scene = null

# Called when the node enters the scene tree for the first time.
func _ready():
	$"/root/Autoload".level_handler = self
	set_level(opening_level)
	$"/root/Autoload".dialogue_handler.conversation_started.connect(pause)
	$"/root/Autoload".dialogue_handler.conversation_ended.connect(resume)
	
func set_level(level):
	if(current_scene != null):
		current_scene.queue_free()
	current_scene = levels[level].instantiate()
	add_child(current_scene)
	if(levels_to_hide_hud.has(level)):
		$HUD.hide()
	else:
		$HUD.show()
	
func pause(conv):
	if(conv != 0):
		print_debug("paused!")
		current_scene.get_tree().paused = true

func resume():
	current_scene.get_tree().paused = false
