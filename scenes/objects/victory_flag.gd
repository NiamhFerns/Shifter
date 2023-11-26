extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	PhaseManager.phase_shift.connect(_on_phase_shift)
	$FlagAlt.hide()
	$FlagReal.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_phase_shift(value: bool):
	if value:
		$FlagAlt.show()
		$FlagReal.hide()
		return
	$FlagAlt.hide()
	$FlagReal.show()
