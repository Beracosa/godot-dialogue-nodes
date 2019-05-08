extends Node2D


func _ready():
	
	# Load textfile whenever a new set of dialogues are needed
	Dialogue.load_textfile("res://assets/dialogues/example.json")
	
	# Call start on currently loaded textfile
	Dialogue.start("intro")
