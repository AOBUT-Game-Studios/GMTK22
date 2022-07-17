extends Node2D

var enemy = load("res://Scenes/2D/Enemy.tscn")
var current_enemy
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SpawnTimer_timeout():
	current_enemy = enemy.instance()
	current_enemy.position = get_node("Spawn1").position
	add_child(current_enemy)
