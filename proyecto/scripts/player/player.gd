extends KinematicBody2D


class_name Player

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 1.0
var vel = Vector2(0.0,0.0)
var anim
var is_repairing = false

# Señal para reparar
signal repairing


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	repair()
	move()
	move_and_collide(vel)
	pass

func move():
	if (Input.is_action_pressed("ui_right")):
		vel.x = speed
		vel.y = 0
		$Sprite.set_flip_h(false)
		change_anim("walk_right")
	elif (Input.is_action_pressed("ui_left")):
		vel.x = -speed
		vel.y = 0
		$Sprite.set_flip_h(true)
		change_anim("walk_right")
	else:
		vel.x = 0
		vel.y = 0
		#change_anim("walk2")
		
func repair():
	if (Input.is_action_pressed("ui_accept")):
		is_repairing = true
		emit_signal("repairing")
		#change_anim("repair")
	else:
		is_repairing = false
		#change_anim("walk")
	
	
func change_anim(new_anim):
	if (new_anim != anim):
		anim = new_anim
		$AnimationPlayer.play(new_anim)

