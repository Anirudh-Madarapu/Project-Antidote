extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$"/root/Autoload".dialogue_handler.conversation_ended.connect(put_together)
	$"/root/Autoload".dialogue_handler.start_conversation(11)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func put_together(c):
	if(c == 11):
		$PutTheRocketTogether.start()
	

