class_name WeaponModule extends Module

@export var weapon_template: PackedScene

func _on_bind(ent: CombatEntity) -> void:
	if ent is PlayerCombatEntity:
		var data := get_bind_data(ent)
		var weapon := weapon_template.instantiate() as PlayerWeapon
		weapon.console_view = MainPlayerBind.instance.cabinet_view.console_view
		ent.body.weapon_pivot.add_child(weapon)
		data["weapon"] = weapon
func _pre_unbind(ent: CombatEntity) -> void:
	if ent is PlayerCombatEntity:
		var data := get_bind_data(ent)
		data["weapon"].queue_free()
