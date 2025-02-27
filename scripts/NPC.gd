extends AnimatedSprite2D

@export var conversation_number : int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$ConversationArea.conversation_number = conversation_number
	play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
