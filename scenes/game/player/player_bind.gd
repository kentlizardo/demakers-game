class_name PlayerBind extends Node

func _ready() -> void:
	Sandbox.register_player(self)
