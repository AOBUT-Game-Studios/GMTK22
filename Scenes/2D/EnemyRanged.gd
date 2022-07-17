extends KinematicBody2D

var spear = preload("res://Scenes/2D/Spear.tscn")
onready var player = get_parent().get_node("Player")
export (float) var throw_delta_def = 6
var throw_delta = 4
var color = null
var count = 0
onready var anim = $AnimationPlayer

func _ready():
	anim.play("idle")
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	color = rng.randi_range(0, 2)
	if color == 0:
		$Node2D/Head.frame = 2
	elif color == 1:
		$Node2D/Head.frame = 0
	elif color == 2:
		$Node2D/Head.frame = 1

func _process(delta):
	count += delta
	get_node("Node2D/Arms").position.y += cos(count) / 100
	get_node("Node2D/Body").position.y -= cos(count) / 100
	get_node("Node2D/Head").position.y += cos(count) / 100
	
	
func throw():
	var sper = spear.instance()
	sper.velocity = (player.global_position - global_position).normalized()
	sper.rotation = sper.velocity.angle()
	sper.global_position = global_position
	get_parent().add_child(sper)
	
func death():
	queue_free()
	

