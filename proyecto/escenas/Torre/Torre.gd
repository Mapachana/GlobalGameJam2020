extends Area2D

# puntos de vida actuales y maximos
var life_points = 0
var max_life = 100
var tiempo_espera = 1.0

# señal que indica cuando se cambia la vida de la torre
signal tower_health_change
# señal que indica fin del juego con victoria FIXME sin vincular
signal fin_victoria
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
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


func _on_Torre_body_entered(body):
	if (body.is_repairing and $Timer.is_stopped()):
		$Timer.start(tiempo_espera)
		life_points += 1
		emit_signal("tower_health_change", life_points)
		$Timer.stop()
	else:
		$Timer.stop()
	pass # Replace with function body.
