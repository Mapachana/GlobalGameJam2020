extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ScManager = null
export var min_t = 2
export var max_t = 10
var n_zombie = 1

var rng = RandomNumberGenerator.new()
const zombie_plantilla = preload("res://escenas/zombie/zombie.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	ScManager = get_node("/root/Global")
	poner_crono()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
	

func poner_crono():
	$Timer.start(rng.randf_range(min_t, max_t))

func _on_Timer_timeout():
	var zom = zombie_plantilla.instance()
	self.add_child(zom)
	poner_crono()
	if round(rng.randf_range(0,1)):
		zom.position.x += 540
		zom.set_direction(-1)
	if ScManager.multi:
		zom.speed += 25
	zom.add_to_group("enemies")
