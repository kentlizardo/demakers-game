class_name Console extends RefCounted

static func from_loadout(cabinet: Cabinet, loadout: PlayerLoadout) -> Console:
	var con := Console.new(cabinet)
	con.spec = loadout.spec
	con.modules = loadout.modules.duplicate()
	return con

# Dependencies
var _cabinet: Cabinet
var cabinet: Cabinet:
	set(x):
		assert(false, "readonly")
	get:
		return _cabinet
# Public
var spec: ConsoleSpec
var modules: Array[Module] = []

func _init(cabinet: Cabinet) -> void:
	_cabinet = cabinet
