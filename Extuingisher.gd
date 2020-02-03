extends Area2D

signal clicked

var held = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_Extuingisher_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("clicked", self)

func _physics_process(delta):
	if held:
		global_transform.origin = get_global_mouse_position()
		
func pickup():
	if held:
		return
	held = true
	$Smoke.play('smoke')
	$AudioStreamPlayer.play()

func drop():
	if held:
		held = false
	$Smoke.play('idle')
	$AudioStreamPlayer.stop()
