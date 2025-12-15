class_name GameManager extends Node2D

static var main: GameManager; 

var total_time_seconds: int = 300;
var current_time: float;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(main==null)
	main = self;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	current_time+=delta;
	pass
