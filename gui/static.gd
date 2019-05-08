extends CanvasLayer


func _ready():
	
	# Sets up dialogue
	var box = get_node('dialogue')
	var speaker = get_node('dialogue/Panel/Speaker')
	var label = get_node('dialogue/Panel/HBoxContainer/Text')
	var portrait = get_node('dialogue/Portrait')
	var button_list = get_node('dialogue/Panel/VBoxContainer')
	Dialogue.init(box, speaker, label, portrait, button_list)
