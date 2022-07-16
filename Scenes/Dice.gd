extends RigidBody2D

export (float) var throw_magnitude = 1100
export (float) var throw_cooldown_def = 1
export (int) var dice_stopping_speed = 200
var dice_val = 0
var rolling = false
var throw_cooldown = 0
var rng = RandomNumberGenerator.new()

func _ready():
	dice_roll()

func player_throw():
	if throw_cooldown <= 0:
		var force = (get_global_mouse_position() - global_position).normalized() * throw_magnitude
		apply_central_impulse(force)
		throw_cooldown = throw_cooldown_def
		rolling = true
		
func dice_roll():
	rng.randomize()
	dice_val = rng.randi_range(1, 6)
	print(dice_val)

func _physics_process(delta):
	if throw_cooldown > 0:
		throw_cooldown -= delta
	if linear_velocity.length() < dice_stopping_speed and rolling and throw_cooldown < 0:
		rolling = false
		linear_velocity = Vector2()
		angular_velocity = 0
		dice_roll()



