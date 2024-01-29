class_name ConsoleView extends Control

const SCREEN_PACKED := preload("res://scenes/game/player/ui/cabinet/screen.tscn")
const DEFAULT_SETTINGS := {
	"RESIZE_MIN_VIEW_TO_TARGET": true
}
const WEAPON_CULL_LAYERS := [19, 20]

static var settings := DEFAULT_SETTINGS
static var current_weapon_cull : int = WEAPON_CULL_LAYERS[0]

signal view_created

var target_region: Control
var view_creating := true

var _console_sprite: ConsoleSprite
var _screen: Screen

func _init(console_sprite_template: PackedScene) -> void:
	_next_weapon_cull()
	_screen = SCREEN_PACKED.instantiate() as Screen
	for i: int in WEAPON_CULL_LAYERS:
		_screen.camera.set_cull_mask_value(i, false)
	_screen.camera.set_cull_mask_value(ConsoleView.current_weapon_cull, true)
	
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
	resize_sprite_and_screen()
	if _console_sprite:
		var tw := create_tween()
		tw.tween_property(self, "modulate:a", 1.0, 0.5).from(0.0).set_ease(Tween.EASE_IN_OUT)
		tw.parallel().tween_property(self, "scale", Vector2.ONE, 1.0).from(Vector2.ONE * 0.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
		await tw.finished
	else:
		var tw := create_tween()
		tw.tween_property(self, "modulate:a", 1.0, 0.5).from(0.0).set_ease(Tween.EASE_IN_OUT)
		await tw.finished
	view_created.emit()
	view_creating = false

func _process(delta: float) -> void:
	pivot_offset = size / 2

func _next_weapon_cull() -> void:
	var curr_cull_index := WEAPON_CULL_LAYERS.find(current_weapon_cull)
	var next_cull_index := curr_cull_index + 1
	if next_cull_index > WEAPON_CULL_LAYERS.size() - 1:
		next_cull_index = 0
	current_weapon_cull = WEAPON_CULL_LAYERS[next_cull_index]
	print("next weapon " + str(current_weapon_cull))

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
		if view.view_creating:
			await view.view_created
	# prevents premature deletion causing extra views
	if view_creating:
		view_created.emit()
	queue_free()
