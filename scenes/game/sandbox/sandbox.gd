class_name Sandbox extends Node

static var instance: Sandbox

static func register_player(player: PlayerBind) -> void:
	instance.players.push_back(player)

static func complete() -> void:
	instance.completed.emit()

static func fail() -> void:
	instance.failed.emit()

signal completed
signal failed

var players: Array[PlayerBind] = []

func _init() -> void:
	instance = self

