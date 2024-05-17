extends Button

var myMove : Move

var shell :GamePieceShell

func assignMove(move : Move,shell : GamePieceShell):
	myMove = move
	self.shell = shell
	
	text = move.moveName
	
	pass


func _on_pressed():
	
	if myMove.canBeSelected.call(myMove):
		BattleStageGlobals.selectedPlayerMove = myMove
		
		myMove.onSelected.call(myMove)
		
	
	pass # Replace with function body.
