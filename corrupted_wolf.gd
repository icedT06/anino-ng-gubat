extends CharacterBody3D

var health = 3

func take_damage():

	health -= 1

	print("WOLF HP: ", health)

	if health <= 0:
		die()


func die():

	if QuestManager.current_quest == "Defeat Corrupted Wolf":

		QuestManager.complete_quest()

		var canvas = get_tree().get_first_node_in_group("ui")

		if canvas:
			canvas.show_quest_popup(
				"QUEST COMPLETED: Defeat Corrupted Wolf"
			)

	queue_free()