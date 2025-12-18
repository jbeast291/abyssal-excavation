class_name GameManager extends Node2D

static var main: GameManager; 

var time_left_seconds: float = 600;
var current_time: float;

var oil_value: float = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(main==null)
	main = self;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	current_time+=delta;
	time_left_seconds-=delta;
	pass

func oil_drill() -> void:
	oil_value+=1;
