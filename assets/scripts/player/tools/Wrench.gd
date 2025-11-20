class_name Wrench extends Tool

@onready var cell_selector: AnimatedSprite2D = %CellSelector
@onready var wrench_ray_cast: RayCast2D = $WrenchRayCast
@onready var rotate_to_mouse: RotateToMouse = $RotateToMouse
@onready var pipe_node: PipeNode;
@onready var player: Player = $"../.."

const PIPE_NODE = preload("uid://3e7qcikegg3y")

var pipe_previous: PipeNode;
var pipes_children: Array[PipeNode];

func _ready() -> void:
	create_pipe_node_on_tool();
	pass # Replace with function body.

func deactivate() -> void:
	self.visible = false;
	wrench_ray_cast.enabled = false;

func activate() -> void:
	self.visible = true;
	wrench_ray_cast.enabled = true;

func physics_update(delta: float) -> void:
	rotate_to_mouse.physics_update(delta);
	placement_distance_handle();

func placement_distance_handle() -> void:
	var distance: float = self.global_position.distance_to(get_global_mouse_position());
	distance = clamp(distance, 5.0, 30.0);
	pipe_node.position.x = distance;

func on_primary_interact_just_pressed() -> void:
	if (pipe_node.attempt_place_pipe(player.pipe_holder)):
		pipe_node = null;
		create_pipe_node_on_tool();

func create_pipe_node_on_tool() -> void:
	assert(pipe_node == null);
	
	pipe_node = PIPE_NODE.instantiate();
	pipe_node.physics_interpolation_mode = Node.PHYSICS_INTERPOLATION_MODE_OFF
	self.add_child(pipe_node);
	placement_distance_handle();
	pipe_node.physics_interpolation_mode = Node.PHYSICS_INTERPOLATION_MODE_ON
