class_name Module extends Resource

func _init() -> void:
	Debug.abstr_class(self)

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
