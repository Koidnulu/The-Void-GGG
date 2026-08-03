extends State

class_name follow_eyery

# just means it shows up in the inspector panel
@export var move_speed := 20
# generic so all enemies can use it
@export var enemy: CharacterBody2D
@export var sprite: AnimatedSprite2D

# remember : is type. = is the actual value. right now its declaring it
@onready var player := $"../../../main_character"

func physics_update(delta: float):
	sprite.play("idle")
	if player == null:
		player = get_tree().get_first_node_in_group("main_character") 
		return
	if enemy == null:
		enemy = get_tree().get_first_node_in_group("eyery") 
		return
	var direction = (player.global_position - enemy.global_position).normalized()
	var distance = (player.global_position - enemy.global_position).length()
	if distance < 80:
		state_machine.change_state("attack_eyery")
		return
	enemy.velocity = direction * move_speed
	enemy.move_and_slide()
