extends AnimatedSprite2D

@export var conversation_numbers : Array[int]
var next_conv = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$ConversationArea.conversation_number = conversation_numbers[0]
	play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_conversation_area_conversation_ended():
	if(next_conv < conversation_numbers.size()-1):
		next_conv += 1
		$ConversationArea.conversation_number = conversation_numbers[next_conv]
