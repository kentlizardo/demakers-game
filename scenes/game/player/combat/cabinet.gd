class_name Cabinet extends RefCounted

signal loadout_changed(loadout: PlayerLoadout)

var loadout: PlayerLoadout:
	set(x):
		loadout = x
		loadout_changed.emit(loadout)

var _loadouts: Array[PlayerLoadout] = []

func add_loadout(loadout: PlayerLoadout) -> void:
	_loadouts.push_back(loadout)
	_loadouts_changed()

func remove_loadout(loadout: PlayerLoadout) -> void:
	var i := _loadouts.find(loadout)
	assert(i != -1, "PlayerLoadout not found in _loadouts")
	_loadouts.remove_at(i)
	_loadouts_changed()

func try_hotswap(index: int) -> bool:
	if _loadouts.size() > index:
		loadout = _loadouts[index]
		return true
	return false

func _loadouts_changed() -> void:
	var next_loadout := loadout
	if next_loadout:
		if !_loadouts.has(next_loadout):
			next_loadout = null
	if !next_loadout:
		for i in _loadouts:
			next_loadout = i
	loadout = next_loadout

