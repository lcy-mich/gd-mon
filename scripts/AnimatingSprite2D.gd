class_name AnimatingSprite2D
extends Sprite2D

@export var framerate : float = 5
@export var totalframes : int = 1
@export var looped : bool = true

var FrameTimer : Timer

func _ready() -> void:
	FrameTimer = Timer.new()
	add_child(FrameTimer)
	FrameTimer.wait_time = 1/framerate
	
	@warning_ignore("return_value_discarded")
	FrameTimer.connect("timeout", animate)
	
	@warning_ignore("return_value_discarded")
	connect("visibility_changed", on_visibility_changed)
	
	on_visibility_changed()

func on_visibility_changed() -> void:
	if is_visible_in_tree():
		frame = 0
		FrameTimer.start()
		return
	FrameTimer.stop()
	
func animate() -> void:
	if !looped and frame >= totalframes - 1:
		FrameTimer.stop()
		return
	frame = (frame + 1) % totalframes
