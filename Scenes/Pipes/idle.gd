extends State

@onready var ambient_light: BackBufferCopy = %AmbientLight
@onready var main_sprite: AnimatedSprite2D = %MainSprite

func enter() -> void:
	main_sprite.play("Active")
	ambient_light.modulate = Color(0.0, 1.0, 0.0, 1.0)

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
