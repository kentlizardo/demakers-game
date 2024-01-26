extends Camera3D

func _process(delta: float) -> void:
	if MainPlayerBody.instance:
		global_position = MainPlayerBody.instance.camera_pivot.global_position
		global_rotation = MainPlayerBody.instance.camera_pivot.global_rotation
