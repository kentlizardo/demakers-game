class_name CabinetView extends Control

@export var target_region: Control

var console_view: ConsoleView

func create_view(con_sprite_template: PackedScene) -> void:
	var old_view := console_view
	console_view = ConsoleView.new(con_sprite_template)
	console_view.target_region = target_region
	add_child(console_view)
	if old_view:
		old_view.delete_once_view_created(console_view)
