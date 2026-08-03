extends Node

class_name State

# we made our own statemachine of type statemachine (type like integer, boolean etc)
var state_machine: StateMachine

func enter():
	pass

func exit():
	pass
	
func update(delta: float):
	pass

func physics_update(delta: float):
	pass

func handle_input(event: InputEvent):
	pass
