extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BlackFade.fade_out()
	Dialogic.signal_event.connect(_on_dialogic_signal)


func _on_dialogic_signal(argument: String):
	if argument == "switch level 1":
		Dialogic.end_timeline()
		await Dialogic.timeline_ended
		get_tree().change_scene_to_file("res://scenes/game.tscn")
	if argument == "game over":
		Dialogic.end_timeline()
		await Dialogic.timeline_ended
		Dialogic.VAR.reset()
		get_tree().change_scene_to_file("res://scenes/main_screen.tscn")
