class_name ConsoleView extends Control

const SCREEN_PACKED := preload("res://scenes/game/player/ui/cabinet/screen.tscn")
const DEFAULT_SETTINGS := {
	"RESIZE_MIN_VIEW_TO_TARGET": true
}

static var settings := DEFAULT_SETTINGS

signal view_created

var target_region: Control

var _console_sprite: ConsoleSprite
var _screen: Screen

func _init(console_sprite_template: PackedScene) -> void:
	_screen = SCREEN_PACKED.instantiate() as Screen
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	self.mouse_filter = Control.MOUSE_FILTER_IGNORE
	if console_sprite_template:
		_console_sprite = console_sprite_template.instantiate() as ConsoleSprite
		add_child(_console_sprite)

func _ready() -> void:
	if _console_sprite:
		_console_sprite.min_view_region.add_child(_screen)
	else:
		add_child(_screen)
	
	resized.connect(_on_resize)
	_on_resize()
	
	var tw := create_tween()
	tw.tween_property(self, "scale", Vector2.ONE, 1.0).from(Vector2.ONE * 0.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
	await tw.finished
	view_created.emit()

func _process(delta: float) -> void:
	pivot_offset = size / 2

func _on_resize() -> void:
	resize_sprite_and_screen.call_deferred()

func resize_sprite_and_screen() -> void:
	if _console_sprite:
		if settings["RESIZE_MIN_VIEW_TO_TARGET"]:
			if !target_region:
				_console_sprite.resize_min_view_to_viewport()
			else:
				_console_sprite.resize_min_view_to_target(target_region)
		else:
			var target_pos: Vector2
			if target_region:
				target_pos = target_region.get_global_rect().get_center()
			else:
				target_pos = get_viewport_rect().get_center()
			_console_sprite.global_position = target_pos
	_screen.match_window_resolution()

func delete_once_view_created(view: ConsoleView) -> void:
	if view:
		if !view.is_queued_for_deletion():
			await view.view_created
	queue_free()
