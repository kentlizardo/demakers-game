class_name Screen extends Control

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

var scale_factor := 1.0:
	set(x):
		scale_factor = x
		is_dirty = true
var pixel_scale := Vector2.ONE:
	set(x):
		pixel_scale = x
		is_dirty = true

var is_dirty: bool

func _ready() -> void:
	is_dirty = true

func _process(delta: float) -> void:
	if is_dirty:
		var total_scale := scale_factor * pixel_scale
		resolution_container.scale = Vector2(1.0 / total_scale.x, 1.0 / total_scale.y)
		resolution_container.size = size * total_scale
		is_dirty = false

func match_window_resolution() -> void:
	pixel_scale = get_global_scale(get_parent())
