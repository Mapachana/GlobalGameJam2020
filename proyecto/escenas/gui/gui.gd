extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var max_hp = 1.0
const step = 0.001

# Called when the node enters the scene tree for the first time.
func _ready():
	$Bar/Gauge.max_value = max_hp
	$Bar/Gauge.step = step
	
	set_process(false)
	set_physics_process(false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#Set current value of bar
func set_bar_value(v):
	var newv = v / max_hp
	$Bar/Gauge.value = newv
	$Bar/BackGround/Number.text = str(int(100 * newv))
