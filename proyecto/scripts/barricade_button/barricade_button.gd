extends Area2D

class_name barricade_button

signal barricade_button_pressed

# Tiempo de enfriamiento 
export var TIEMPO_ESPERA = 3

# Booleanas
# Botón pulsado
var pressed = false
# Jugador sobre botón
var player_near = false

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_barricade_button_body_entered(body : Player):
	player_near = true
	print("in")

func _on_barricade_button_body_exited(body : Player):
	player_near = false
	print("out")

func _on_player_repairing():
	# Si el jugador está pulsando el botón de reparar se emite la señal para 
	# activar los pinchos a estos, con un cooldown hasta poder volver a pulsarlo
	if player_near and not pressed:
		emit_signal("barricade_button_pressed")
		pressed = true
		$Timer.start(TIEMPO_ESPERA)


func _on_Timer_timeout():
	print("timeout") 	
	pressed = false
