extends Node2D

@onready var npc = $Zombie/AnimatedSprite2D
@onready var npc2 = $Zombie2/AnimatedSprite2D
@onready var npc3 = $Zombie3/AnimatedSprite2D
@onready var npc4 = $Zombie4/AnimatedSprite2D
@onready var npc5 = $Zombie5/AnimatedSprite2D
@onready var zoom = $PlayerInSuit/Camera2D
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	$Timer.timeout.connect(_on_timer_timeout)
	MusicManager.play_music("res://sound/music/Ethics.mp3")
	npc.play("default")
	npc2.play("default")
	npc3.play("default")
	npc4.play("default")
	npc5.play("default")
	
	await get_tree().create_timer(5.0).timeout  # Adjust the delay as needed
	npc.play("change")
	npc2.play("change2")
	npc3.play("change3")
	npc4.play("change4")
	npc5.play("change5")
	pass

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/creditsAtEnd.tscn")
