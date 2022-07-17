extends KinematicBody2D

var speed = 200
var velocity = Vector2()

func _physics_process(delta):
	move_and_slide(velocity * speed)

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.take_damage(1)
	queue_free()
