class_name PipeNode extends Area2D

@onready var pipe_state_manager: StateMachine = %PipeStateManager
@onready var placement: Node = %Placement

var placement_raycast: RayCast2D;

var parent: PipeNode;
var connected_children: Array[PipeNode] = [];


func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	self.global_rotation = 0;
	pipe_state_manager.physics_update(delta);

func place_pipe(pipe_manager: Node2D) -> void:
	placement.place(pipe_manager);
	
