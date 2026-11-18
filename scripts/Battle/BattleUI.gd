class_name BattleUI
extends Control

#region Exports


@export_category("Nodes")
@export var fight_button : Button
@export var bag_button : Button
@export var run_button : Button
@export var pokemon_button : Button
@export var speech_label : Label
#endregion

#region Signals
signal fight_pressed
signal bag_pressed
signal run_pressed
signal pokemon_pressed
#endregion

func _ready() -> void:
	@warning_ignore("return_value_discarded")
	fight_button.connect("pressed", fight_pressed.emit)
	@warning_ignore("return_value_discarded")
	bag_button.connect("pressed", bag_pressed.emit)
	@warning_ignore("return_value_discarded")
	run_button.connect("pressed", run_pressed.emit)
	@warning_ignore("return_value_discarded")
	pokemon_button.connect("pressed", pokemon_pressed.emit)
