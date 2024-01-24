extends Control

signal choice_picked(key: String)
signal exited

@export var stage_lbl: Label
@export var buttons: VBoxContainer
@export var sub_loc_templ: Button
@export var exit_btn: Button

func _ready() -> void:
	sub_loc_templ.visible = false
	exit_btn.pressed.connect(func() -> void:
		Sandbox.complete()
		)
	stage_lbl.text = Run.current.location.name

func _add_button(key: String) -> void:
	var new_btn := sub_loc_templ.duplicate() as Button
	new_btn.text = key
	new_btn.pressed.connect(func() -> void: choice_picked.emit(key))
	buttons.add_child(new_btn)

func populate(keys: Array[String]) -> void:
	for i in keys:
		_add_button(i)
