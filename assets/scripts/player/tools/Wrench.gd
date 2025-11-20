class_name Wrench extends Tool

@onready var cell_selector: AnimatedSprite2D = %CellSelector
@onready var wrench_ray_cast: RayCast2D = $WrenchRayCast
@onready var rotate_to_mouse: RotateToMouse = $RotateToMouse
@onready var pipe_node: PipeNode = %PipeNode

func _ready() -> void:
	pass # Replace with function body.

func deactivate() -> void:
	wrench_ray_cast.enabled = false;

func activate() -> void:
	wrench_ray_cast.enabled = true;

func physics_update(delta: float) -> void:
	rotate_to_mouse.physics_update(delta);

func place_pipe() -> void:
	pipe_node.place_pipe(self)
