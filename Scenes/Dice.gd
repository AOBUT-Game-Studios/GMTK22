extends RigidBody2D

export (float) var throw_magnitude = 1000
export (float) var throw_cooldown_def = 1

var throw_cooldown = 0

func player_throw():
	if throw_cooldown <= 0:
		var force = (get_global_mouse_position() - global_position).normalized() * throw_magnitude
		apply_central_impulse(force)
		throw_cooldown = throw_cooldown_def

func _physics_process(delta):
	if throw_cooldown > 0:
		throw_cooldown -= delta

