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
var attack_cooldown = 5
var idle = true
var body_idle = true
var left_idle = true
var right_idle = true
var rng = RandomNumberGenerator.new()
var attacks = [
	"Rapid Fire Laser Track",
	"Rapid Fire Laser LR",
	"Rapid Fire Laser RL",
	"Laser Sweep L"
]

func _process(delta):
	
	attack_cooldown -= delta
	count += delta * 4
	
	if attack_cooldown <= 0:
		rng.randomize()
		var val = rng.randi_range(0, 3)
		right.get_node("AnimationPlayer").play(attacks[val])
		attack_cooldown = 10

	idle()

func idle():
	#counter for cos wave
	
	#Body Movement
	if body_idle:
		body.global_position.x = player.global_position.x / 4 + body_offset + (cos(count) * 2)
		body.global_position.y = body.global_position.y + (cos(count) / 14)

	#Left Hand Movement
	if left_idle:
		left.global_position.y = player.global_position.y / 3 + left_offset + (cos(count) * 2)
	
	#iris movement
	iris.position.x = player.position.x / 16
	iris.position.y = player.position.y / 24 + iris_offset
	

	

	
	
