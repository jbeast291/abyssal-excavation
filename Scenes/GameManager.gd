class_name GameManager extends Node2D

static var main: GameManager; 

var current_time: float;
var oil_value: float = 0;
var total_oil_needed: float = 100;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(main==null)
	main = self;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	current_time+=delta;
	pass

func oil_drill() -> void:
	oil_value+=1;
