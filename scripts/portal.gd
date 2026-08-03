extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		if body.just_teleported:
			return
		body.just_teleported = true
		body.global_position = $"destination point".global_position
		$AudioStreamPlayer2D.play()
		await get_tree().create_timer(0.5).timeout
		body.just_teleported = false

func _on_body_exited(body: Node2D) -> void:
	if body.name == "CharacterBody2d":
		body.just_teleported = false
