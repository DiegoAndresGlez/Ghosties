extends Node2D

class_name Projectile

@export var SPEED := 50.0
var shot_direction : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	global_position += shot_direction.normalized() * SPEED
	pass

func set_direction(new_target):
	shot_direction = new_target

func _on_despawn_timer_timeout():
	queue_free()
