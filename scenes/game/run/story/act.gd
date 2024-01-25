@icon("res://editor/icons/feather/layers.svg")
class_name Act extends Location

func get_progress() -> int:
	Debug.abstr_func(self)
	return -1

func get_max_progress() -> int:
	Debug.abstr_func(self)
	return -1

func _ready() -> void:
	get_progress()
