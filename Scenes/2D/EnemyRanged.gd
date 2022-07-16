extends KinematicBody2D

var Bullet = preload("res://Scenes/2D/GruntBullet.tscn")
onready var player = get_parent().get_node("Player")
export (float) var shot_delta_def = 5
var shot_delta = shot_delta_def

func _physics_process(delta):
	shot_delta -= delta
	if shot_delta <= 0:
		shoot_bullet()
		shot_delta = shot_delta_def

func shoot_bullet():
	var bullet = Bullet.instance()
	get_parent().add_child(bullet)
	bullet.global_position = global_position
	bullet.velocity = ((player.global_position - global_position).normalized())
