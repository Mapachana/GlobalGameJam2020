extends KinematicBody2D


# Duck movement vector
var velocity = Vector2(1,0)
# Duck direction
export var direction = 1
# Duck speed
export var speed = 15

# Called when the node enters the scene tree for the first time.
func _ready():
	if direction == -1:
		$Sprite.set_flip_h(true)
	$AnimationPlayer.play("walk")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision = move_and_collide(direction * velocity * speed * delta)
	
	if collision:
		$AnimationPlayer.play("panic")

