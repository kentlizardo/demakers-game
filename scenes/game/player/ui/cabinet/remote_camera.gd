extends Camera3D

# TODO: Switch this class to use PlayerBind so Entities can be spectated.

func _process(delta: float) -> void:
	if MainPlayerBind.instance:
		if MainPlayerBind.instance.body:
			var body := MainPlayerBind.instance.body
			global_position = body.camera_pivot.global_position
			global_rotation = body.camera_pivot.global_rotation
