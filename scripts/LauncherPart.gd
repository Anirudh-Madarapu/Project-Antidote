extends Node2D

@export var part_number : int
var is_collecting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Parts.frame = part_number

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$SmallLight.rotate(.005)
	$BigLight.rotate(-.003)
	if(is_collecting):
		scale += Vector2(1, 1)*delta
		modulate += Color(0, 0, 0, -1)*delta

func _on_interaction_area_interaction_initiated():
	$"/root/Autoload".parts_collected += 1
	is_collecting = true
	$Parts.hide()
