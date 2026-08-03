extends Node2D

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var hearts_bar: HBoxContainer = canvas_layer.get_node("HBoxContainer")
@onready var eyery: CharacterBody2D = $eyery

var eyery_game_over : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hearts_bar.player_died.connect(player_has_died)
	eyery.eyery_died.connect(player_won)

func player_has_died():
	if eyery_game_over:
		return
	eyery_game_over = true
	await get_tree().create_timer(1).timeout
	Dialogic.start("died boss fight")
	await Dialogic.timeline_ended
	get_tree().reload_current_scene()

func player_won():
	if eyery_game_over:
		return
	eyery_game_over = true
	var layout = Dialogic.Styles.load_style("res://styles/text_bubble.tres") 
	layout.register_character(load("res://characters for dialogic/protag.dch"), $main_character)
	Dialogic.start("won eyery")
	await Dialogic.timeline_ended
