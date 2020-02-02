extends KinematicBody2D


class_name Player

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 120
var vel = Vector2(0.0,0.0)
var anim
var is_repairing = false

# Posibles texturas
var player_tex1 = preload("res://img/player/player_completo.png")
var player_tex2 = preload("res://img/player/player2_completo.png")

# Señal para reparar
signal repairing
signal pato_presionado

export var left = "ui_left"
export var right = "ui_right"
export var reparar = "ui_accept"
export var pato = "ui_pato"

export var nombre = "player"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("idle")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	repair()
	move()
	if is_repairing:
		change_anim("repair_right")
		emit_signal("repairing", self)
	move_and_collide(vel*delta)
	pass

func move():
	if (Input.is_action_pressed(right)):
		vel.x = speed
		vel.y = 0
		is_repairing = false
		$Sprite.set_flip_h(false)
		if $AnimationPlayer.current_animation != "walk_right":
			change_anim("walk_right")
	elif (Input.is_action_pressed(left)):
		vel.x = -speed
		vel.y = 0
		is_repairing = false
		$Sprite.set_flip_h(true)
		if $AnimationPlayer.current_animation != "walk_right":
			change_anim("walk_right")
	elif Input.is_action_pressed(pato):
		emit_signal("pato_presionado", self)
	elif (not is_repairing):
		vel.x = 0
		vel.y = 0
		#$AnimationPlayer.stop(true)
		change_anim("idle")
	elif is_repairing:
		vel.x = 0
		vel.y = 0
		change_anim("repair_right")
		
func repair():
	if Input.is_action_pressed(reparar):
		is_repairing = true
	else:
		is_repairing = false
		if $AnimationPlayer.current_animation == "repair_right":
			change_anim("idle")
		#change_anim("walk")
	
	
func change_anim(new_anim):
	if (new_anim != anim):
		anim = new_anim
		$AnimationPlayer.play(new_anim)

func set_sprite(selected):
	if selected == 1:
		$Sprite.set_texture(player_tex1)
	elif selected == 2:
		$Sprite.set_texture(player_tex2)
