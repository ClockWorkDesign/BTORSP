extends Button

var myMove : Move

var shell :GamePieceShell




func _on_pressed():
	
	if myMove.canBeSelected.call(myMove):
		BattleStageGlobals.selectedPlayerMove = myMove
	
	pass # Replace with function body.
