extends Control

class_name MovesDisplay

func _ready():
	BattleStageGlobals.movesDisplay = self
	pass

"""
Moves should be a list of buttons gotten from the selected gamepiece shell.
"""
func takeMoveButtons(moves):
	
	for child in %MovesDisplayFlow.get_children():
		child.queue_free()
	
	for move in moves:
		%MovesDisplayFlow.add_child(move)
	
	
	pass

"""
Displays the name and description of a move.
"""
func displayDescription(move : Move):
	
	%RichTextLabel.text = move.moveName + "\n" + move.summary
	
	pass
