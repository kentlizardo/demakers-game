class_name Util

static func find_closest_ancestor_in_group(node: Node, group: StringName) -> Node:
	if !node:
		return null
	if node.is_in_group(group):
		return node
	return find_closest_ancestor_in_group(node.get_parent(), group)
