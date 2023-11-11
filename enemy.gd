extends CharacterBody2D

class_name Enemy

enum EnemyState{
	ATTACK_HOUSIE,
	ATTACK_PLAYER
}

@onready var state = EnemyState.ATTACK_HOUSIE
@export var SPEED = 150.0
@onready var housie := get_parent().get_node("Housie")
@onready var player := get_tree().get_first_node_in_group("Player")
@onready var target := get_tree().get_first_node_in_group("Housie")
@onready var enemy_area := $HitboxComponent
var attack_range := 400.0

func _physics_process(delta):
	match state:
		EnemyState.ATTACK_HOUSIE:
			attack_housie()
		EnemyState.ATTACK_PLAYER:
			attack_player()
	#print(state)
	move_and_slide()

func attack_housie():
	var direction = housie.global_position - global_position
	
	if direction.length() > 25:
		velocity = direction.normalized() * SPEED
	else:
		velocity = Vector2()		
	
	change_states()

func attack_player():
	#TODO: implement attack here
	
	var direction = player.global_position - global_position
	
	if direction.length() > 25:
		velocity = direction.normalized() * SPEED
	else:
		velocity = Vector2()
		
	change_states()

func change_states():
	for e in enemy_area.get_overlapping_areas():
		if e:
			var object = e.get_parent()
			if object is Player:
				state = EnemyState.ATTACK_PLAYER
			elif object is Housie:	 
				state = EnemyState.ATTACK_HOUSIE

func _on_hitbox_component_area_entered(area):
	pass	
