extends KinematicBody2D

class_name Zombie

# Cuando el zombie muere
signal zombie_died

# Zombie movement vector
var velocity = Vector2(1,0)
# Zombie speed
var speed = 15
# Direction (right by default)
var direction = 1
var colision
var dmg = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	if (direction == -1):
		$Sprite.set_flip_h(true)
	else:
		$Sprite.set_flip_h(false)
	$AnimationPlayer.play("walk")
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
		$Sprite.set_flip_h(true)
	
# Mata al zombie
func die():
	set_collision_layer_bit(0, false)
	set_collision_mask_bit(0, false)
	$Timer_death.start(0.6)
	set_direction(-1 * direction)
	$AnimationPlayer.play("die")
	
	emit_signal("zombie_died")

func _on_Timer_death_timeout():
	self.queue_free()
