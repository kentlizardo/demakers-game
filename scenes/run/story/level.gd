class_name Level extends Location

## Retrieves all locations from root to this node.
static func _index(node: Node) -> Array[Location]:
	if !node:
		return []
	if node is Location:
		var loc: Location = node
		return _index(node.get_parent()) + [loc]
	return _index(node.get_parent())

## This function creates an index of all Superlocations
## While keeping only the frontier Level
static func _create_level_index(level_frontier: Level) -> Array[Location]:
	var loc_index := _index(level_frontier)
	var filter := func(loc: Location) -> bool:
		if loc is Level:
			return loc == level_frontier
		return true
	return loc_index.filter(filter)

@export var level_template: PackedScene

## Warning: There is no distinction when using build for a level,
## Since each sandbox is generated.
func _build() -> void:
	pass

func _enter(sandbox: Sandbox) -> void:
	var level_index := Level._create_level_index(self)
	for loc: Location in level_index:
		loc._populate_level() # Why is autocomplete not working here?
