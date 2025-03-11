extends Area2D

@export var hide_button_prompt : bool = false

signal interaction_initiated

# Called when the node enters the scene tree for the first time.
func _ready():
	$BButton.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("interact") && get_overlapping_areas().size() > 0):
		interaction_initiated.emit()
		$BButton.hide()


func _on_area_entered(area):
	if(!hide_button_prompt):
		$BButton.show()

func _on_area_exited(area):
	$BButton.hide()
