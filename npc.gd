extends Node3D

var player_near = false

@onready var prompt = $Label3D

func _ready():
	prompt.visible = false

func _process(_delta):

	if get_node("../CanvasLayer").dialogue_box.visible:
		return

	if player_near and Input.is_action_just_pressed("interact"):
		interact()

func interact():

	print("NPC TALKING")

	var dialogue_manager = get_node("../CanvasLayer")

	dialogue_manager.start_dialogue()

func _on_area_3d_body_entered(body):
	if body.name == "Player":
		player_near = true
		prompt.visible = true

func _on_area_3d_body_exited(body):
	if body.name == "Player":
		player_near = false
		prompt.visible = false

func _input_event(camera, event, position, normal, shape_idx):

	if event is InputEventMouseButton:

		if event.button_index == MOUSE_BUTTON_LEFT:

			if event.pressed:

				interact()
