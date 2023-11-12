extends Node2D

class_name HealthComponent

@export var MAX_HEALTH := 100.0
var health : float

func _ready():
	health = MAX_HEALTH
	pass # Replace with function body.

func damage(attack: Attack):
	health -= attack.attack_damage
	
	if health <= 0:
		get_parent().queue_free()	

func knockback(attack: Attack):
	get_parent().global_position += attack.projectile_direction * attack.knockback_force

func stun(attack: Attack):
	var stun_timer : Timer
	stun_timer = get_parent().get_node("StunTimer")
	stun_timer.start()
	get_parent().stunned = true

func _on_stun_timer_timeout():
	get_parent().stunned = false
