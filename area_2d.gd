extends Area2D

signal hit

func _on_body_entered(body):
	if body.name == "Link":
		emit_signal("hit", body)
		queue_free()  # Remove a bullet ao atingir o Link
