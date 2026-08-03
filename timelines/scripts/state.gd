extends Node

class_name State

# we made our own statemachine of type statemachine (type like integer, boolean etc)
# now any states that extend this would have this variable (we use the same state machine)
# the same state machine is okay because the state machine is really just there to 
# switch states, and since this is the same for all types of characters, the only
# unique thing is really just the states
var state_machine: StateMachine

# this functions as a template for all other states, we need to make a state_machine 

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
