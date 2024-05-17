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

func initialize(gamePiece : GamePiece):
	
	self.gamePiece = gamePiece
	
	moves.clear()
	
	moves.append(MoveConstants.getConstant(MoveConstants.DO_NOTHING))
	var newMove = moves.back()
	newMove.myOwner = gamePiece
	newMove.shell = self
	selectedMove = newMove
	
	for moveName in gamePiece.moves:
		
		moves.append(MoveConstants.getConstant(moveName))
		newMove = moves.back()
		newMove.myOwner = gamePiece
		newMove.shell = self
		
	
	
	
	$sprite.texture = load(gamePiece.spritePath)
	
	pass

func getMoveButtons():
	
	var buttons = []

	for move in moves:
		var newButton = preload(PathConstants.moveButton).instantiate()
		newButton.assignMove(move, self)
		buttons.append(newButton)
		
	
	return buttons
	

func beSelected():
	
	BattleStageGlobals.selectedPlayerPiece = self
	BattleStageGlobals.selectedPlayerMove = selectedMove
	
	BattleStageGlobals.movesDisplay.takeMoveButtons(getMoveButtons())
	
	pass

func _on_target_button_pressed():
	
	if Input.is_action_just_released("rightClick"):
		beSelected()
		return
	
	if !BattleStageGlobals.selectedPlayerPiece.playerControlled:
		return
	
	if BattleStageGlobals.selectedPlayerMove != null:
		BattleStageGlobals.selectedPlayerMove.toggleTarget(gamePiece)
	
	pass # Replace with function body.


