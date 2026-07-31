extends Node

# this is our class, or rather, how a statemachine should behave. see it as a blueprint
# later could change the states to whatever custom
class_name StateMachine

# state is just a variable of our class declared
@export var initial_state: State
var current_state: State
var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			# adding the child to the dictionary
			states[child.name.to_lower()] = child
			child.state_machine = self
			
	# sets to intitial state immediately on ready
	if initial_state:
		change_state(initial_state.name.to_lower())
		
	pass

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)
	pass

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)
	pass

func _input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)
	pass
 
func change_state(new_state_name : String) -> void:
	
	# exiting out old state and changing now
	if current_state:
		current_state.exit()
	
	current_state = states.get(new_state_name.to_lower())
	
	if current_state:
		current_state.enter()
