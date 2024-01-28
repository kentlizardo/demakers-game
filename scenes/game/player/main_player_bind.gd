extends Node

@export var combat_entity: CombatEntity
@export var cabinet_view: CabinetView
@export var initial_loadouts: Array[PlayerLoadout] = []

var cabinet: Cabinet = Cabinet.new()

func _ready() -> void:
	cabinet_view.cabinet = cabinet

	for i_loadout in initial_loadouts:
		cabinet.add_loadout(i_loadout)
