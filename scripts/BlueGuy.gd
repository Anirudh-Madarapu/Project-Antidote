extends AnimatedSprite2D

@export var conversation_numbers : Array[int]
var next_conv = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#$ConversationArea.conversation_number = conversation_numbers[0]
	play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Autoload.player.health > 20):
		$ConversationArea.conversation_number = 6
	else:
		$ConversationArea.conversation_number = 14

