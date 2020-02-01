extends TextureRect


var ScManager = null

# Called when the node enters the scene tree for the first time.
func _ready():
	ScManager = get_node("/root/Global")
	set_process(true)

#Check button press
func _process(delta):
	if (Input.is_action_just_pressed("ui_accept")):
		ScManager.goto_scene("res://escenas/main.tscn")
	pass




func _on_Button_pressed():
	ScManager.goto_scene("res://escenas/main.tscn")
	pass # Replace with function body.