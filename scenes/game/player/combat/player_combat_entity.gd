class_name PlayerCombatEntity extends CombatEntity

var _loadout: PlayerLoadout

func set_loadout(loadout: PlayerLoadout) -> void:
	if _loadout:
		for mod in _loadout.modules:
			remove_module(mod)
	_loadout = loadout
	if _loadout:
		for mod in _loadout.modules:
			add_module(mod)
