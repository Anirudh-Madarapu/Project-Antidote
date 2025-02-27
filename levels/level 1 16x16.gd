extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	$first_door.close()
	$"/root/Autoload".dialogue_handler.conversation_ended.connect(open_door)
	$"/root/Autoload".dialogue_handler.start_conversation(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func open_door(conv):
	if(conv == 0):
		$first_door.open()
