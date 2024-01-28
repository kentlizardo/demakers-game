class_name Cabinet extends Control

@export var target_region: Control

var console_view: ConsoleView

func _ready() -> void:
	create_view(load("res://packs/demo/consoles/zero_sprite.tscn"))

func create_view(con_sprite_template: PackedScene) -> void:
	console_view = ConsoleView.new(con_sprite_template)
	console_view.target_region = target_region
	add_child(console_view)
