extends Control

@export var stage_lbl: Label
@export var exit_btn: Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stage_lbl.text = Run.current.location.name

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func proceed() -> void:
	print("completing")
	Sandbox.complete()
