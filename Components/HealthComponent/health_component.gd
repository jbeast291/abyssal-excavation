extends Node2D

signal on_death;

@export var health: int = 10;

func take_damage(amount):
	health -= amount
	if health <= 0:
		on_death.emit()
