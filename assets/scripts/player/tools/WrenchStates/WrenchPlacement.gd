extends State

@onready var wrench: Wrench = %Wrench
@onready var held_pipe_node: PipeNode;

func enter() -> void:
	create_pipe_node_on_tool();
	pass

func exit() -> void:
	
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func on_primary_interact_just_pressed() -> void:
	if (held_pipe_node.attempt_place_pipe(player.pipe_holder)):
		held_pipe_node = null;
		create_pipe_node_on_tool();

func create_pipe_node_on_tool() -> void:
	assert(held_pipe_node == null);
	
	held_pipe_node = wrench.PIPE_NODE.instantiate();
	held_pipe_node.physics_interpolation_mode = Node.PHYSICS_INTERPOLATION_MODE_OFF
	wrench.placement_holder.add_child(held_pipe_node);
	held_pipe_node.physics_interpolation_mode = Node.PHYSICS_INTERPOLATION_MODE_ON
