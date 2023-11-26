extends Node2D

@onready var real_map = $MapReal
@onready var alt_map = $MapAlt

func _ready():
	PhaseManager.phase_shift.connect(_on_phase_shift)
	PhaseManager.hue_shift.connect(_on_hue_shift)

	self.remove_child(alt_map)
	$BlackBg.hide()


func _process(_delta):
	if Input.is_action_just_pressed("PhaseShift"):
		PhaseManager.phase_shifted = !PhaseManager.phase_shifted

	if Input.is_action_just_pressed("HueShift"):
		PhaseManager.hue_shifted = !PhaseManager.hue_shifted


func _on_phase_shift(value: bool):
	if value:
		self.remove_child(real_map)
		self.add_child(alt_map)
		$BlackBg.show()
		$WhiteBg.hide()
		return

	self.remove_child(alt_map)
	self.add_child(real_map)
	$BlackBg.hide()
	$WhiteBg.show()


func _on_hue_shift(_value: bool):
	print("[.../levels/level_controller.gd] Current Hue:", PhaseManager.hue_shifted)


# Free both maps on changing levels.
func _on_tree_exited():
	real_map.queue_free()
	alt_map.queue_free()
