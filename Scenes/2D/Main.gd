extends Node2D

var enemy = load("res://Scenes/2D/EnemyRanged.tscn")
var current_enemy

func _on_SpawnTimer_timeout():
	current_enemy = enemy.instance()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var val = rng.randi_range(0, 6)
	current_enemy.position = get_node("Spawners").get_child(val).global_position
	add_child(current_enemy)
