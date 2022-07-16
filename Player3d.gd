extends KinematicBody

export (float) var speed = 100
export (float) var movement_damp = 10

var active_die = null
var velocity = Vector3()

func _unhandled_input(event):
	pass

func get_input():
	var input_velocity = Vector3()
	
	if Input.is_action_pressed("Up"):
		input_velocity.z -= 1
	if Input.is_action_pressed("Down"):
		input_velocity.z += 1
	if Input.is_action_pressed("Left"):
		input_velocity.x -= 1
	if Input.is_action_pressed("Right"):
		input_velocity.x += 1
	if Input.is_action_just_released("Click") and active_die != null:
		active_die.player_throw()
		
	return input_velocity.normalized() * speed
	
func _physics_process(delta):
	velocity = ((velocity / movement_damp) * (movement_damp - 1)) + (get_input() / movement_damp)
	move_and_slide(velocity) 


func _on_Area_body_entered(body):
	if body.is_in_group("Dice"):
		active_die = body
		print("Dice Enter")

func _on_Area_body_exited(body):
	if active_die == body:
		active_die = null
		print("Dice Exit")
