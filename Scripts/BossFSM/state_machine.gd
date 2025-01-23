extends Node

var current_state : BossState
var states: Dictionary = {}

@export var init_state: BossState

func _ready() -> void:
	for child in get_children():
		if child is BossState:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transitioned)
			print('one')
			
	if init_state:
		init_state.enter()
		current_state = init_state
			
func _process(delta: float) -> void:
	if current_state:
		current_state.Update(delta)
		
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.PhysicsUpdate(delta)

func on_child_transitioned(old, new):
	if old != current_state:
		print("What happened in boss?")
		return
		
	var new_state = states.get(new.to_lower())
	
	if !new_state:
		print("You messed up the boss fsm!")
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	
	current_state = new_state
		
