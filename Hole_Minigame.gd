extends Node2D

const HOLE = preload("res://Hole.tscn")

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# Randomize the seed
	rng.randomize()
	
	# Get number of holes
	var no_of_holes = rng.randi_range(2,6)
	
	# For each hole
	for _i in range(no_of_holes):
		
		# Get a random position within the rectangle
		var x_value = rng.randi_range($Position2D.global_position.x, $Position2D3.global_position.x)
		var y_value = rng.randi_range($Position2D2.global_position.y, $Position2D4.global_position.y)
		
		var hole = HOLE.instance()
		self.add_child(hole)
		
		hole.global_position = Vector2(x_value, y_value)
