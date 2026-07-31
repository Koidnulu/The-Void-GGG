extends State

class_name idle_eyery

var boss: CharacterBody2D
var character: AnimatedSprite2D

func enter() -> void:
	# does not hard code names bcs it just grabs the top as boss, find child of
	# boss that is animated sprite 2d which corresponds to character
	boss = owner as CharacterBody2D
	character = boss.get_node("AnimatedSprite2D") as AnimatedSprite2D
	character.play("idle")
	
func physics_update(delta: float) -> void:
	if get_tree().current_scene.name == "battle eyery":
		state_machine.change_state("follow_eyery")
