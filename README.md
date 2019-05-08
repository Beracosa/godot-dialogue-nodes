# godot-dialogue-nodes
Simple Godot singleton to process dialogues using JSON textfiles.

<img src="https://raw.githubusercontent.com/Zopyrion/godot-dialogue-nodes/master/docs/example.png" width="600">

## Usage

Clone files and place under root res://.

Enable singleton for dialogue and static so they are autoloaded and accessible anywhere.

<img src="https://raw.githubusercontent.com/Zopyrion/godot-dialogue-nodes/master/docs/singleton.png" width="600">

To load a new JSON textfile.
```
Dialogue.load_textfile("res://path/file.json")
```
	
To load a dialogue node.
```
Dialogue.start("dialogue_id")
```
Check out sample.json to see how JSON should be formatted.
