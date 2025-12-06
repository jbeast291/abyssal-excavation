class_name PipeNode extends Area2D

@onready var pipe_state_manager: StateMachine = %PipeStateManager
@onready var placement: Node = %Placement
@onready var hover: Node = %Hover
@onready var idle: State = %Idle
@onready var rotation_scale_point: Node2D = %RotationScalePoint
@onready var pipe_drag_collision_check: RayCast2D = %PipeDragCollisionCheck

var placement_raycast: RayCast2D;

var parent: PipeNode;

var is_drag_pipe: bool = false;
var drag_point: Node2D;

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	self.global_rotation = 0;
	pipe_state_manager.physics_update(delta);
	if(is_drag_pipe):
		handle_drag_point();

func attempt_place_pipe(pipe_manager: Node2D) -> bool:
	return placement.attempt_place(pipe_manager);

func hoverPipe() -> bool:
	pipe_state_manager.change_state(hover.name)
	return true;

func unhoverPipe() -> bool:
	pipe_state_manager.change_state(idle.name)
	return true;

func handle_drag_point() -> void:
	var pipe_scale: float = self.position.distance_to(drag_point.global_position);
	rotation_scale_point.scale.x = pipe_scale;
	rotation_scale_point.look_at(drag_point.global_position);
	if(!is_drag_valid()):
		rotation_scale_point.modulate = Color(2.43, 0.0, 0.0);
	else:
		rotation_scale_point.modulate = Color.WHITE

func start_pipe_connect(obj: Node2D) -> void:
	is_drag_pipe = true;
	pipe_drag_collision_check.enabled = true;
	drag_point = obj;

func update_drap_point(obj: Node2D) -> void:
	drag_point = obj;

func finish_pipe_connect(end_pipe: PipeNode) -> void:
	is_drag_pipe = false;
	drag_point = end_pipe;
	pipe_drag_collision_check.enabled = false;
	parent = end_pipe;
	handle_drag_point();#one last time to make sure :fingers_crossed:

func cancel_pipe_connect() -> void:
	is_drag_pipe = false;
	drag_point = self;
	pipe_drag_collision_check.enabled = false;
	handle_drag_point();

func is_drag_valid() -> bool:
	return !pipe_drag_collision_check.is_colliding()
