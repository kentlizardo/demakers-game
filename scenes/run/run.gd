class_name Run extends Node

static var current: Run

@export var initial_location: Location

var level_instance: Sandbox:
	set(x):
		if is_instance_valid(level_instance):
			level_instance.completed.disconnect(_on_level_completed)
			level_instance.failed.disconnect(_on_level_failed)
		level_instance = x
		if is_instance_valid(level_instance):
			level_instance.completed.connect(_on_level_completed)
			level_instance.failed.connect(_on_level_failed)

var _location: Location
var location: Location:
	get:
		return _location

func _init() -> void:
	current = self

func _ready() -> void:
	stage(initial_location)

func _on_level_completed() -> void:
	pass
func _on_level_failed() -> void:
	pass

func _create_sandbox() -> void:
	if level_instance:
		level_instance.queue_free()
	level_instance = Sandbox.new()
	call_deferred("add_child", level_instance)

func stage(frontier: Location) -> void:
	print("moving to " + frontier.name)
	if level_instance:
		level_instance.queue_free()
	_create_sandbox()
	_location = frontier
	frontier.enter(level_instance)
