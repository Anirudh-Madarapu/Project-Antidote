extends CanvasLayer

@export var dialogue_file_path : String = "res://scripts/character_dialogue.txt"
@export var time_between_letters : float = 0.05

@onready var dialogue_box = $HBoxContainer/Dialogue
@onready var face_box = $HBoxContainer/FaceBox
@onready var write_delay_timer = $WriteDelayTimer

var is_writing = false
var amount_written = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	write_delay_timer.wait_time = time_between_letters
	var file = FileAccess.open(dialogue_file_path, FileAccess.READ)
	dialogue_box.text = file.get_as_text()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass#if(is_writing):
		
