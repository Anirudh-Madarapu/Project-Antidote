extends Control

func _ready():
	update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func part_collected():
	update()

func update():
	$Control/Number.text = str($"/root/Autoload".parts_collected)+"/4"
