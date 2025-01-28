extends CanvasLayer

@export var file_path : String
@export var pictures : Array[Texture2D]
@export var names : Array[String]

@onready var text_box = $Text
@onready var name_box = $Name
@onready var face_box = $FaceBox
@onready var button_prompt = $ButtonPrompt


var already_said : Array[int]
var current_conversation = 0
var current_line = 0
var written_text = 0
var clip_picture_marker = 0
var in_decision = false
var text : Array[String]
var typing_speed = 80

func loadfile():
	var file = FileAccess.open(file_path, FileAccess.READ)
	#var content = file.get_as_text()
	#print(content)
	var new_array : Array[String]
	var current_line = file.get_line()
	while(current_line != ""):
		new_array.append(current_line)
		current_line = file.get_line()
	return new_array

# Called when the node enters the scene tree for the first time.
func _ready():
	text = loadfile()
	text_box.text = text[0]
	text_box.show()
	start_conversation(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if($"/root/Autoload".is_talking):
		if(written_text < text[current_line].length()):
			if(Input.is_action_just_pressed("conversation")):
				written_text = text[current_line].length()
			text_box.text = text[current_line].substr(clip_picture_marker, round(written_text) + 1)
			written_text += delta*typing_speed
		elif(Input.is_action_just_pressed("conversation") && !in_decision):
			button_prompt.hide()
			current_line += 1
			written_text = 0
			if(text[current_line][0] == "/"):
				$"/root/Autoload".is_talking = false
				hide()
				if(current_conversation == 0):
					get_tree().call_group("level_manager", "set_level", 0)
				return
			if(text[current_line][0] == "*"):
				#special cases
				return
			set_picture(current_line)
		else:
			button_prompt.show()
			text_box.text = text[current_line].substr(clip_picture_marker, text[current_line].length() + 1)
				
func find_line(c):
	var i = 0
	while(i < text.size() && (text[i][0] != "/" || int(text[i].substr(1)) != c)):
		i += 1
	return i + 1;
	
func set_picture(c):
	var i = 0
	while(i < text.size() && (text[c][i] != "/")):
		i += 1
	clip_picture_marker = i + 1
	face_box.texture = pictures[int(text[c].substr(0, i))]
	name_box.text = names[int(text[c].substr(0, i))]
	

func start_conversation(c):
	if($"/root/Autoload".is_talking == false):
		button_prompt.hide()
		in_decision = false
		already_said.append(c)
		show()
		current_conversation = c
		current_line = find_line(c)
		set_picture(current_line)
		$"/root/Autoload".is_talking = true
		written_text = 0
		
func clear_already_said():
	already_said.clear()
