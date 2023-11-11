extends Node2D

#TODO Change to shoot to nearest
@onready var enemy := $Enemy
@onready var shot_scene := preload("res://Scenes/projectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func shoot():
	pass
