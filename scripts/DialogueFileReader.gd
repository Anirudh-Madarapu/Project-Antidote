extends CanvasLayer

@export var file_path : String
@export var pictures : Array[Texture2D]
@export var names : Array[String]
@export var fonts : Array[FontFile]

@onready var text_box = $Control/VBoxContainer/TextBox
@onready var name_box = $Control/VBoxContainer/NameBox
@onready var face_box = $Control/FaceBox
@onready var button_prompt = $Control/VBoxContainer/TextBox/ButtonPrompt
@onready var dialogue_handler = $"/root/Autoload".dialogue_handler

var already_said : Array[int]
var current_conversation = 0
var current_line = 0
var written_text = 0
var clip_picture_marker = 0
var in_decision = false
var text
var typing_speed = 80
var error_loading = false

func loadfile():
	var file = FileAccess.open(file_path, FileAccess.READ)
	if(file == null):
		error_loading = true
		print_debug("Not able to load file")
		return null;
	var new_array : Array[String] = []
	var current_line = file.get_line()
	while(current_line != ""):
		new_array.append(current_line)
		current_line = file.get_line()
	return new_array

# Called when the node enters the scene tree for the first time.
func _ready():
	dialogue_handler.show_dialogue_ui.connect(start_conversation)
	dialogue_handler.conversation_ended.connect(end_conversation)
	text = loadfile()
	#text_box.show()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(dialogue_handler.is_talking):
		if(written_text < text[current_line].length()):
			if(Input.is_action_just_pressed("conversation")):
				written_text = text[current_line].length()
			text_box.text = text[current_line].substr(clip_picture_marker, round(written_text) + 1)
			written_text += delta*typing_speed
		elif(Input.is_action_just_pressed("conversation") && !in_decision):
			button_prompt.hide()
			dialogue_handler.end_line(current_line, current_conversation)
			current_line += 1
			written_text = 0
			# Check if this is the last line in the conversation
			if(text[current_line][0] == "/"):
				dialogue_handler.stop_talking(current_conversation)
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
	#Set face
	var face = pictures[int(text[c].substr(0, i))]
	if(face != null):
		face_box.texture = face
		face_box.show()
	else:
		face_box.hide()
	#Set name
	var n = names[int(text[c].substr(0, i))]
	if(n != ""):
		name_box.text = n
		name_box.show()
	else:
		name_box.hide()
	#Set font
	var f = fonts[int(text[c].substr(0, i))]
	if(f != null):
		text_box.add_theme_font_override("font" ,f)
	

func start_conversation(c):
	if(!error_loading):
		show()
		button_prompt.hide()
		in_decision = false
		already_said.append(c)
		current_conversation = c
		current_line = find_line(c)
		set_picture(current_line)
		written_text = 0
	else:
		dialogue_handler.stop_talking(current_conversation)
				

func end_conversation(_c):
	hide()

func clear_already_said():
	already_said.clear()
