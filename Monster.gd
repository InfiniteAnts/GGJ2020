extends Sprite

export var type = 'MEL'

export var hp = 100
export var armour = 70

export var mel_atk = 10
export var mel_atk_health = 100

export var rngd_atk = 14
export var rngd_atk_health = 100

export var dodge = 25
export var dodge_health = 100

export var stab_effect = 1.5

var atk = 0
var damage_taken = 0

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	# Randomize the seed
	rng.randomize()
	
	# Assign a type randomly to the monster
	if rng.randi_range(0, 1) == 0:
		type = 'MEL'
	else:
		type = 'RNGD'
		
	$'../Healthbars'.update_monster_health(hp)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Calculating Monster's attack
func attack():
	
	# Monster does melee attack
	if rng.randi_range(0, 100) < 50:
		
		atk = (mel_atk_health / 100) * mel_atk
		
		# Check if monster type is MEL
		if type == 'MEL':
			atk = stab_effect * atk

	# Monster does ranged attack
	else:
		atk = (rngd_atk_health / 100) * rngd_atk
		
		# Check if monster type is RNGD
		if type == 'RNGD':
			atk = stab_effect * rngd_atk

	return atk

# Monster attacked
func attacked(monster_atk):

	# If not a succesful dodge
	if rng.randi_range(0, 100) > ((dodge_health / 100) * dodge):
		damage_taken = (1 - (armour / 100)) * monster_atk
	else:
		damage_taken = 0
	
	hp = hp - damage_taken
	
	$AudioStreamPlayer.play()
	$'../Healthbars'.update_monster_health(hp)
