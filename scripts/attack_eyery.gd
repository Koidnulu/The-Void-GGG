extends State

class_name attack_eyery

var boss: CharacterBody2D
var character: AnimatedSprite2D
@onready var player := $"../../../main_character"
var is_attacking := false;
@onready var flipping: Node2D = $"../../flipping"

func enter() -> void:
	# does not hard code names bcs it just grabs the top as boss, find child of
	# boss that is animated sprite 2d which corresponds to character
	boss = owner as CharacterBody2D
	character = boss.get_node("flipping/AnimatedSprite2D") as AnimatedSprite2D
	while(true):
		is_attacking = true
		character.play("hurt")
		await character.animation_finished
		is_attacking = false
		await get_tree().create_timer(4).timeout

func physics_update(delta: float):
	var distance = (player.global_position - boss.global_position).length()
	var direction = (player.global_position - boss.global_position).normalized()
	if direction.x > 0:
		flipping.scale.x = 1;
	elif direction.x < 0:
		flipping.scale.x = -1;
	if distance > 80 and get_tree().current_scene.name  == "battle eyery":
		state_machine.change_state("follow_eyery")
