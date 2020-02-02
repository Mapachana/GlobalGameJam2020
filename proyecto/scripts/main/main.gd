extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var ScManager = null
var time_start 
var rng = RandomNumberGenerator.new()
var moba = false
var prob_moba
const plantilla_pato = preload("res://escenas/duck/duck.tscn")
var pato


# Called when the node enters the scene tree for the first time.
func _ready():
	moba = false
	rng.randomize()
	ScManager = get_node("/root/Global")
	ScManager.score = 0
	ScManager.score1 = 0
	ScManager.score2 = 0
	time_start = OS.get_unix_time()
	$Label.text = "Score: 0"
	$Label2.text = "Score 2: 0"
	$Label3.text = "Score 1: 0"
	$Label.show()
	$Label2.hide()
	$Label3.hide()
	$Node2D/player.show()
	$Node2D/player.set_collision_layer_bit(0, true)
	$Node2D/player.set_collision_mask_bit(0, true)
	$Node2D/player2.hide()
	$Node2D/player2.set_collision_layer_bit(0, false)
	$Node2D/player2.set_collision_mask_bit(0, false)
	$Node2D/player3.hide()
	$Node2D/player3.set_collision_layer_bit(0, false)
	$Node2D/player3.set_collision_mask_bit(0, false)
	$Node2D
	if ScManager.multi:
		$Node2D/barricada.change_health(6)
		$Node2D/barricada2.change_health(6)
		$Node2D/Node2D.min_t = 1.5
		$Node2D/Node2D.max_t = 3.5
		prob_moba = 0.95
		$Label.hide()
		$Label2.show()
		$Label3.show()
		$Node2D/player.hide()
		$Node2D/player.set_collision_layer_bit(0, false)
		$Node2D/player.set_collision_mask_bit(0, false)
		$Node2D/player2.show()
		$Node2D/player2.set_collision_layer_bit(0, true)
		$Node2D/player2.set_collision_mask_bit(0, true)
		$Node2D/player3.show()
		$Node2D/player3.set_collision_layer_bit(0, true)
		$Node2D/player3.set_collision_mask_bit(0, true)
		
	elif ScManager.dificil:
		$Node2D/barricada.change_health(8)
		$Node2D/barricada2.change_health(8)
		$Node2D/Node2D.min_t = 2.5
		$Node2D/Node2D.max_t = 4.5
		prob_moba = 0.95
	else:
		$Node2D/barricada.change_health(10)
		$Node2D/barricada2.change_health(10)
		$Node2D/Node2D.min_t = 3
		$Node2D/Node2D.max_t = 5
		prob_moba = 0.90

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass


func _on_barricada_barricada_destruida():
	$Node2D/Timer_endgame.start(1.5)

func _on_torre_fin_victoria():
	ScManager.score += 500
	ScManager.score += int(500 / (OS.get_unix_time() - time_start))
	ScManager.score1 += 500
	ScManager.score1 += int(500 / (OS.get_unix_time() - time_start))
	ScManager.score2 += 500
	ScManager.score2 += int(500 / (OS.get_unix_time() - time_start))	
	if ScManager.dificil:               
		ScManager.score += 1000
	$Label.text = "Score: " + str(ScManager.score)
	$Label3.text = "Score 1: " + str(ScManager.score)
	$Label2.text = "Score 2: " + str(ScManager.score)	
	ScManager.goto_scene("res://escenas/GameOver_win.tscn")

func _on_Timer_endgame_timeout():
	ScManager.goto_scene("res://escenas/GameOver_lose.tscn")


func _on_pinchos_hit_zombie(name):
	if name == "pinchos":
		ScManager.score1 += 10
		$Label3.text = "Score 1: " + str(ScManager.score1)
	else:
		ScManager.score2 += 10
		$Label2.text = "Score 2: " + str(ScManager.score2)
	ScManager.score += 10
	$Label.text = "Score: " + str(ScManager.score)
	if not moba and rng.randf_range(0, 1) > prob_moba:
		moba = true
		# Hacer pato
		pato = plantilla_pato.instance()
		$pato.add_child(pato)
		pato.lucky_duck = true
		
func _on_player_pato_presionado():
	if moba:
		moba = false
		pato.explode_duck()
		$Explosion.start(0.5)


func _on_Area2D_body_entered(body):
	if moba:
		moba = false
		pato.queue_free()


func _on_Explosion_timeout():
	get_tree().call_group("enemies", "die")


func _on_torre_tower_repaired(name):
	if name == "player2":
		ScManager.score1 += 10
		$Label3.text = "Score 1: " + str(ScManager.score1)
	elif name == "player3":
		ScManager.score2 += 10
		$Label2.text = "Score 2: " + str(ScManager.score2)
	ScManager.score += 10
	$Label.text = "Score: " + str(ScManager.score)
