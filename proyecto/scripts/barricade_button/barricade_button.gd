extends Area2D

class_name barricade_button

signal barricade_button_pressed

# Tiempo de enfriamiento 
export var TIEMPO_ESPERA = 2.3

# Booleanas
# Botón pulsado
var pressed = false
# Jugador sobre botón
var player_near = false
var player1_near = false
var player2_near = false

func _ready():
	# Establecemos que el botón inicialmente esté en la posición levantada
	$Sprite.frame = 0
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_barricade_button_body_entered(body : Player):
	if body:
		if body.nombre == "player":
			player_near = true
		elif body.nombre == "player2":
			player1_near = true
		elif body.nombre == "player3":
			player2_near = true

func _on_barricade_button_body_exited(body : Player):
	if body:
		if body.nombre == "player":
			player_near = false
		elif body.nombre == "player2":
			player1_near = false
		elif body.nombre == "player3":
			player2_near = false

func _on_player_repairing(player : Player):
	# Si el jugador está pulsando el botón de reparar se emite la señal para 
	# activar los pinchos a estos, con un cooldown hasta poder volver a pulsarlo
	if not pressed:
		if (player.nombre == "player" and player_near) or (player.nombre == "player2" and player1_near) or (player.nombre == "player3" and player2_near):
			emit_signal("barricade_button_pressed", player.nombre)
			pressed = true
			$Timer.start(TIEMPO_ESPERA)
			$AnimationPlayer.play("press_button")


func _on_Timer_timeout():
	pressed = false

