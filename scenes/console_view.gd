class_name ConsoleView extends Control

const DEFAULT_SETTINGS := {
	"RESIZE_MIN_VIEW_TO_TARGET": true
}

static var settings := DEFAULT_SETTINGS

@export var console_sprite: ConsoleSprite
@export var target_region: Control

func _ready() -> void:
	resized.connect(_on_resize)
	_on_resize()
	
	var tw := create_tween()
	tw.tween_property(self, "scale", Vector2.ONE, 1.0).from(Vector2.ONE * 0.2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_EXPO)

func _process(delta: float) -> void:
	pivot_offset = size / 2

func _on_resize() -> void:
	resize_sprite_and_screen.call_deferred()

func resize_sprite_and_screen() -> void:
	if settings["RESIZE_MIN_VIEW_TO_TARGET"]:
		if !target_region:
			console_sprite.resize_min_view_to_viewport()
		else:
			console_sprite.resize_min_view_to_target(target_region)
	else:
		var target_pos: Vector2
		if target_region:
			target_pos = target_region.get_global_rect().get_center()
		else:
			target_pos = get_viewport_rect().get_center()
		console_sprite.global_position = target_pos
	console_sprite.screen.match_window_resolution()
