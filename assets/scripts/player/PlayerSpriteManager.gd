class_name PlayerSpriteManager extends Node2D

@onready var drill_sprite: AnimatedSprite2D = %DrillSprite

#TODO: remove any bobbing on the players torso from the sprites, its just a limitiation with this method

var legs_player: AnimationPlayer;
var torso_player: AnimationPlayer;
var head_player: AnimationPlayer;

# This is run before _ready so it ensures that these references are valid
func _enter_tree():
	legs_player = %LegsPlayer;
	torso_player = %TorsoPlayer;
	head_player = %HeadPlayer;

# yes i know these are duplicated but may be usefull later...
func play_leg_animation(animation_name: String) -> void:
	legs_player.play(animation_name);
	
func play_torso_animation(animation_name: String) -> void:
	torso_player.play(animation_name);
	
func play_head_animation(animation_name: String) -> void:
	head_player.play(animation_name);

func flip_sprite_h(flip: bool) -> void:
	if flip:
		scale.x = -1;
	else:
		scale.x = 1;
