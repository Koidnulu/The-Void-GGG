extends Control

func _on_start_pressed() -> void:
	$"button sound".play()
	await get_tree().create_timer(0.4).timeout
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_about_pressed() -> void:
	$"button sound".play()
	await get_tree().create_timer(0.4).timeout
	get_tree().change_scene_to_file("res://scenes/about_page.tscn")
	
func _on_control_menu_pressed() -> void:
	$"button sound".play()
	await get_tree().create_timer(0.4).timeout
	get_tree().change_scene_to_file("res://scenes/control_menu.tscn")
