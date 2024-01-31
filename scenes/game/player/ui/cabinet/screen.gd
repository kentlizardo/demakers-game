class_name Screen extends Control

const RemoteCamera := preload("res://scenes/game/player/ui/cabinet/remote_camera.gd")

static func get_global_scale(node: Node) -> Vector2:
		if !node:
			return Vector2.ONE
		var outer := get_global_scale(node.get_parent())
		if node is Control:
			return node.scale * outer
		if node is Node2D:
			return node.scale * outer
		return outer

@export var resolution_container: Control
@export var camera: RemoteCamera

var scale_factor := 0.25:
	set(x):
		scale_factor = x
		is_dirty = true
var pixel_scale := Vector2.ONE:
	set(x):
		pixel_scale = x
		is_dirty = true

var is_dirty: bool

func _ready() -> void:
	match_window_resolution()
	is_dirty = true

func _process(delta: float) -> void:
	if is_dirty:
		var total_scale := scale_factor * pixel_scale
		resolution_container.scale = Vector2(1.0 / total_scale.x, 1.0 / total_scale.y)
		resolution_container.size = size * total_scale
		is_dirty = false

# TODO: Instead of matching pixel scale for the consolesprite's min_view_region
# Scale the pixel scale so that the pixel scale is preserved no matter the target area

func match_window_resolution() -> void:
	pixel_scale = get_global_scale(self)
