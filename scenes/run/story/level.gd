class_name Level extends Location

@export var level_template: PackedScene

func _populate_level() -> Array[Object]:
	Debug.abstr_func(self)
	return []

## Warning: There is no distinction when using build for a level,
## Since each sandbox is generated.
func _build() -> void:
	pass

## Retrieves all locations from root to this node.
func _index(node: Node) -> Array[Location]:
	if !node:
		return []
	if node is Location:
		return _index(node.get_parent()) + ([node] as Array[Location])
	return _index(node.get_parent())

## This function creates an index of all Superlocations
## While keeping only the highest Level location.
func _create_level_index(node: Node) -> Array[Location]:
	var loc_index := _index(self)
	var highest_level: Level
	for i: Location in loc_index:
		if i is Level:
			highest_level = i
	assert(highest_level, "Should not be calling _create_level_index from a non Level node.")
	var filter := func(loc: Location) -> bool:
		if loc is Level:
			return loc == highest_level
		return true
	return loc_index.filter(filter)

func _enter(sandbox: Sandbox) -> void:
	var level_index := _create_level_index(self)
	for i in level_index:
		print(i.name)
