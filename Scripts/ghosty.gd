extends CharacterBody2D

@onready var SPEED = 300.0
@onready var anim = $AnimatedSprite2D
var target = position
	
func _input(event):
	if event.is_action_pressed("mouse_click"):
		target = get_global_mouse_position()

func _physics_process(delta):
	velocity = position.direction_to(target) * SPEED
	
	if position.distance_to(target) > 10:
		move_and_slide()
		
func change_sprite():
	if velocity.x < 0:
		anim.flip_h = true
	elif velocity.x > 0:
		anim.flip_h = false
	
