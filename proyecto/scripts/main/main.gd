extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var ScManager = null
var time_start 

# Called when the node enters the scene tree for the first time.
func _ready():
	ScManager = get_node("/root/Global")
	time_start = OS.get_unix_time()
	$Label.text = "Score: 0"
	if ScManager.dificil:
		$Node2D/barricada.change_health(8)
		$Node2D/barricada2.change_health(8)
		$Node2D/Node2D.min_t = 2.75
		$Node2D/Node2D.max_t = 4.75
	else:
		$Node2D/barricada.change_health(10)
		$Node2D/barricada2.change_health(10)
		$Node2D/Node2D.min_t = 3
		$Node2D/Node2D.max_t = 5
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass


func _on_barricada_barricada_destruida():
	$Node2D/Timer_endgame.start(1.5)

func _on_torre_fin_victoria():
	ScManager.score += 500
	ScManager.score += int(500 / (OS.get_unix_time() - time_start))
	if ScManager.dificl:
		ScManager.score += 1000
	$Label.text = "Score: " + str(ScManager.score)
	ScManager.goto_scene("res://escenas/GameOver_win.tscn")

func _on_Timer_endgame_timeout():
	ScManager.goto_scene("res://escenas/GameOver_lose.tscn")


func _on_pinchos_hit_zombie():
	ScManager.score += 10
	$Label.text = "Score: " + str(ScManager.score)
