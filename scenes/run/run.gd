class_name Run extends Node

static var current: Run

@export var initial_location: Location

var sandbox_instance: Sandbox:
	set(x):
		if is_instance_valid(sandbox_instance):
			sandbox_instance.completed.disconnect(_on_level_completed)
			sandbox_instance.failed.disconnect(_on_level_failed)
		sandbox_instance = x
		if is_instance_valid(sandbox_instance):
			sandbox_instance.completed.connect(_on_level_completed)
			sandbox_instance.failed.connect(_on_level_failed)

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
	if sandbox_instance:
		sandbox_instance.queue_free()
	sandbox_instance = Sandbox.new()
	call_deferred("add_child", sandbox_instance)

func stage(frontier: Location) -> void:
	print("moving to " + frontier.name)
	_create_sandbox()
	_location = frontier
	frontier.enter(sandbox_instance)
