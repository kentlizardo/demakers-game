class_name ConsoleSprite extends Node2D

@export var min_view_region: Control

func resize_min_view_to_target(target: Control) -> void:	
	var min_size := min_view_region.size
	var min_aspect := min_size.x / min_size.y
	
	var view_size := target.size
	var view_aspect := view_size.x / view_size.y
	var scale_required : float
	# match width if view is wider, or height if view is taller
	if view_aspect > min_aspect:
		var target_width := view_size.x
		scale_required = target_width / min_size.x
	else:
		var target_height := view_size.y
		scale_required = target_height / min_size.y
	scale = Vector2.ONE * scale_required
	var target_g_pos := target.get_global_rect().get_center()
	var min_view_center_g_pos := min_view_region.get_global_rect().get_center()
	var offset := min_view_center_g_pos - global_position
	self.global_position = target_g_pos - offset

func resize_min_view_to_viewport() -> void:
	var min_size := min_view_region.size
	var min_aspect := min_size.x / min_size.y
	
	var view_size := get_viewport_rect().size
	var view_aspect := view_size.x / view_size.y
	var scale_required : float
	# match width if view is wider, or height if view is taller
	if view_aspect > min_aspect:
		var target_width := view_size.x
		scale_required = target_width / min_size.x
	else:
		var target_height := view_size.y
		scale_required = target_height / min_size.y
	scale = Vector2.ONE * scale_required
	var target_pos := get_viewport_rect().get_center()
	var center := min_view_region.get_global_rect().get_center()
	var offset := global_position - center
	self.global_position = target_pos + offset
