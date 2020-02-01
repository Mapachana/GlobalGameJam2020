extends Area2D

# puntos de vida actuales y maximos
var life_points = 0
var max_life = 100

# señal que indica cuando se cambia la vida de la torre
signal tower_health_change

# debugging
var tiempo = 0.0

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
	#debugging
	tiempo += delta
	if (tiempo > 3):
		emit_signal("tower_health_change", 50)
	pass
