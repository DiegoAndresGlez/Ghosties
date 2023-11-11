extends CharacterBody2D

class_name Ghosty

@onready var projectile_scene = preload("res://Scenes/projectile.tscn")
@onready var SPEED = 300.0
@onready var anim := $AnimatedSprite2D
@onready var projectiles_pool := get_parent().get_node("ProjectilesPool")
var target = position

@export var alpha_value := 255.0
@export var target_value := 80.0
var decrement_speed = 10  # Adjust the decrement speed as needed
var can_fade := false

@onready var enemy_target := get_parent().get_node("Enemy")
@onready var can_shoot := true
@onready var found_enemy := false
	
func _input(event):
	if event.is_action_pressed("mouse_click"):
		target = get_global_mouse_position()

func _process(delta):
	if can_fade:
		fade_out(delta)
	else:
		fade_in(delta)

func _physics_process(delta):
	if found_enemy:
		velocity = Vector2()
	else:
		velocity = position.direction_to(target) * SPEED
		if position.distance_to(target) > 10:
			move_and_slide()
	
	if can_shoot:
		shoot(delta)
		
func shoot(delta):		
	var shot : Projectile
	var shot_direction = enemy_target.global_position - global_position
	var rotation_result = atan2(shot_direction.x, -shot_direction.y)

	shot = projectile_scene.instantiate()
	shot.global_position = global_position
	shot.set_direction(shot_direction)
	projectiles_pool.add_child(shot)
	can_shoot = false
	#shot.global_position += shot_direction.normalized() * SPEED
	
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
	#print(modulate.a)


#make on shooting range area exited to stop shooting
