extends Node

# Currently supports continuous or choice
# continuous lets users click for the next dialogue node
# choice lets dialogue to branch depending on the clicked button 
var mode = 'continuous' 

# Nodes
var box
var speaker
var label
var portrait
var button_list

var all_dialogue = {}  # The entire textfile as JSON
var dict = {}  # A collection of nodes related contained by the current scene
var index = 1  # The current id of the dict pointing to a node, entry point always starts at 1

var PORTRAIT_FOLDER = "res://assets/portraits/"  # Path to folder where all portrait icons


func init(box, speaker, label, portrait, button_list):
	"""
	Inits the nodes.
	@param box: Main control node, used to toggle visibility
	@param speaker: Label containing name of current speaker
	@param label: Label containing displayed text
	@param portrait: TextureRect displaying image of current speaker
	@param button_list: VBoxContainer where children are buttons
	"""
	self.box = box
	self.speaker = speaker
	self.label = label
	self.portrait = portrait
	self.button_list = button_list

func on_press(next_index):
	"""
	Detects user input on clicking the textbox.
	@param next_index: Index of next node to go to
	"""
	self.index = next_index
	self.next()

func set_visibility(boolean):
	"""
	Sets visibility of the dialogue box.
	@param boolean: True or False
	"""
	self.box.visible = boolean

func is_visible():
	"""
	@return bool: Visible status of the dialogue box.
	"""
	return self.box.visible

func set_speaker(speaker):
	"""
	Sets the dialogue speaker.
	@param speaker: Name of speaker
	"""
	self.speaker.text = speaker

func set_text(text):
	"""
	Sets the dialogue text.
	@param text: Text to be displayed
	"""
	self.label.text = text

func set_portrait(path):
	"""
	Sets the dialogue portrait.
	@param path: Path to portrait icon
	"""
	if path == null:
		self.portrait.set_texture(null)
		return
	var texture = load(path)
	self.portrait.set_texture(texture)

func create_button(text, id):
	"""
	Create a button when the dialogue mode is 'choice'. 
	@param text: The text of the button
	@param id: The unique id of which node clicking the button leads to
	"""
	var node = Button.new()
	node.set_text(text)
	node.connect("pressed", self, "on_press", [id])
	self.button_list.add_child(node)

func free_buttons():
	"""
	Frees the buttons after use.
	"""
	for node in self.button_list.get_children():
		node.queue_free()

func load_textfile(path):
	"""
	Loads a text file into memory.
	@param path: Path where the JSON is located
	"""
	var file = File.new()
	file.open(path, file.READ)
	var text = file.get_as_text()
	self.all_dialogue = JSON.parse(text).result
	file.close()

func start(dialogue_id):
	"""
	Starts a dialgoue.
	@param dialogue_id: Id of a collection of nodes
	"""
	self.set_visibility(true)
	self.dict = self.all_dialogue[dialogue_id]
	self.next()

func load_dialogue(content):
	"""
	Loads a simple dialogue.
	@param content: Dictionary of information to display
	"""
	self.mode = 'continuous'
	var speaker = content['speaker']
	if speaker != null:
		self.set_speaker(speaker)	
	else:
		self.set_speaker("")
	if content['portrait'] != null:
		var portrait = self.PORTRAIT_FOLDER + content['portrait']
		self.set_portrait(portrait)
	else:
		self.set_portrait(null)
	self.set_text(content['text'])
	self.index = content['next']
	
func load_choices(content):
	"""
	Loads a single dialogue choice.
	@param content: Dictionary of information to display
	"""
	self.mode = 'choice'
	self.button_list.visible = true
	var speaker = content['speaker']
	if speaker != null:
		self.set_speaker(speaker)	
	else:
		self.set_speaker("")
	if content['portrait'] != null:
		var portrait = self.PORTRAIT_FOLDER + content['portrait']
		self.set_portrait(portrait)
	else:
		self.set_portrait(null)
	self.set_text(content['text'])
	
	for i in range(0, content['choices'].size()):
		self.create_button(content['choices'][str(i)], content['next'][str(i)])
	
func next():
	"""
	Calls the load functions to put the next scene node onscreen.
	@return: Current position of the dialogue node
	"""
	self.free_buttons()
	if self.index < 0: # End of dialogue, reset until next start() is called
		var value = self.index
		self.dict = {}
		self.index = 1
		self.set_visibility(false)
		return value
	var content = dict[str(index)]
	if(content['type'] == 'continuous'):
		self.load_dialogue(content)
	elif(content['type'] == 'choice'):
		self.load_choices(content)
	return self.index
