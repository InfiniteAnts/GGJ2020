extends Area2D

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	
	var sprite_number = rng.randi_range(1,3)
	
	$AnimatedSprite.play(str(sprite_number))
	$AudioStreamPlayer.play()

func _on_Fire_area_entered(area):
	
	if area.name == 'Smoke':
		$AnimationPlayer.play("fade")


func _on_AnimationPlayer_animation_finished(anim_name):
	
	var rand_number = rng.randi_range(1, 4)
	
	if rand_number == 1:
		
	# Add armor each time, fire is extuingished	
		$'/root/Global'.health['armour'] += int(0.95 * (70 - $'/root/Global'.health['armour']))
	
	elif rand_number == 2:
		$'/root/Global'.health['mel_atk'] += int(0.95 * (100 - $'/root/Global'.health['mel_atk']))
		
	elif rand_number == 3:
		$'/root/Global'.health['rngd_atk'] += int(0.95 * (100 - $'/root/Global'.health['rngd_atk']))
		
	else:
		$'/root/Global'.health['dodge'] += int(0.95 * (50 - $'/root/Global'.health['dodge']))
	
	self.queue_free()
