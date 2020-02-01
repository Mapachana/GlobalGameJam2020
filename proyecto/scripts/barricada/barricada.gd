extends StaticBody2D

class_name Barricada

# Vida máxima
const VIDA_MAX = 3
# La vida de la barricada
export var vida = VIDA_MAX
# Cuando se destruye una barricada
signal barricada_destruida

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body : Player):
	if body.is_repairing and $Timer.is_stopped():
		vida = clamp(vida + 1, 0, VIDA_MAX)
		$Timer.start(2)
		
