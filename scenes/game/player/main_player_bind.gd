extends Node

const HOTSWAP_ACTIONS_TO_INDICES := {
	"hotswap_1": 0,
	"hotswap_2": 1,
	"hotswap_3": 2,
	"hotswap_4": 3,
	"hotswap_5": 4,
	"hotswap_6": 5,
	"hotswap_7": 6,
	"hotswap_8": 7,
	"hotswap_9": 8,
	"hotswap_10": 9,
}

@export var combat_entity: CombatEntity

@export var cabinet: Cabinet

@export var initial_loadouts: Array[PlayerLoadout] = []

var loadout: PlayerLoadout:
	set(x):
		loadout = x
		if loadout:
			cabinet.create_view(loadout.console_sprite)
		else:
			cabinet.create_view(null)

var _loadouts: Array[PlayerLoadout] = []
func add_loadout(loadout: PlayerLoadout) -> void:
	_loadouts.push_back(loadout)
	_loadouts_changed()
func remove_loadout(loadout: PlayerLoadout) -> void:
	var i := _loadouts.find(loadout)
	assert(i != -1, "PlayerLoadout not found in _loadouts")
	_loadouts.push_back(loadout)
	_loadouts_changed()
func _loadouts_changed() -> void:
	if loadout:
		if !_loadouts.has(loadout):
			loadout = null
	else:
		for i in _loadouts:
			loadout = i

func _ready() -> void:
	for i_loadout in initial_loadouts:
		add_loadout(i_loadout)
	print(_loadouts)

func _unhandled_input(event: InputEvent) -> void:
	for key: String in HOTSWAP_ACTIONS_TO_INDICES.keys():
		if Input.is_action_just_pressed(key):
			var index := HOTSWAP_ACTIONS_TO_INDICES[key] as int
			if _loadouts.size() > index:
				loadout = _loadouts[index]
