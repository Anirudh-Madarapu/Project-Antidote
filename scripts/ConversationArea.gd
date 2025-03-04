extends Area2D

@export var conversation_number : int
signal conversation_ended
# checks for local readiness to talk
var ready_to_talk = true

func _ready():
	$BButton.hide()
	$"/root/Autoload".dialogue_handler.conversation_ended.connect(start_wait_timer)
	$"/root/Autoload".dialogue_handler.conversation_started.connect(stop_asking_for_conv)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print_debug($"/root/Autoload".dialogue_handler.is_talking)
	if(Input.is_action_just_pressed("interact") && get_overlapping_areas().size() > 0 && !$"/root/Autoload".dialogue_handler.is_talking && ready_to_talk):
		$"/root/Autoload".dialogue_handler.start_conversation(conversation_number)
		#ready_to_talk = false
		$BButton.hide()
		
func _on_area_entered(area):
	if(!$"/root/Autoload".dialogue_handler.is_talking):
		$BButton.show()

func stop_asking_for_conv(_c):
	ready_to_talk = false

func _on_area_exited(area):
	$BButton.hide()
	
func start_wait_timer(conv):
	if(conv == conversation_number):
		conversation_ended.emit()
	$WaitTimer.start()

func _on_wait_timer_timeout():
	ready_to_talk = true
	if(get_overlapping_areas().size() > 0):
		$BButton.show()
