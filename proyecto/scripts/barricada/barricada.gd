extends StaticBody2D

class_name Barricada

# Cuando se destruye una barricada
signal barricada_destruida
#señal cuando cambia la vida
signal barricada_health_change
# Vida máxima
const VIDA_MAX = 3
# Tiempo de espera para reparación
const TIEMPO_ESPERA = 2
# La vida de la barricada
export var vida = VIDA_MAX
# Si el cuerpo está dentro
var body_inside = false

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("barricada_health_change", vida)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Cuando un zombie ataca la barricada
func hit(dmg):
	# Si ha pasado el tiempo de espera
	if $Timer2.is_stopped():
		# Resta un punto
		vida = clamp(vida - dmg, 0, VIDA_MAX)
		emit_signal("barricada_health_change", vida)
		if vida == 0:
			set_collision_layer_bit(0, false)
			set_collision_mask_bit(0, false)
			$Timer3_Explosion.start(TIEMPO_ESPERA)
			$AnimationPlayer.play("explode")
		$Timer2.start(TIEMPO_ESPERA)

# Cuando el jugador entra en el area
func _on_Area2D_body_entered(body : Player):
	if body:
		body_inside = true
			
func _on_Area2D_body_exited(body : Player):
	if body:
		body_inside = false
			
func _on_player_repairing():
	if body_inside and $Timer.is_stopped():
		vida = clamp(vida + 1, 0, VIDA_MAX)
		emit_signal("barricada_health_change", vida)
		$Timer.start(TIEMPO_ESPERA)

func _on_Timer3_Explosion_timeout():
	emit_signal("barricada_destruida")
