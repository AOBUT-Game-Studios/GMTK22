extends RigidBody2D

export (float) var throw_magnitude = 1100
export (float) var throw_cooldown_def = 1
export (int) var dice_stopping_speed = 400
var dice_val = 0
var current_color
var rolling = false
var throw_cooldown = 0
var rng = RandomNumberGenerator.new()
var attractable = false

func _ready():
	dice_roll(null)

func player_throw():
	if throw_cooldown <= 0:
		var force = (get_global_mouse_position() - global_position).normalized() * throw_magnitude
		apply_central_impulse(force)
		linear_damp = 1
		throw_cooldown = throw_cooldown_def
		rolling = true
		
func dice_roll(color):
	if color:
		dice_val = color
		current_color = null
	else:
		rng.randomize()
		dice_val = rng.randi_range(1, 3)
	print(dice_val)

func _physics_process(delta):
	if throw_cooldown > 0:
		throw_cooldown -= delta
		linear_damp += delta
	elif rolling:
		linear_damp += delta * 20
		
	if linear_velocity.length() < dice_stopping_speed and rolling and throw_cooldown < 0:
		rolling = false
		linear_velocity = Vector2()
		angular_velocity = 0
		dice_roll(current_color)
		linear_damp = 1

func _on_Hitbox_body_entered(body):
	if body.is_in_group("enemy") and rolling:
		linear_velocity = -linear_velocity / 3
		angular_velocity = angular_velocity / 3
		current_color = body.color
		body.death()
