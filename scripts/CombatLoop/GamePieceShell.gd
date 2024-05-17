extends Node2D

class_name GamePieceShell 

var gamePiece : GamePiece

var selectedMove : Move = null

func _process(delta):
	
	$NameAndLevel.text = "LVL " + str(gamePiece.level) + " " + gamePiece.name
	$hp.text = "HP: " + str(gamePiece.status.HP)
	
	pass


func _on_target_button_pressed():
	
	if Input.is_action_pressed("ctrl"):
		BattleStageGlobals.selectedPlayerPiece = self
		BattleStageGlobals.selectedPlayerMove = selectedMove
		return
	
	if BattleStageGlobals.selectedPlayerMove != null:
		BattleStageGlobals.selectedPlayerMove.toggleTarget(gamePiece)
	
	pass # Replace with function body.
