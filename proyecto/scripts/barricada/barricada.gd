extends StaticBody2D

class_name Barricada

# Cuando se destruye una barricada
signal barricada_destruida
#señal cuando cambia la vida
signal barricada_health_change
# Vida máxima
export var VIDA_MAX = 10
# Tiempo de espera para reparación
const TIEMPO_ESPERA = 2
# La vida de la barricada
var vida = 0
# Si el cuerpo está dentro
var body_inside = false

# Called when the node enters the scene tree for the first time.
func _ready():
	vida = VIDA_MAX
	$GUI.change_health(vida)
	emit_signal("barricada_health_change", vida)
	
func change_health(health):
	VIDA_MAX = health
	vida = health
	$GUI.change_health(health)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Cuando un zombie ataca la barricada
func hit(dmg):
	# Si ha pasado el tiempo de espera
	if $Timer2.is_stopped():
		# Resta un punto
		vida = clamp(vida - dmg, 0, VIDA_MAX)
		update_sprite()
		
		emit_signal("barricada_health_change", vida)
		if vida == 0:
			set_collision_layer_bit(0, false)
			set_collision_mask_bit(0, false)
			$AnimationPlayer.play("explode")
			emit_signal("barricada_destruida")
		$Timer2.start(TIEMPO_ESPERA)

# Cuando el jugador entra en el area
func _on_Area2D_body_entered(body : Player):
	if body:
		body_inside = true
			
func _on_Area2D_body_exited(body : Player):
	if body:
		body_inside = false
			
func _on_player_repairing(player : Player):
	if body_inside and $Timer.is_stopped():
		vida = clamp(vida + 2, 0, VIDA_MAX)
		update_sprite()
		emit_signal("barricada_health_change", vida)
		$Timer.start(TIEMPO_ESPERA)

func update_sprite():
	if vida == VIDA_MAX:
		$Sprite.frame = 0
	elif vida >= VIDA_MAX / 2:
		$Sprite.frame = 1
	elif vida < VIDA_MAX / 2:
		$Sprite.frame = 2

