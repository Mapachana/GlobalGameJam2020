extends Area2D

class_name Torre

# puntos de vida actuales y maximos
var life_points = 0
var max_life = 100
var tiempo_espera = 1.0

var player_near = false
var player1_near = false
var player2_near = false

var rng = RandomNumberGenerator.new()

# señal que indica cuando se cambia la vida de la torre
signal tower_health_change
# señal que indica fin del juego con victoria FIXME sin vincular
signal fin_victoria

signal tower_repaired
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	#inicializar la vida de la torre
	emit_signal("tower_health_change", 0)
	# animacion de la luz
	$AnimationPlayer.play("luz")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (life_points >= 100):
		emit_signal("fin_victoria")
	pass


func _on_torre_body_entered(body : Player):
	if body:
		if body.nombre == "player":
			player_near = true
		elif body.nombre == "player2":
			player1_near = true
		elif body.nombre == "player3":
			player2_near = true
	
func _on_torre_body_exited(body : Player):
	if body:
		if body.nombre == "player":
			player_near = false
		elif body.nombre == "player2":
			player1_near = false
		elif body.nombre == "player3":
			player2_near = false

func _on_player_repairing(player : Player):
	if rng.randf_range(0, 1) > 0.5:
		if $Timer.is_stopped():
			if (player.nombre == "player" and player_near) or (player.nombre == "player2" and player1_near) or (player.nombre == "player3" and player2_near):
				$Timer.start(tiempo_espera)
				life_points += 1
				emit_signal("tower_health_change", life_points)
				emit_signal("tower_repaired", player.nombre)
		
