extends Control

func _on_back_pressed() -> void:
	$"button sound".play()
	await get_tree().create_timer(0.4).timeout
	get_tree().change_scene_to_file("res://scenes/main_screen.tscn")
