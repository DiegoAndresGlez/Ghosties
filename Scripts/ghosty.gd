extends CharacterBody2D

class_name Ghosty

@onready var projectile_scene = preload("res://Scenes/projectile.tscn")
@onready var SPEED = 300.0
@onready var anim := $AnimatedSprite2D
@onready var firerate := $Firerate
@onready var projectiles_pool := get_tree().get_first_node_in_group("ProjectilesPool")
@onready var shooting_range := $ShootingRange
var target = position
var can_fade := false

@onready var enemy_target := get_tree().get_first_node_in_group("Enemy")
@onready var can_shoot := true
@onready var found_enemy := false

@export var accuracy := 0.05

var enemies_in_range : Array[Enemy]

func _ready():
	pass
	
func _input(event):
	if event.is_action_pressed("mouse_click"):
		target = get_global_mouse_position()

func _process(delta):
	if can_fade:
		fade_out(delta)
	else:
		fade_in(delta)
	change_sprite()
	choose_enemy_to_shoot()

func _physics_process(delta):
	if found_enemy:
		velocity = Vector2()
	else:
		velocity = position.direction_to(target) * SPEED
		if position.distance_to(target) > 10:
			move_and_slide()
	
	if can_shoot:
		shoot(accuracy, delta)

#chooses which enemy to shoot, enemy should attack ghost first then to housie
func choose_enemy_to_shoot():
	pass
	
		
func shoot(accuracy : float, delta : float):
	randomize()
	#print(enemies_in_range)
	
	#if there are enemies in range get the first who entered
	if not enemies_in_range.is_empty():
		enemy_target = enemies_in_range.front()
	else:
		enemy_target = null
	
	#if there is an enemy in range
	if enemy_target:
		var shot : Projectile
		var shot_direction = enemy_target.global_position - global_position
		
		#add inaccuracy
		var rot = randf_range(-accuracy, accuracy)
		shot_direction = shot_direction.rotated(rot)
		
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
func _on_firerate_timeout():
	can_shoot = true


func _on_shooting_range_area_entered(area):
	#print("entered")
	var object = area.get_parent()
	if object is Enemy:
		#print(object)
		enemies_in_range.append(object)

func _on_shooting_range_area_exited(area):
	#print("exited")
	var object = area.get_parent()
	if object:
		if enemies_in_range.has(object):
			enemies_in_range.erase(object)
