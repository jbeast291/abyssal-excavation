class_name PipeManager extends Node2D

@export var root_node: PipeNode;

static var main: PipeManager;

func _ready() -> void:
	assert(root_node!=null);
	main = self;

func update_network() -> void:
	var to_check: Array[PipeNode] = [root_node]
	var visited: Array[PipeNode] = []

	while to_check.size() > 0:
		var current = to_check.pop_back();

		if visited.has(current):
			continue;
		visited.append(current)

		current.activate_pipe();

		for connected_pipe in current.connected_pipes:
			if !visited.has(connected_pipe):
				to_check.append(connected_pipe);
