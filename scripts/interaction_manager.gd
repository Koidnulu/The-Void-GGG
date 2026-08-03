extends Node


@export var interaction_database : Dictionary = {
	"tv": "tv",
	"going_back": "going back level 1",
	"gem_container": "gem container",
	"fake_chest": "fake chest",
	"lamp_key": "lamp key"
}

func trigger_interaction(dialogue_key: String):
	# to ensure it's not interrupting another dialogue
	if Dialogic.current_timeline != null:
		return
	
	if interaction_database.has(dialogue_key):
		var target_timeline = interaction_database[dialogue_key]
		Dialogic.start(target_timeline)
	else:
		print("Timeline not found.")

func dialogue_layout(player_node: Node2D):
	var layout = Dialogic.Styles.load_style("res://styles/text_bubble.tres") 
	layout.register_character(load("res://characters for dialogic/protag.dch"), player_node)
