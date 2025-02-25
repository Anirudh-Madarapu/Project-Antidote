extends AnimatedSprite2D

@export var conversation_number : int = 0
@export var character_animation : String = "1"

# Called when the node enters the scene tree for the first time.
func _ready():
	$ConversationArea.conversation_number = conversation_number
	animation = character_animation


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
