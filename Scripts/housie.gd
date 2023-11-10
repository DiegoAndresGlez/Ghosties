extends CharacterBody2D

@onready var anim := $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	anim.play("idle")
	
	pass

func _on_hitbox_component_area_entered(area):
	var object = area.get_parent()
	if object is Player:
		print("entered")
		object.can_fade = true


func _on_hitbox_component_area_exited(area):
	var object = area.get_parent()
	if object is Player:
		print("exited")
		object.can_fade = false
