extends Area3D

func _on_body_entered(body):

	if body.name == "Player":

		QuestManager.complete_quest()

		var canvas = get_tree().get_first_node_in_group("ui")

		canvas.show_quest_popup(
			"QUEST COMPLETED: Recover Sacred Fragment"
		)

		queue_free()
