extends Node

# THE FSM HAS THE FOLLOWING FLOWCHART
# Idle -> seen-> crush_down -> impact -> move_up

@export var initial_state: State
var current_state: State
var states: Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_transition.connect(on_state_transition)
			
	if initial_state:
		initial_state.Enter()
		current_state = initial_state

func _process(delta: float) -> void:
	if current_state:
		current_state.Update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.PhysicsUpdate(delta)

func on_state_transition(old_state: State, new_state_name: String):
	if old_state != current_state:
		print("Mismatch in old and current state what(spike_head)")
	
	var new_state: State = states.get(new_state_name.to_lower())
	
	if !new_state:
		print("The state doesn't exist how(spike_head)")
		
	if current_state:
		current_state.Exit()
	
	new_state.Enter()
	
	current_state = new_state
