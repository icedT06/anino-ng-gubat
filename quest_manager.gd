extends Node

var current_quest = ""
var story_stage = 0

func start_quest(quest_name):

	current_quest = quest_name

	print("QUEST ACCEPTED: " + quest_name)

func complete_quest():

	print("QUEST COMPLETED: " + current_quest)

	current_quest = ""

	story_stage += 1

	print("CURRENT STORY STAGE: " + str(story_stage))