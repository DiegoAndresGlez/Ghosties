extends CharacterBody2D
class_name Player

@export var SPEED = 400.0
@onready var anim = $AnimatedSprite2D

var amplitude = 50  # Amplitude of the sine wave
var frequency = 2   # Frequency of the sine wave

@export var alpha_value := 255.0
@export var target_value := 80.0
var decrement_speed = 10  # Adjust the decrement speed as needed
var can_fade := false

func _process(delta):
	if can_fade:
		fade_out(delta)
	else:
		fade_in(delta)
	pass

func _physics_process(delta):
	get_input(delta)
	change_sprite()

func get_input(delta):
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = input_direction * SPEED
	move_and_slide()

func change_sprite():
	if velocity.x < 0:
		anim.flip_h = true
	elif velocity.x > 0:
		anim.flip_h = false
		
func fade_out(delta):
	if modulate.a >= 0.4:
		modulate.a -= 3 * delta
	#print(modulate.a)

func fade_in(delta):
	if modulate.a <= 1:
		modulate.a += 3 * delta
	print(modulate.a)

func _on_fade_timer_timeout():
	pass # Replace with function body.
