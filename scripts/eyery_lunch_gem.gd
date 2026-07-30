extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "main_character":
		Dialogic.VAR.set_variable("eyery_lunch", true)
		queue_free()
