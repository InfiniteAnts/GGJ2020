extends CanvasLayer

signal start_game

func _ready():
	$Label3.hide()


func _on_Button_pressed():
	$ColorRect.hide()
	$Label.hide()
	$Button.hide()
	$Label2.hide()
	$Label3.hide()
	emit_signal('start_game')
	
func show_game_over():
	
	# Stop the music
	$'../Music'.stop()

	$'../Volley_Timer'.one_shot = true
	
	$Label3.show()
	$ColorRect.show()

	$Timer.start()
	
func _on_Timer_timeout():
	get_tree().quit()
