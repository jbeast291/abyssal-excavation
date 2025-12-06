extends State

@onready var ambient_light: BackBufferCopy = %AmbientLight

func enter() -> void:
	ambient_light.modulate = Color(3.592, 1.83, 4.638, 1.0)

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
