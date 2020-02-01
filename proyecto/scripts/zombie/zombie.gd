extends KinematicBody2D

class_name Zombie

# Cuando el zombie muere
signal zombie_died

# Zombie movement vector
var velocity = Vector2(1,0)
# Zombie speed
var speed = 200
# Direction (right by default)
var direction = 1
var colision
var dmg = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	colision = move_and_collide(direction * velocity * speed * delta)
	if colision and colision.get_collider() is Barricada:
		colision.get_collider().hit(dmg)
		

# Set the movement of the zombie to right (1) or left (-1)
func set_direction(dir):
	if direction != dir:
		direction = dir
		$Sprite.flip_h
	
# Mata al zombie
func die():
	self.queue_free()
	emit_signal("zombie_died")
