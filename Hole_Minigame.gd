extends Node2D

const HOLE = preload('res://Hole.tscn')
const FIRE = preload('res://Fire.tscn')

var rng = RandomNumberGenerator.new()

var scrap = 0
var held_object = null

var global_no_of_holes = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$'../Label'.hide()
	
	# Randomize the seed
	rng.randomize()
	
	# Get number of holes
	var no_of_holes = rng.randi_range(2,4)
	global_no_of_holes = no_of_holes

	# $Global.no_of_holes = no_of_holes
	
	$Extuingisher/Smoke.play('idle')
	
	# For each hole
	for _i in range(no_of_holes):

		# Get a random position within the rectangle
		var x_value = rng.randi_range($Position2D.global_position.x, $Position2D3.global_position.x)
		var y_value = rng.randi_range($Position2D2.global_position.y, $Position2D4.global_position.y)

		var hole = HOLE.instance()
		self.add_child(hole)
		
		hole.connect('hole_patched', self, '_on_hole_patched')

		hole.global_position = Vector2(x_value, y_value)
		
	$Timer.start()

func _on_hole_patched():
	
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

# Keep generating 
func _on_Timer_timeout():

	# Get number of holes
	var no_of_holes = rng.randi_range(1,2)
	global_no_of_holes = no_of_holes
	
	# $Global.no_of_holes = no_of_holes
	
	# For each hole
	for _i in range(no_of_holes):

		# Get a random position within the rectangle
		var x_value = rng.randi_range($Position2D.global_position.x, $Position2D3.global_position.x)
		var y_value = rng.randi_range($Position2D2.global_position.y, $Position2D4.global_position.y)

		var random_i = rng.randi_range(1,2)
		
		if random_i == 1:
			var hole = HOLE.instance()
			self.add_child(hole)
			hole.connect('hole_patched', self, '_on_hole_patched')
			hole.global_position = Vector2(x_value, y_value)
		else:
			var fire = FIRE.instance()
			self.add_child(fire)
			fire.global_position = Vector2(x_value, y_value)

func _on_Extuingisher_clicked(object):
	if !held_object:
		held_object = object
		$Extuingisher.pickup()
	
func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if held_object and !event.pressed:
			held_object.drop()
			held_object = null
