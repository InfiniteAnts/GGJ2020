extends Area2D

var rng = RandomNumberGenerator.new()
signal hole_patched

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	
	var sprite_number = rng.randi_range(1, 4)
	
	$Hole.play(str(sprite_number))
	
# If holes are overlapping, delete itself
#func _on_Node2D_area_entered(area):
#	$Global.no_of_holes -= 1
#	queue_free()

func _on_Node2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		$AudioStreamPlayer.play()
		$Hole.play('patched')
		$CollisionShape2D.set_disabled(true)
		emit_signal("hole_patched")
