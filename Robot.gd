extends Sprite

export var type = 'MEL'

export var mel_atk = 10
export var rngd_atk = 10
export var dodge = 25

export var stab_effect = 1.5

export var health = {'hp' : 100, 'armour': 70, 'mel_atk': 100, 'rngd_atk': 100, 'dodge': 100}

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# Set the initial stats
	$RobotStats.update_stats(health)
	
	# Randomize the seed
	rng.randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):

# Robot attacked
func attacked(monster_atk):

	var damage_taken = 0
	
	# If not a succesful dodge
	if rng.randi_range(0, 100) > ((health['dodge'] / 100) * dodge):
		damage_taken = (1 - (health['armour'] / 100)) * monster_atk
	else:
		damage_taken = 0

	# Update Armour
	var damage_to_armour = 0.7 * damage_taken
	health['armour'] -= damage_to_armour
	
	# Rest of the subsystems, damage distributed randomly
	var remaining_damage = damage_taken - damage_to_armour
	
	# Update HP
	health['hp'] -= remaining_damage
	
	for item in health:
		
		if item == 'armour':
			health[item] = clamp(health[item], 0, 100)
			continue
		
		var damage_to = rng.randi_range(0, remaining_damage)
		health[item] -= damage_to
		remaining_damage -= damage_to
		
		health[item] = clamp(health[item], 0, 100)

	$RobotStats.update_stats(health)
	
# Robot's attack
func attack():
	
	var atk = 0
	
	# Robot does melee attack
	if rng.randi_range(0, 100) < 50:
		
		atk = (health['mel_atk'] / 100) * mel_atk
		
		# Check if robot type is MEL
		if type == 'MEL':
			atk = stab_effect * atk

		$'../AnimationPlayer'.play("melee")
		
	# Robot does ranged attack
	else:
		atk = (health['rngd_atk'] / 100) * rngd_atk
		
		# Check if robot type is RNGD
		if type == 'RNGD':
			atk = stab_effect * rngd_atk

	return atk
