class_name CabinetView extends Control

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

@export var target_region: Control

var cabinet: Cabinet:
	set(x):
		if cabinet:
			cabinet.loadout_changed.disconnect(_on_loadout_changed)
		cabinet = x
		if cabinet:
			cabinet.loadout_changed.connect(_on_loadout_changed)

var console_view: ConsoleView

func _unhandled_input(event: InputEvent) -> void:
	for key: String in HOTSWAP_ACTIONS_TO_INDICES.keys():
		if Input.is_action_just_pressed(key):
			var index := HOTSWAP_ACTIONS_TO_INDICES[key] as int
			if cabinet.try_hotswap(index):
				get_viewport().set_input_as_handled()

func _on_loadout_changed(loadout: PlayerLoadout) -> void:
	create_view(loadout.console_sprite)

func create_view(con_sprite_template: PackedScene) -> void:
	var new_view := ConsoleView.new(con_sprite_template)
	if console_view:
		console_view.delete_once_view_created(new_view)
	console_view = new_view
	console_view.target_region = target_region
	add_child(console_view)
