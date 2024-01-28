class_name WeaponModule extends Module

@export var weapon_template: PackedScene

func _on_bind(ent: CombatEntity) -> void:
	if ent is PlayerCombatEntity:
		var data := get_bind_data(ent)
		data["weapon"] = weapon_template.instantiate()
		ent.body.weapon_pivot.add_child(data["weapon"])
func _pre_unbind(ent: CombatEntity) -> void:
	if ent is PlayerCombatEntity:
		var data := get_bind_data(ent)
		data["weapon"].queue_free()
