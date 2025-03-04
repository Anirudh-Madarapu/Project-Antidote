extends Node2D

@export var parts : Array[Node]
var distance = 30
var light_phase = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(light_phase == 0):
		for i in parts:
			if(i.global_position.distance_to($CenterPoint.global_position) < distance):
				light_phase = 1
	elif(light_phase == 1):
		$CenterPoint.scale += Vector2(delta*.6, delta*.6)
		if($CenterPoint.scale.x > 1.5):
			light_phase = 2
	elif(light_phase == 2):
		$Rocket.global_position = $CenterPoint.global_position
		$Rocket.show()
		$CenterPoint.modulate.a -= delta
	$CenterPoint/Light1.rotation += delta
	$CenterPoint/Light2.rotation -= delta*2

func _on_button_button_down():
	start()
		
func start():
	for i in parts:
		i.start($CenterPoint.global_position)
	

