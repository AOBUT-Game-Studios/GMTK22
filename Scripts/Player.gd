extends KinematicBody2D

onready var Dice = preload("res://Scenes/2D/Dice.tscn")

export (float) var speed = 100
export (float) var movement_damp = 10
export (int) var life_points = 3

var active_die = null
var velocity = Vector2()
var stored_die = null
export (bool) var invincible = false

onready var anim = $AnimationPlayer

func _unhandled_input(event):
	pass

func get_input():
	var input_velocity = Vector2()
	
	if Input.is_action_pressed("Up"):
		input_velocity.y -= 1
	if Input.is_action_pressed("Down"):
		input_velocity.y += 1
	if Input.is_action_pressed("Left"):
		input_velocity.x -= 1
	if Input.is_action_pressed("Right"):
		input_velocity.x += 1
	if Input.is_action_just_released("Click"):
		if active_die != null:
			active_die.player_throw()
		elif stored_die != null:
			stored_die = null
			var dice = Dice.instance()
			get_parent().add_child(dice)
			dice.global_position = global_position
			dice.player_throw()
			
			
	if Input.is_action_just_released("RightClick") and active_die != null:
		if active_die != null and stored_die == null:
			stored_die = active_die.dice_val
			active_die.queue_free()
			active_die = null
			
	return input_velocity.normalized() * speed
	
func _physics_process(delta):
	velocity = ((velocity / movement_damp) * (movement_damp - 1)) + (get_input() / movement_damp)
	move_and_slide(velocity) 
	
func take_damage(damage):
	if !invincible:
		life_points -= damage
		anim.play("Invincibility")
		
	if life_points <= 0:
		game_over()
	
func game_over():
	print("Dead")

func _on_dice_entered(body):
	if body.is_in_group("Dice"):
		active_die = body
		print("Dice Enter")

func _on_dice_exited(body):
	if active_die == body:
		active_die = null
		print("Dice Exit")
