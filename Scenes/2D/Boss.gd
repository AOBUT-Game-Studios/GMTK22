extends Node2D

onready var tween = $Tween
onready var anim = $AnimationPlayer
onready var body = $Body
onready var right = $Right
onready var left = $Left
onready var iris = $Body/Eye/Iris
onready var player = get_parent().get_node("Player")
export (float) var body_offset = 50
export (float) var right_offset = -100
export (float) var left_offset = 0
export (float) var movement_damp = 10
export (float) var head_bob = 10
export (float) var iris_offset = 5
var count = 0 

func _process(delta):
	idle(delta)


func idle(delta):
	#counter for cos wave
	count += delta * 4
	
	#Body Movement
	body.global_position.x = player.global_position.x / 4 + body_offset + (cos(count) * 2)
	body.global_position.y = body.global_position.y + (cos(count) / 14)

	#Right Hand Follows Body
	right.global_position.x = body.global_position.x / 2 + right_offset + (cos(count) * 2)
	
	#Left Hand Movement
	left.global_position.y = player.global_position.y / 3 + left_offset + (cos(count) * 2)
	
	#iris movement
	iris.position.x = player.position.x / 16
	iris.position.y = player.position.y / 24 + iris_offset
