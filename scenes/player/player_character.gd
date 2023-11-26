extends CharacterBody2D

signal before_health_change
signal after_health_change

# Consts
const SPEED = 300.0
const JUMP_VELOCITY = -700.0

# Exports
@export var starting_health: float

# Fields
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 2
var double_jumped: bool = false

# On _ready() Fields
@onready var current_health: float = starting_health


func after_modifiers_in(value: float) -> float:
	return value


func damage_receive(damage: float) -> void:
	before_health_change.emit(current_health)
	current_health -= self.after_modifiers_in(damage)
	after_health_change.emit(current_health)
	if current_health <= 0:
		$"../Gameplay".game_over.emit()


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("Up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_just_pressed("Up") and not double_jumped:
		velocity.y = JUMP_VELOCITY
		double_jumped = true

	if is_on_floor():
		double_jumped = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
