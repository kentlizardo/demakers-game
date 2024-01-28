class_name PlayerWeapon extends Node3D

@export var visual: VisualInstance3D

var console_view: ConsoleView

func _ready() -> void:
	if console_view:
		visual.set_layer_mask_value(1, false)
		for i: int in ConsoleView.WEAPON_CULL_LAYERS:
			visual.set_layer_mask_value(i, false)
		visual.set_layer_mask_value(ConsoleView.current_weapon_cull, true)

func _process(delta: float) -> void:
	if MainPlayerBind.instance:
		if MainPlayerBind.instance.body:
			self.global_transform = MainPlayerBind.instance.body.weapon_pivot.global_transform

func delete(new_view: ConsoleView) -> void:
	if new_view:
		if !new_view.is_queued_for_deletion():
			await new_view.view_created
	queue_free()
