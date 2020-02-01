extends MarginContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var animated_health = 0
onready var  tween = $Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	# Actualizar direccion con la direccion dle nodo player FIXME
	#var player_max_health = $"../Characters/Player".max_health
	#$Bar/Gauge.max_value = player_max_health
	$Bar/Gauge.max_value = 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var round_value = round(animated_health)
	$Bar/number.text = str(round_value)
	$Bar/Gauge.value = round_value

func update_health(new_value):
	$Bar/number.text = str(new_value)
	tween.interpolate_property(self, "animated_health", animated_health, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()

func _on_Torre_tower_health_change(new_tower_health):
	update_health(new_tower_health)

func _on_barricada_barricada_health_change(new_bar_health):
	update_health(new_bar_health)
