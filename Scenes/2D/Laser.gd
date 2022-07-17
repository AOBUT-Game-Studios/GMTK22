extends Node2D

func enabled(tf):
	for x in get_child_count() - 1:
		get_child(x).emitting = tf
	$Hitbox.monitoring = tf
		

func _on_Hitbox_body_entered(body):
	if body.name == "Player":
		body.take_damage(1)
