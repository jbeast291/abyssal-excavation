class_name StateMachine extends State

@export var initial_state: State;

var current_state: State;
var states: Dictionary[String, State] = {};

func enter() -> void:
	current_state.enter();
	
func exit() -> void:
	current_state.exit();

func _ready() -> void:
	assert(initial_state != null)
	for child in get_children():
		if child is State:
			child.state_machine = self;
			states[child.name.to_lower()] = child;
	if initial_state:
		initial_state.enter();
		current_state = initial_state;

func update(delta: float) -> void:
	if current_state:
		current_state.update(delta);

func physics_update(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta);

func change_state(new_state_name: String) -> void:
	var new_state: State = states.get(new_state_name.to_lower());
	assert(new_state, "State not found: " + new_state_name);
	
	if current_state != null:
		current_state.exit();
	
	new_state.enter();
	
	current_state = new_state;

func get_current_state_path() -> Array[String]:
	var arr: Array[String] = [];
	arr.append(name.to_lower());
	if current_state is StateMachine:
		return arr + current_state.get_current_state_path()
	arr.append(current_state.name.to_lower());
	return arr;

func _list_states() -> void:
	for state in states:
		print(state)
