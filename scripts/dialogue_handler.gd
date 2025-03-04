extends Node

"""
Use this node to interact with dialogue. 

Use $"/root/Autoload".dialogue_handler to access the functions
here. For example, place 
$"/root/Autoload".dialogue_handler.start_conversation(0)
anywhere in your code to start conversation 0.
"""

var is_talking = false
var current_conv = -1;

# Signals to be sent by ui and recieved by other elements
signal line_ended(line_number, conversation_number)
signal conversation_ended(conversation_number)
signal conversation_started(conversation_number)

# Signals to be recieved by dialogue ui
signal show_dialogue_ui(conversation_number)

func start_conversation(c):
	is_talking = true
	current_conv = c
	conversation_started.emit(c)
	show_dialogue_ui.emit(c)

func end_line(line, conv):
	line_ended.emit(line, conv)

func stop_talking():
	conversation_ended.emit(current_conv)
	current_conv = -1;
	is_talking = false
