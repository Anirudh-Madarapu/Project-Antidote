extends Area2D

@export var conversation_number : int


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("interact") && get_overlapping_areas().size() > 0 && !$"/root/Autoload".dialogue_handler.is_talking):
		$"/root/Autoload".dialogue_handler.start_conversation(conversation_number)
		
