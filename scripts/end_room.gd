extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	MusicManager.stop_music()
	MusicManager.play_music("res://sound/music/Ethics.mp3")
	$"/root/Autoload".dialogue_handler.conversation_ended.connect(put_together)
	$"/root/Autoload".dialogue_handler.start_conversation(11)
	await $"/root/Autoload".dialogue_handler.conversation_ended
	$piecesTogether.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func put_together(c):
	if(c == 11):
		$PutTheRocketTogether.start()
	

