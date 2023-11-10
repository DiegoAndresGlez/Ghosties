extends Node2D

@onready var ghosty_scene = preload("res://Scenes/Ghosty.tscn")
@onready var ghosties_pool = $GhostiesPool

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawn_ghosties()
	pass


func spawn_ghosties():
	var mouse_pos = get_global_mouse_position()
	if Input.is_action_just_pressed("mouse_right_click"):
		if ghosty_scene.can_instantiate():
			var ghosty = ghosty_scene.instantiate()
			ghosty.global_position =  mouse_pos 
			ghosties_pool.add_child(ghosty)
	
	
