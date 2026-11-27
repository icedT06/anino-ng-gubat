extends CharacterBody3D

const SPEED = 3.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENS = 0.003

@onready var camera_pivot = $CameraPivot

var can_move = true

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event):

	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		return

	if event is InputEventMouseMotion:

		rotate_y(-event.relative.x * MOUSE_SENS)

		camera_pivot.rotate_x(
			-event.relative.y * MOUSE_SENS
		)

		camera_pivot.rotation.x = clamp(
			camera_pivot.rotation.x,
			deg_to_rad(-60),
			deg_to_rad(60)
		)


func _physics_process(delta):

	if !can_move:
		return

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector(
		"move_left",
	"move_right",
	"move_forward",
	"move_backward"
	)

	var direction = (
		transform.basis *
		Vector3(
			input_dir.x,
			0,
			input_dir.y
		)
	).normalized()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(
			velocity.x,
			0,
			SPEED
		)

		velocity.z = move_toward(
			velocity.z,
			0,
			SPEED
		)

	move_and_slide()


func _unhandled_input(event):

	if event.is_action_pressed("attack"):
		attack()


func attack():

	print("ATTACK")

	var wolf = get_tree().get_first_node_in_group("enemy")

	if wolf == null:
		return

	var distance = global_position.distance_to(
		wolf.global_position
	)

	if distance <= 3.0:

		wolf.take_damage()