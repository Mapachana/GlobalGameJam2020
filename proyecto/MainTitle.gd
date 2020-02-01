extends TextureRect


var ScManager = null

# Called when the node enters the scene tree for the first time.
func _ready():
	ScManager = get_node("/root/Global")
	if self.name != "MainTitle":
		$Label3.text = "Score: " + str(ScManager.score)
	set_process(true)

#Check button press
func _process(delta):
	if (Input.is_action_just_pressed("ui_accept")):
		ScManager.goto_scene("res://escenas/main.tscn")

func _on_Button_pressed():
	ScManager.dificil = false
	ScManager.goto_scene("res://escenas/main.tscn")


func _on_Button2_pressed():
	ScManager.dificil = true
	ScManager.goto_scene("res://escenas/main.tscn")


func _on_Button3_pressed():
	get_tree().quit()
	print("hola")
	pass # Replace with function body.
