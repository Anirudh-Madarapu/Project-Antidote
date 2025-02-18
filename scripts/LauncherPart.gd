extends Node2D

@export var part_number : int
@export var switch_scene : String = "res://levels/elevator.tscn"
var is_collecting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Parts.frame = part_number

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$SmallLight.rotate(1*delta) #.005
	$BigLight.rotate(-.6*delta) #.003
	if(is_collecting):
		scale += Vector2(1, 1)*delta
		modulate += Color(0, 0, 0, -1)*delta
		#if(modulate.a <= 0):
		#	queue_free()

# Part is picked up
func _on_collect_area_area_entered(area):
	is_collecting = true
	$Parts.hide()

# When the part is hidden, update the part counter
func _on_parts_hidden():
	$"/root/Autoload".parts_collected += 1
	get_tree().call_group("part_counter", "part_collected")
	$SwitchTimer.start()
	print_debug("got it")


func _on_switch_timer_timeout():
	print_debug("scene_switched")
	get_tree().change_scene_to_file(switch_scene)
