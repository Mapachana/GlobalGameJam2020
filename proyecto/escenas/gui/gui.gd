extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	# Actualizar direccion con la direccion dle nodo player FIXME
	var player_max_health = $"../Characters/Player".max_health
	$Bar/Gauge.max_value = player_max_health
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

