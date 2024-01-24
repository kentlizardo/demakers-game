@icon("res://editor/icons/feather/map-pin.svg")
class_name Location extends Node
var i_eraseble:int

var is_built: bool = false

func _init() -> void:
	Debug.abstr_class(self)

func _build() -> void:
	Debug.abstr_func(self)

func _enter(sandbox: Sandbox) -> void:
	Debug.abstr_func(self)

func build() -> bool:
	if is_built:
		_build()
		return false
	is_built = true
	return true

func enter(sandbox: Sandbox) -> void:
	build()
	_enter(sandbox)

func get_sub_locations() -> Array[Location]:
	var locs: Array[Location]
	locs.assign(get_children().filter(func(n: Node) -> bool: return n is Location))
	return locs
