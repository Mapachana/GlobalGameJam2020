extends KinematicBody2D

# Zombie movement vector
var velocity = Vector2(1,0)
# Zombie speed
var speed = 200
# Direction (right by default)
var direction = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_collide(direction * velocity * speed * delta)
	pass

# Set the movement of the zombie to right (1) or left (-1)
func set_direction(dir):
	if direction != dir:
		direction = dir
		$Sprite.flip_h
	pass
