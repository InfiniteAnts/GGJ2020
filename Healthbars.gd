extends HSplitContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass 

func update_monster_health(hp):
	$MonsterHealth.value = hp

func update_robot_health(hp):
	$RobotHealth.value = hp

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

