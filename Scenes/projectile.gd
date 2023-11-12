extends Node2D

class_name Projectile

@export var attack_damage := 4.0
@export var knockback_force := 0.5
@export var stun_time := 1.5
@export var SPEED := 50.0
@export var knockback_rng := 0.10

var shot_direction : Vector2
@onready var despawn := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if despawn:
		despawn_on_collision()

func _physics_process(delta):
	global_position += shot_direction.normalized() * SPEED
	pass

func set_direction(new_target):
	shot_direction = new_target

#despawn when colliding with Enemy
func despawn_on_collision():
	queue_free()

func _on_despawn_timer_timeout():
	queue_free()

func _on_hitbox_component_area_entered(area):
	randomize()
	if area.has_method("damage"):
		var hitbox : HitboxComponent = area
		
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		attack.knockback_force = knockback_force
		attack.stun_time = stun_time
		attack.projectile_direction = shot_direction
		
		area.damage(attack)
		
		var kb_rng = randf_range(0.0, 1.0)
		if kb_rng <= knockback_rng:
			area.knockback(attack)
			area.stun(attack)
		
		queue_free()
