class_name Cabinet extends Control

@export var target_region: Control

var console_view: ConsoleView

func _ready() -> void:
	create_view(load("res://packs/demo/consoles/zero_sprite.tscn"))

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("primary"):
		create_view(load("res://packs/demo/consoles/zero_sprite.tscn"))

func create_view(con_sprite_template: PackedScene) -> void:
	var new_view := ConsoleView.new(con_sprite_template)
	if console_view:
		console_view.delete_once_view_created(new_view)
	console_view = new_view
	console_view.target_region = target_region
	add_child(console_view)
