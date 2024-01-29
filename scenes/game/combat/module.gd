class_name Module extends Resource

var _bind_data := {}

func _init() -> void:
	Debug.abstr_class(self)

func _add_bind_data(ent: CombatEntity) -> void:
	assert(!_bind_data.has(ent))
	_bind_data[ent] = {}

func _remove_bind_data(ent: CombatEntity) -> void:
	assert(_bind_data.has(ent))
	_bind_data.erase(ent)

func get_bind_data(ent: CombatEntity) -> Dictionary:
	assert(_bind_data.has(ent))
	return _bind_data[ent]

func bind(ent: CombatEntity) -> void:
	if _pre_bind(ent):
		_add_bind_data(ent)
		_on_bind(ent)

func unbind(ent: CombatEntity) -> void:
	if _bind_data.has(ent):
		_pre_unbind(ent)
		_remove_bind_data(ent)
		_on_unbind(ent)

# Interface
func _pre_bind(ent: CombatEntity) -> bool:
	Debug.abstr_func(self)
	return true
func _on_bind(ent: CombatEntity) -> void:
	Debug.abstr_func(self)
func _pre_unbind(ent: CombatEntity) -> void:
	Debug.abstr_func(self)
func _on_unbind(ent: CombatEntity) -> void:
	Debug.abstr_func(self)
