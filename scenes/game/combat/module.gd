class_name Module extends Node

var _holder: CombatEntity:
	set(x):
		if _holder:
			_holder.remove_module(self)
		_holder = x
		if _holder:
			_holder.add_module(self)
var holder: CombatEntity:
	get:
		return holder

func _init() -> void:
	Debug.abstr_class(self)

func _enter_tree() -> void:
	_holder = get_parent() as CombatEntity

func _exit_tree() -> void:
	_holder = null

# All functions below should only be called by CombatEntity.
func bind() -> void:
	_bind()
func unbind() -> void:
	_unbind()

# Interface
func _bind() -> void:
	Debug.abstr_func(self)
func _unbind() -> void:
	Debug.abstr_func(self)
