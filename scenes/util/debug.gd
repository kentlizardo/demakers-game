class_name Debug
## Static class used as a helper library for debug purposes.
##
## These functions are not optimized for performance, 
## but for readability in case of future modification.
##

# TODO: When method overloading is added, consolidate the following.
# Or keep it the same for more type safety?
static func obj_info(obj: Object) -> String:
	return obj.get_script().get_path() + "(%s)" % obj.get_class() if obj.get_script() != null else obj.get_class()
static func node_info(node: Node) -> String:
	return obj_info(node)
static func res_info(res: Resource) -> String:
	return obj_info(res)

## General use abstract function.
## WARNING: This only prints out the source of base script, and not derived ones.
static func abstr() -> void:
	if OS.has_feature("debug"):
		var stack := get_stack()
		var last_call := stack[1] as Dictionary
		var func_name := last_call["function"] as String
		var source := last_call["source"] as String
		push_error("Abstract feature called {0} in {1}".format([func_name, source]))
		print_stack()

# More verbose abstract stubs.
# Can be used to send more information such as the instance script if there is one, and the base type.
#
# TODO: Remove linebreaks once Debugger error panels have text wrapping.
# See https://github.com/godotengine/godot-proposals/issues/7868

## Set this to true if you want abstr_class calls from derived classes to be ignored. Otherwise, you will need to super() in derived classes.
const IGNORE_DERIVED_CONSTRUCTOR := true
static func abstr_class(obj: Object) -> void:
	if OS.has_feature("debug"):
		var stack := get_stack()
		var last_call := stack[1] as Dictionary
		var source := last_call["source"] as String
		if IGNORE_DERIVED_CONSTRUCTOR:
			if obj.get_script() != null:
				if obj.get_script().get_path() != source:
					return
		push_error("Abstract class instantiated {0}\n from source ({1})".format([obj_info(obj), source]))
static func abstr_func(obj: Object) -> void:
	if OS.has_feature("debug"):
		var stack := get_stack()
		var last_call := stack[1] as Dictionary
		var func_name := last_call["function"] as String
		var source := last_call["source"] as String
		push_error("Unimplemented function \"{0}\"\n in {1} from source {2}.".format([func_name, obj_info(obj), source]))

const TREE_INDENT = "\t"
static func _tree_info(node: Node) -> String:
	return (node.name + ": %s" % node_info(node))
static func _dump_tree_helper(x: Node, level : int) -> String:
	var info := TREE_INDENT.repeat(level) + _tree_info(x)
	var sublevels_trees := PackedStringArray()
	for sub : Node in x.get_children():
		sublevels_trees.append(_dump_tree_helper(sub, level + 1))
	var sublevels := "".join(sublevels_trees)
	return info + "\n" + sublevels
static func dump_tree(node: Node) -> void:
	print(_dump_tree_helper(node, 0))
