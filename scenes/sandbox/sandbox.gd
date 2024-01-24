class_name Sandbox extends Node

static var instance: Sandbox

static func complete() -> void:
	instance.completed.emit()

static func fail() -> void:
	instance.failed.emit()

signal completed
signal failed

func _init() -> void:
	instance = self
