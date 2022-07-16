extends RigidBody

export (float) var throw_cooldown_def = 1
export (int) var throw_magnitude = 1000
var throw_cooldown = 0
var rolling = false
var velocity = Vector3()
onready var cam = get_parent().get_node("Camera")

func player_throw():
	if throw_cooldown <= 0:
		#$sphere.disabled = false
		var dropPlane  = Plane(Vector3(0, 1, 0), 0)
		var position3D = dropPlane.intersects_ray(
							 cam.project_ray_origin(get_viewport().get_mouse_position()),
							 cam.project_ray_normal(get_viewport().get_mouse_position()))
		
		var force = (position3D - Vector3(global_transform.origin.x,0,global_transform.origin.z).normalized()) * throw_magnitude
		add_force(force, global_transform.origin)
		
		print(position3D)
		throw_cooldown = throw_cooldown_def
		rolling = true
		
func _physics_process(delta):
	if throw_cooldown <= 0:
		#$sphere.disabled = true
		pass
	throw_cooldown -= delta
	
		
