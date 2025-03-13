extends Node2D

@onready var npc = $Zombie/AnimatedSprite2D
@onready var npc2 = $Zombie2/AnimatedSprite2D
@onready var npc3 = $Zombie3/AnimatedSprite2D
@onready var npc4 = $Zombie4/AnimatedSprite2D
@onready var npc5 = $Zombie5/AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	npc.play("default")
	npc2.play("default")
	npc3.play("default")
	npc4.play("default")
	npc5.play("default")
	
	await get_tree().create_timer(5.0).timeout  # Adjust the delay as needed
	npc.play("change")
	npc2.play("change")
	npc3.play("change")
	npc4.play("change")
	npc5.play("change")
	pass
