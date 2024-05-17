extends Node2D

class_name GamePieceShell 

var playerControlled = true

var gamePiece : GamePiece

var moves : Array[Move] 

var selectedMove : Move = null

func _process(delta):
	
	$NameAndLevel.text = "LVL " + str(gamePiece.level) + " " + gamePiece.name
	$hp.text = "HP: " + str(gamePiece.status.HP)
	
	
	$selectedParticles.emitting = BattleStageGlobals.selectedPlayerPiece == self
	
	pass


func getMoves():
	
	var buttons = []
	
	for move in moves:
		var newButton = preload(PathConstants.moveButton).instantiate()
		
		newButton.assignMove(move, self)
		
		buttons.append(newButton)
		pass
	
	return buttons
	

func _on_target_button_pressed():
	
	if Input.is_action_pressed("ctrl") and playerControlled:
		BattleStageGlobals.selectedPlayerPiece = self
		BattleStageGlobals.selectedPlayerMove = selectedMove
		return
	
	if BattleStageGlobals.selectedPlayerMove != null:
		BattleStageGlobals.selectedPlayerMove.toggleTarget(gamePiece)
	
	pass # Replace with function body.
