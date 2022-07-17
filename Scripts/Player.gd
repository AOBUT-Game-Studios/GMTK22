extends KinematicBody2D

onready var Dice = preload("res://Scenes/2D/Dice.tscn")

export (float) var speed = 100
export (float) var movement_damp = 10
export (int) var life_points = 3

var active_die = null
var velocity = Vector2()
var stored_die = null
export (bool) var invincible = false
var input = true
var walk_delta = 0.1
var walk_delta_def = 0.1

onready var anim = $AnimationPlayer
onready var tween = $Tween

func _unhandled_input(event):
	pass
	
func _ready():
	invincible = false
	$ComboDice.visible = false

func get_input():
	var input_velocity = Vector2()
	input = false
	
	if Input.is_action_pressed("Up"):
		input_velocity.y -= 1
		input = true
	if Input.is_action_pressed("Down"):
		input_velocity.y += 1
		input = true
	if Input.is_action_pressed("Left"):
		input_velocity.x -= 1
		$Sprite.flip_h = true
		input = true
	if Input.is_action_pressed("Right"):
		input_velocity.x += 1
		$Sprite.flip_h = false
		input = true
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
		elif active_die != null and stored_die != null:
			combo_attack(stored_die, active_die.dice_val)

	return input_velocity.normalized() * speed
	
func _physics_process(delta):
	velocity = ((velocity / movement_damp) * (movement_damp - 1)) + (get_input() / movement_damp)
	move_and_slide(velocity)
	
	if input:
		walk_delta -= delta
		if walk_delta <= 0:
			walk_delta = walk_delta_def
			
			if $Sprite.frame_coords.x == 1:
				$Sprite.frame_coords.x = 0
			else:
				$Sprite.frame_coords.x = 1
	
	if !input:
		walk_delta = walk_delta_def
		$Sprite.frame_coords.x = 0
		
	if stored_die == null:
		$Sprite.frame_coords.y = 0
	elif stored_die == 0:
		$Sprite.frame_coords.y = 3
	elif stored_die == 1:
		$Sprite.frame_coords.y = 2
	elif stored_die == 2:
		$Sprite.frame_coords.y = 1
	
	
func take_damage(damage):
	if !invincible:
		life_points -= damage
		anim.play("Invincibility")
		
	if life_points <= 0:
		game_over()
		
func combo_attack(dice1, dice2):
	#0 : blue
	#1 : Red
	#2 : Yellow
	tween.interpolate_property(self, "global_position:y",
		global_position.y, global_position.y + 10, 0.5,
		Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.start()
	get_node("ComboDice/ComboDie").frame_coords.x = dice1
	get_node("ComboDice/ComboDie2").frame_coords.x = dice2
	anim.play("Combo")
	if dice1 == 0 and dice2 == 0:
		#blue
		pass
	elif dice1 == 1 and dice2 == 1:
		#Red
		pass
	elif dice1 == 2 and dice2 == 2:
		#Yellow
		pass
	elif dice1 == 0 and dice2 == 2 or dice1 == 2 and dice2 == 0:
		#Green
		pass
	elif dice1 == 0 and dice2 == 1 or dice1 == 1 and dice2 == 0:
		#Purple
		pass
	elif dice1 == 1 and dice2 == 2 or dice1 == 2 and dice2 == 1:
		#Orange
		pass

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
