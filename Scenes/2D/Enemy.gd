extends KinematicBody2D

export (float) var attack_distance = 100
export (float) var attack_cooldown = 3
export (float) var attack_time = 0.75
export (float) var attack_speed = 125
export (float) var wander_speed = 25
var attack_delta  = 0
var color = null
var wander_direction = 1
var attacking = false
var velocity = Vector2()
onready var player = get_parent().get_node("Player")
onready var anim = $AnimationPlayer

func _ready():
	change_wander()
	
func change_wander():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var val = rng.randi_range(1, 2)
	if val == 1:
		wander_direction = -1
	elif val == 2:
		wander_direction = 1

func _physics_process(delta):
	
	
	attack_delta -= delta
	if attack_delta < attack_cooldown - attack_time :
		attacking = false
	
	if (player.global_position - global_position).length() < attack_distance and !attacking and attack_delta <= 0:
		attack_init()
	elif !attacking:
		wander()
	
	move_and_slide(velocity)
	
func attack_init():
	attacking = true
	attack_delta = attack_cooldown
	velocity = (player.global_position - global_position).normalized() * attack_speed
	
func wander():
	var player_vector = (player.global_position - global_position).normalized()
	velocity = (player_vector + (player_vector.rotated(90) * wander_direction)).normalized() * wander_speed

func death():
	queue_free()
	print("death")

func _on_Hitbox_body_entered(body):
	if body.name == "Player":
		body.take_damage(1)
