extends Area2D

class_name barricade_button

signal barricade_button_pressed

# Tiempo de enfriamiento 
export var TIEMPO_ESPERA = 3

# 
var pressed = false

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_barricade_button_body_entered(body : Player):
	# Si el jugador está pulsando el botón de reparar se emite la señal para 
	# activar los pinchos a estos, con un cooldown hasta poder volver a pulsarlo
	if body.is_repairing:
		if not pressed:
			emit_signal("barricade_button_pressed")
			pressed = true
			$Timer.start(TIEMPO_ESPERA)


func _on_Timer_timeout():
	pressed = false
