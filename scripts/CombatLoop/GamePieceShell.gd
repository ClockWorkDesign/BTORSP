extends Node2D

class_name GamePieceShell 

var playerControlled = true

var gamePiece : GamePiece

var moves : Array[Move] 

var selectedMove : Move = null

var isEnemy = false


func _process(delta):
	
	$NameAndLevel.text = "LVL " + str(gamePiece.level) + " " + gamePiece.name
	$stats.text = ("HP: " + str(gamePiece.status.HP) + "\n" +
	"MP: " + str(gamePiece.status.MANA) + "\n" +
	"STR: " + str(gamePiece.status.getStrength()) + "\n" +
	"DEF: " + str(gamePiece.status.getDefense()) + "\n" +
	"SPD: " + str(gamePiece.status.getSpeed()) + "\n" +
	"ACR: " + str(gamePiece.status.getAccuracy()) + "\n"
	)
	$selectedParticles.emitting = BattleStageGlobals.selectedPlayerPiece == self
	
	pass

func initialize(gamePiece : GamePiece):
	
	self.gamePiece = gamePiece
	gamePiece.shell = self
	
	gamePiece.status.initialize()
	
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

"""
Updates the arrows that point at the enemies
"""
func updateTargetArrows(targets : Array[GamePiece],move : Move):
	
	for child in $ArrowsHolder.get_children():
		child.queue_free()
	
	for gamePiece in targets:
		var targetPos = gamePiece.shell.global_position
		var newArrow = preload(PathConstants.attackArrow).instantiate()
		$ArrowsHolder.add_child(newArrow)
		newArrow.setTarget(targetPos,move)
		
		
		
	
	
	
	pass
