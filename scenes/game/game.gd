class_name Game extends Node

static var current: Game

@export var run: Run

func _init() -> void:
	current = self

func _ready() -> void:
	if !run:
		push_error("Unimplemented: Generate new run")
