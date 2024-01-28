class_name CombatEntity extends Node

@export var modules: Array[Module] = []

func add_module(mod: Module) -> void:
	modules.push_back(mod)
	mod.bind(self)

func remove_module(mod: Module) -> void:
	modules.remove_at(modules.find(mod))
	mod.unbind(self)
