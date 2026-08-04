extends Area2D
@onready var timer: Timer = $Timer
@onready var main_character: CharacterBody2D = $"../main_character"

# prevents the dying dialogue from triggering multiple times
var is_dying : bool = false
	
func _on_body_entered(body: Node2D) -> void:
	timer.start()
	
func _on_timer_timeout() -> void:
	if is_dying:
		return
	var current_timeline = Dialogic.current_timeline
	var current_line = Dialogic.current_event_idx
	Dialogic.end_timeline(true)
	await get_tree().process_frame
	$"../main_character".global_position = Vector2(57, 37)
	var layout = Dialogic.Styles.load_style("res://styles/text_bubble.tres")
	if layout.has_method("clear_character_registrations"):
		layout.clear_character_registrations()
	layout.register_character(load("res://characters for dialogic/eyere.dch"), $"../eyery")
	layout.register_character(load("res://characters for dialogic/protag.dch"), $"../main_character")
	Dialogic.preload_timeline("you died")
	main_character.get_node("StateMachine").current_state.can_move = false
	Dialogic.start("you died")
	await Dialogic.timeline_ended
	main_character.get_node("StateMachine").current_state.can_move = true
	if current_timeline != null:
		Dialogic.start_timeline(current_timeline, current_line)
	is_dying = false
