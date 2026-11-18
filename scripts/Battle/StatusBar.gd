class_name StatusBar
extends Control

@export var Animator : AnimationPlayer
@export var is_opponent : bool = true
@export var health_bar : ProgressBar

var health_component : Health

func _ready() -> void:
	Animator.play("opponent_enter" if is_opponent else "player_enter")
	
func setup(health : Health) -> void:
	health_component = health
		
