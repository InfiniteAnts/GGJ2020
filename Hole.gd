extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass 
	
# If holes are overlapping, delete itself
func _on_Node2D_area_entered(area):
	queue_free()
