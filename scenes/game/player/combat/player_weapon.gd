class_name PlayerWeapon extends Node3D

@export var visual: VisualInstance3D

func _ready() -> void:
	for i: int in ConsoleView.WEAPON_CULL_LAYERS:
		visual.set_layer_mask_value(i, false)
	visual.set_layer_mask_value(ConsoleView.current_weapon_cull, true)

func _process(delta: float) -> void:
	if MainPlayerBind.instance:
		if MainPlayerBind.instance.body:
			self.global_transform = MainPlayerBind.instance.body.weapon_pivot.global_transform
