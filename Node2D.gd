extends Node2D

export var scrap = 300

const SCREENSHAKE = preload("res://ScreenShake.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var screenshake = SCREENSHAKE.instance()
	$Camera2D.add_child(screenshake)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Volley_Timer_timeout():
	
	# Robot attacks
	var robot_atk  = $Robot.attack()
	$Monster.attacked(robot_atk) 
	
	# Monster attacks
	var monster_atk = $Monster.attack()
	$Robot.attacked(monster_atk)
	
	$Camera2D/ScreenShake.start()
