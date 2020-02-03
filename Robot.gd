extends Sprite

export var type = 'MEL'

export var mel_atk = 10
export var rngd_atk = 10
export var dodge = 25

export var stab_effect = 1.5

export var health = {'hp' : 100, 'armour': 75, 'mel_atk': 100, 'rngd_atk': 100, 'dodge': 100}

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$"/root/Global".health = health
	
	#for item in health:
	#	$'/root/Global'.health[item] = health[item]
	
	# Set the initial stats
	$'../Healthbars'.update_robot_health($'/root/Global'.health['hp'])
	$RobotStats.update_stats($'/root/Global'.health)
	
	update_blueprint()
	# Set the blueprint
	
	# Randomize the seed
	rng.randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):

# Robot attacked
func attacked(monster_atk):

	var damage_taken = 0
	
	# If not a succesful dodge
	if rng.randi_range(0, 100) > (($'/root/Global'.health['dodge'] / 100) * dodge):
		damage_taken = int((1 - ($'/root/Global'.health['armour'] / 100)) * monster_atk)
	else:
		damage_taken = 0

	# Update Armour
	var damage_to_armour = int(0.7 * damage_taken)
	$'/root/Global'.health['armour'] -= damage_to_armour
	
	# Rest of the subsystems, damage distributed randomly
	var remaining_damage = damage_taken - damage_to_armour
	
	# Update HP
	$'/root/Global'.health['hp'] -= remaining_damage
	
	for item in health:
		
		if item == 'armour':
			$'/root/Global'.health[item] = clamp($'/root/Global'.health[item], 0, 100)
			continue
		
		var damage_to = rng.randi_range(0, remaining_damage)
		$'/root/Global'.health[item] -= damage_to
		remaining_damage -= damage_to
		
		$'/root/Global'.health[item] = clamp(health[item], 0, 70)
	
	update_blueprint()
	
	# Update stats
	$'../Healthbars'.update_robot_health($'/root/Global'.health['hp'])
	$RobotStats.update_stats($'/root/Global'.health)
	
	if $'/root/Global'.health['hp'] <= 0:
		$'../StartGame'.show_game_over()

func update_blueprint():

	# Update Armour
	if $'/root/Global'.health['armour'] > 70:
		$Blueprint/Chest.play('high')
		$Blueprint/Helmet.play('high')
	elif$'/root/Global'.health['armour'] > 40 and $'/root/Global'.health['armour'] <= 70:
		$Blueprint/Chest.play('med')
		$Blueprint/Helmet.play('med')
	else:
		$Blueprint/Chest.play('low')
		$Blueprint/Helmet.play('low')
	
	# Update Melee Attack
	if $'/root/Global'.health['mel_atk'] > 70:
		$Blueprint/LeftArm.play('high')
	elif $'/root/Global'.health['mel_atk'] > 40 and $'/root/Global'.health['mel_atk'] <= 70:
		$Blueprint/LeftArm.play('med')
	else:
		$Blueprint/LeftArm.play('low')

	# Update Ranged Attack
	if $'/root/Global'.health['rngd_atk'] > 70:
		$Blueprint/RightArm.play('high')
	elif $'/root/Global'.health['rngd_atk'] > 40 and $'/root/Global'.health['rngd_atk'] <= 70:
		$Blueprint/RightArm.play('med')
	else:
		$Blueprint/RightArm.play('low')
	
	# Update Dodge
	if $'/root/Global'.health['dodge'] > 70:
		$Blueprint/Legs.play('high')
		$Blueprint/Feet.play('high')
	elif $'/root/Global'.health['dodge'] > 40 and $'/root/Global'.health['dodge'] <= 70:
		$Blueprint/Legs.play('med')
		$Blueprint/Feet.play('med')
	else:
		$Blueprint/Legs.play('low')
		$Blueprint/Feet.play('low')
		
# Robot's attack
func attack():
	
	var atk = 0
	
	# Robot does melee attack
	if rng.randi_range(0, 100) < 50:
		
		atk = ($'/root/Global'.health['mel_atk'] / 100) * mel_atk
		
		# Check if robot type is MEL
		if type == 'MEL':
			atk = stab_effect * atk

		$'../AnimatedSprite'.play('melee')
		$MeleeSound.play()
		
	# Robot does ranged attack
	else:
		atk = ($'/root/Global'.health['rngd_atk'] / 100) * rngd_atk
		
		# Check if robot type is RNGD
		if type == 'RNGD':
			atk = stab_effect * rngd_atk
			
		$'../AnimatedSprite'.play('ranged')
		$RangedSound.play()
	return atk

func _on_AnimatedSprite_animation_finished():
	$'../AnimatedSprite'.play('idle')
