extends VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func update_stats(health):
	
	for item in health:
		
		if item == 'hp':
			continue
		
		var string = item + '/Value'
		get_node(string).text = str(health[item])
