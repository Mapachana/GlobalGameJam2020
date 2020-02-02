extends TextureRect


var ScManager = null

# Called when the node enters the scene tree for the first time.
func _ready():
	ScManager = get_node("/root/Global")
	if self.name != "MainTitle":
		$Label3.text = "Score: " + str(ScManager.score)
		$Label4.text = "Score 1: " + str(ScManager.score1)
		$Label5.text = "Score 2: " + str(ScManager.score2)
		$Label3.show()
		$Label4.hide()
		$Label5.hide()
		if ScManager.multi:
			$Label3.hide()
			$Label4.show()
			$Label5.show()
	set_process(true)

#Check button press
func _process(delta):
	if (Input.is_action_just_pressed("ui_accept")):
		ScManager.goto_scene("res://escenas/main.tscn")

func _on_Button_pressed():
	ScManager.dificil = false
	ScManager.multi = false
	ScManager.goto_scene("res://escenas/main.tscn")


func _on_Button2_pressed():
	ScManager.dificil = true
	ScManager.multi = false
	ScManager.goto_scene("res://escenas/main.tscn")


func _on_Button3_pressed():
	get_tree().quit()


func _on_Button4_pressed():
	ScManager.multi = true
	ScManager.dificil = false
	ScManager.goto_scene("res://escenas/main.tscn")
