class_name ConsoleView extends Control

const RESIZE_MIN_VIEW_TO_TARGET := true

@export var console_sprite: ConsoleSprite
@export var target_region: Control

func _ready() -> void:
	resized.connect(_on_resize)
	_on_resize()

func _on_resize() -> void:
	if RESIZE_MIN_VIEW_TO_TARGET:
		if !target_region:
			console_sprite.resize_min_view_to_viewport()
		else:
			console_sprite.resize_min_view_to_target(target_region)
	console_sprite.screen.match_window_resolution()
