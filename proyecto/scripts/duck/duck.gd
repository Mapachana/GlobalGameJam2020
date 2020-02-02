extends KinematicBody2D


# Duck movement vector
var velocity = Vector2(1,0)
# Duck direction
export var direction = 1
# Duck speed
export var speed = 15
# Lucky duck (special movement)
export var lucky_duck = false
var animation_selected = 0
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	if direction == -1:
		$Sprite.set_flip_h(true)
	# If lucky duck remove collisions
	if lucky_duck:
		speed = 200
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision = move_and_collide(direction * velocity * speed * delta)
	if collision:
		direction *= -1
		$Sprite.set_flip_h(!$Sprite.flip_h)
		speed *= 1.5
	if lucky_duck:
		if animation_selected == 0:
			animation_selected = rng.randi_range(1,3)
			if animation_selected == 1:
				$AnimationPlayer.play("lucky_duck_1")
			elif animation_selected == 2:
				$AnimationPlayer.play("lucky_duck_2")
			elif animation_selected == 3:
				$AnimationPlayer.play("lucky_duck_3")

func explode_duck():
	$Timer_explosion.start(1)
	$AnimationPlayer.play("explode")

func _on_Timer_explosion_timeout():
	self.queue_free()
	
