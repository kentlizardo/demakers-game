class_name MainPlayerBind extends Node

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

static var instance: MainPlayerBind

@export var body: MainPlayerBody
@export var combat_entity: PlayerCombatEntity
@export var cabinet_view: CabinetView
@export var initial_loadouts: Array[PlayerLoadout] = []

var cabinet: Cabinet = Cabinet.new()

func _init() -> void:
	instance = self

func _ready() -> void:
	cabinet.loadout_changed.connect(_on_loadout_changed)
	for i_loadout in initial_loadouts:
		cabinet.add_loadout(i_loadout)

func _unhandled_input(event: InputEvent) -> void:
	for key: String in HOTSWAP_ACTIONS_TO_INDICES.keys():
		if Input.is_action_just_pressed(key):
			var index := HOTSWAP_ACTIONS_TO_INDICES[key] as int
			if cabinet.try_hotswap(index):
				get_viewport().set_input_as_handled()

func _on_loadout_changed(loadout: PlayerLoadout) -> void:
	if loadout:
		cabinet_view.create_view(loadout.console_template)
	else:
		cabinet_view.create_view(null)
	combat_entity.set_loadout(loadout)
