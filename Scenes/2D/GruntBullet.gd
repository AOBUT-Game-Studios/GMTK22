extends Area2D

var velocity = Vector2()
export (int) var speed = 3

func _process(delta):
	global_position += velocity * speed


func _on_GruntBullet_body_entered(body):
	if body.name == "Player":
		body.damage(1)
	queue_free()
