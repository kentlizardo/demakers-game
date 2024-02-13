class_name MainPlayerBind extends PlayerBind

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

@export var inventory: PlayerInventory
@export var body: MainPlayerBody
@export var combat_entity: PlayerCombatEntity
@export var cabinet_view: CabinetView

var cabinet: Cabinet

func _init() -> void:
	instance = self

func _ready() -> void:
	cabinet = Cabinet.new(inventory.loadouts, cabinet_view, self)

func _unhandled_input(event: InputEvent) -> void:
	for key: String in HOTSWAP_ACTIONS_TO_INDICES.keys():
		if Input.is_action_just_pressed(key):
			var index := HOTSWAP_ACTIONS_TO_INDICES[key] as int
			if cabinet.try_hotswap(index):
				get_viewport().set_input_as_handled()
