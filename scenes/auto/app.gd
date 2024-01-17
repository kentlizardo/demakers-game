extends Node

signal staging_finished(stage: Node)

@onready var main_root: Node = $/root/Root

var starting_stage: PackedScene

var _stage: Node = null
var stage: Node:
	get:
		return _stage

var _is_staging: bool = false
var is_staging: bool:
	get:
		return _is_staging

func _ready() -> void:
	if starting_stage:
		stage_scene(starting_stage)

func stage_scene(scene: PackedScene) -> void:
	stage_orphan(scene.instantiate())
func stage_orphan(node: Node) -> void:
	_stage_orphan(node)
func _stage_orphan(node: Node) -> void:
	if is_staging:
		push_error("Staging a new NodeTree while another is being staged.")
		await staging_finished
	is_staging = true
	try_unstage()
	add_child.call_deferred(node)
	await node.ready
	stage = node
	is_staging = false
	staging_finished.emit(node)

func unstage() -> void:
	assert(is_instance_valid(stage), "Error: Should not be unstaging an invalid node")
	stage.queue_free()
	stage = null
func try_unstage() -> bool:
	if is_instance_valid(stage):
		unstage()
		return true
	return false
