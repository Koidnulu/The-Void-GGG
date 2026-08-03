extends Area2D
@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	timer.start()
	
func _on_timer_timeout() -> void:
	var current_timeline = Dialogic.current_timeline
	var current_line = Dialogic.current_event_idx
	Dialogic.end_timeline(true)
	await get_tree().process_frame
	$"../main_character".global_position = Vector2(57, 37)
	var layout = Dialogic.Styles.load_style("res://styles/text_bubble.tres")
	layout.register_character(load("res://characters for dialogic/eyere.dch"), $"../eyery")
	layout.register_character(load("res://characters for dialogic/protag.dch"), $"../main_character")
	Dialogic.preload_timeline("you died")
	Dialogic.start("you died")
	await Dialogic.timeline_ended
	if current_timeline != null:
		Dialogic.start_timeline(current_timeline, current_line)
