extends StaticBody2D

class_name Barricada

# Cuando se destruye una barricada
signal barricada_destruida

# Vida máxima
const VIDA_MAX = 3
# Tiempo de espera para reparación
const TIEMPO_ESPERA = 2
# La vida de la barricada
export var vida = VIDA_MAX

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Cuando un zombie ataca la barricada
func hit(dmg):
	# Si ha pasado el tiempo de espera
	if $Timer2.is_stopped():
		# Resta un punto
		vida = clamp(vida - dmg, 0, VIDA_MAX)
		if vida == 0:
			emit_signal("barricada_destruida")
			self.queue_free()
		$Timer2.start(TIEMPO_ESPERA)

# Cuando el jugador entra en el area
func _on_Area2D_body_entered(body : Player):
	if body:
		# Si está reparado
		if body.is_repairing and $Timer.is_stopped():
			vida = clamp(vida + 1, 0, VIDA_MAX)
			$Timer.start(TIEMPO_ESPERA)
			
