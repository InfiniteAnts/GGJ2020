extends Node2D

export var scrap = 300

const SCREENSHAKE = preload("res://ScreenShake.tscn")
const HOLE_MINIGAME = preload('res://Hole_Minigame.tscn')

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _ready():
	var screenshake = SCREENSHAKE.instance()
	$Camera2D.add_child(screenshake)
	
func _on_Volley_Timer_timeout():
	
	# Robot attacks
	var robot_atk  = $Robot.attack()
	$Monster.attacked(robot_atk) 
	
	# Monster attacks
	var monster_atk = $Monster.attack()
	$Robot.attacked(monster_atk)

	$Camera2D/ScreenShake.start()

func _on_StartGame_start_game():
	var hole_minigame = HOLE_MINIGAME.instance()
	self.add_child(hole_minigame)
	hole_minigame.global_position = $Position2D.position
	$Music.play()
	$Volley_Timer.start()
