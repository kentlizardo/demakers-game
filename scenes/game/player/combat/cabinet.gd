class_name Cabinet extends RefCounted

# Dependencies
var cabinet_view: CabinetView
var player_bind: MainPlayerBind
# Public
var __current_console: Console
var current_console: Console:
	set(x):
		__current_console = x
		if __current_console:
			var sprite := x.spec.console_sprite_packed
			cabinet_view.create_view(sprite)
			if current_weapon:
				current_weapon.delete(cabinet_view.console_view)
			if x.spec.console_sprite_packed:
				current_weapon = x.spec.weapon_packed.instantiate()
				(current_weapon as PlayerWeapon).console_view = cabinet_view.console_view
				var ce := player_bind.combat_entity
				if ce is PlayerCombatEntity:
					if ce.body is MainPlayerBody:
						ce.body.weapon_pivot.add_child(current_weapon)
		else:
			cabinet_view.create_view(null)
			if current_weapon:
				current_weapon.queue_free()
	get:
		return __current_console
var current_weapon: PlayerWeapon
# Private
var _consoles: Array[Console] = []

func _init(loadouts: Array[PlayerLoadout], view: CabinetView, player_bind: PlayerBind) -> void:
	cabinet_view = view
	self.player_bind = player_bind
	for i in loadouts:
		_consoles.push_back(Console.from_loadout(self, i))
	balance()

func add_loadout(loadout: PlayerLoadout) -> void:
	add_console(Console.from_loadout(self, loadout))

func add_console(console: Console) -> void:
	_consoles.push_back(console)
	_consoles_changed()

func remove_loadout(console: Console) -> void:
	var i := _consoles.find(console)
	assert(i != -1, "Tried to remove Console not in Cabinet._consoles")
	_consoles.remove_at(i)
	_consoles_changed()

func try_hotswap(index: int) -> bool:
	if _consoles.size() > index:
		current_console = _consoles[index]
		return true
	return false

func _is_console_valid(console: Console) -> bool:
	if !_consoles.has(console):
		return false
	return true

func balance() -> void:
	var next_console := current_console
	if next_console:
		if _is_console_valid(next_console):
			next_console = null
	if !next_console:
		for i in _consoles:
			next_console = i
	current_console = next_console

func _consoles_changed() -> void:
	balance()
