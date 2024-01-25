@icon("res://editor/icons/feather/map-pin.svg")
class_name Location extends Node

@export var is_built: bool = false

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
	_test_loc_autostep(sandbox)

func _test_loc(sandbox: Sandbox) -> void:
	const TestLocMenu := preload("res://dev/test_location_menu.gd")
	var menu := load("res://dev/test_location_menu.tscn").instantiate() as TestLocMenu
	var nav := {}
	for i in get_sub_locations():
		nav[i.name as String] = i
	var nav_keys: Array[String]
	nav_keys.assign(nav.keys())
	menu.populate(nav_keys)
	menu.choice_picked.connect(func(key: String) -> void:
		Run.current.stage(nav[key])
		)
	sandbox.add_child(menu)
	sandbox.completed.connect(func() -> void: Run.current.stage(self.get_parent()))

var curr_loc: Location = null
func _test_loc_autostep(sandbox: Sandbox) -> void:
	const TestLocAutostep := preload("res://dev/test_location_autostep_menu.gd")
	var menu := load("res://dev/test_location_autostep_menu.tscn").instantiate() as TestLocAutostep
	sandbox.add_child(menu)
	if get_sub_locations().size() > 0:
		if !curr_loc:
			print("No current location, setting it to first child.")
			curr_loc = get_sub_locations()[0]
		else:
			var last_index := get_sub_locations().find(curr_loc)
			var next_index := last_index + 1
			if next_index < get_sub_locations().size():
				print("Found sublocation")
				curr_loc = get_sub_locations()[last_index + 1]
			else:
				print("Completed current location, moving back to parent")
				curr_loc = null
	else:
		print("Location is a leaf, will move back to parent when done")
	if curr_loc:
		sandbox.completed.connect(func() -> void: Run.current.stage(curr_loc))
	else:
		sandbox.completed.connect(func() -> void: Run.current.stage(self.get_parent()))

func get_sub_locations() -> Array[Location]:
	var locs: Array[Location]
	locs.assign(get_children().filter(func(n: Node) -> bool: return n is Location))
	return locs
