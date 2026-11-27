extends CanvasLayer

@onready var dialogue_box = $DialogueBox
@onready var quest_popup = $QuestPopup

@onready var npc_name = $DialogueBox/VBoxContainer/NPCName
@onready var dialogue_text = $DialogueBox/VBoxContainer/DialogueText

@onready var continue_button = $DialogueBox/VBoxContainer/HBoxContainer/ContinueButton
@onready var accept_button = $DialogueBox/VBoxContainer/HBoxContainer/AcceptButton
@onready var decline_button = $DialogueBox/VBoxContainer/HBoxContainer/DeclineButton

var dialogue_stage = 0

func start_dialogue():

	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	var player = get_parent().get_node("Player")
	player.can_move = false

	dialogue_stage = 0

	dialogue_box.visible = true

	continue_button.visible = true
	accept_button.visible = false
	decline_button.visible = false

	npc_name.text = "Elder Spirit Anino"

	if QuestManager.story_stage == 0:

		dialogue_text.text = "Aki, darkness has returned to the Forest of Luntian."

	elif QuestManager.story_stage == 1:

		dialogue_text.text = "You have restored one fragment of my power."

	elif QuestManager.story_stage == 2:

		dialogue_text.text = "The Corrupted Wolf has been defeated. The forest grows stronger."

	elif QuestManager.story_stage == 3:

		dialogue_text.text = "The Ancient Grove awaits purification."

	elif QuestManager.story_stage >= 4:

		dialogue_text.text = "The final battle against Lagim draws near."


func _on_continue_button_pressed():

	dialogue_stage += 1

	if QuestManager.story_stage == 0:

		if dialogue_stage == 1:

			dialogue_text.text = "A sacred fragment lies within the Ancient Grove."

		elif dialogue_stage == 2:

			dialogue_text.text = "Will you accept the quest?"

			continue_button.visible = false
			accept_button.visible = true
			decline_button.visible = true

	elif QuestManager.story_stage == 1:

		if dialogue_stage == 1:

			dialogue_text.text = "A corrupted wolf blocks the path ahead."

		elif dialogue_stage == 2:

			dialogue_text.text = "Will you hunt the corrupted beast?"

			continue_button.visible = false
			accept_button.visible = true
			decline_button.visible = true


func _on_accept_button_pressed():

	if QuestManager.story_stage == 0:

		QuestManager.start_quest("Recover Sacred Fragment")

		show_quest_popup(
			"QUEST ACCEPTED: Recover Sacred Fragment"
		)

	elif QuestManager.story_stage == 1:

		QuestManager.start_quest("Defeat Corrupted Wolf")

		show_quest_popup(
			"QUEST ACCEPTED: Defeat Corrupted Wolf"
		)

	accept_button.visible = false
	decline_button.visible = false

	close_dialogue()


func _on_decline_button_pressed():

	dialogue_text.text = "The forest will continue to suffer..."

	accept_button.visible = false
	decline_button.visible = false

	await get_tree().create_timer(2.0).timeout

	close_dialogue()


func close_dialogue():

	print("DIALOGUE CLOSED")

	dialogue_box.visible = false

	var player = get_parent().get_node("Player")
	player.can_move = true

	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func show_quest_popup(message):

	quest_popup.text = message

	quest_popup.visible = true

	await get_tree().create_timer(3.0).timeout

	quest_popup.visible = false
