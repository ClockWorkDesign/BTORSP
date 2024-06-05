extends Button

var myMove : Move

var shell : GamePieceShell

func _physics_process(delta):
	
	var selected = shell.selectedMove == myMove
	
	if selected:
		text = myMove.moveName + " (Selected)"
	else:
		text = myMove.moveName
	
	pass

func assignMove(move : Move,shell : GamePieceShell):
	myMove = move
	self.shell = shell
	
	text = move.moveName
	
	pass


func _on_pressed():
	
	BattleStageGlobals.movesDisplay.displayDescription(myMove)
	
	if !shell.playerControlled:
		return
	
	if myMove.canBeSelected.call(myMove):
		BattleStageGlobals.selectedPlayerMove = myMove
		
		myMove.targets.clear()
		
		myMove.onSelected.call(myMove)
		
		shell.selectedMove = myMove
	
	pass # Replace with function body.
