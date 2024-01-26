extends Camera3D

# TODO: Switch this class to use PlayerBind so Entities can be spectated.

func _process(delta: float) -> void:
	if MainPlayerBody.instance:
		global_position = MainPlayerBody.instance.camera_pivot.global_position
		global_rotation = MainPlayerBody.instance.camera_pivot.global_rotation
