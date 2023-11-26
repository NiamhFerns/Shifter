extends Node

signal phase_shift(value: bool)
signal hue_shift(value: bool)

# Responsible for handling when the player is in the "alternate phase".
var phase_shifted: bool = false:
	get:
		return phase_shifted
	set(value):
		phase_shifted = value
		phase_shift.emit(value)

# Responsible for handling when the player is in the "alternate hue".
var hue_shifted: bool = false:
	get:
		return hue_shifted
	set(value):
		hue_shifted = value
		hue_shift.emit(value)
