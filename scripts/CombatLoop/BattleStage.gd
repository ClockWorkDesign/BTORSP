extends Node

class_name Stage

#the player's gamepieces
var playerPieces = []

#the enemy's pieces
var enemyPieces = []

@export var encounterName : String = ""

var encounter : Encounter

func _ready():
	
	encounter = EncounterConstants.getConstant(encounterName) 
	
	var i = -1
	for shell in encounter.getShells():
		i += 1
		%characters.add_child(shell)
		shell.global_position = %EnemyPositions.get_child(i).global_position
		shell.playerControlled = false
		shell.isEnemy = true
		enemyPieces.append(shell)
		shell.gamePiece.stage = self
	
	i = -1
	for shell in Globals.getPlayerPartyShells():
		i += 1
		%characters.add_child(shell)
		shell.global_position = %PlayerPositions.get_child(i).global_position
		
		shell.beSelected()
		playerPieces.append(shell)
		shell.gamePiece.stage = self
	
	startTurn()
	


func _on_end_turn_pressed():
	
	var shells = %characters.get_children()
	
	while shells.size() > 0:
		shells.shuffle()
		shells.sort_custom(sort_ascending)
		
		shells.front().selectedMove.apply.call(shells.front().selectedMove)
		
		shells.pop_front()
		
	
	for piece in getEveryone():
		piece.onTurnEnd()
	
	for piece in enemyPieces: if piece.dead: enemyPieces.erase(piece)
	for piece in playerPieces: if piece.dead: playerPieces.erase(piece)
	
	
	
	startTurn()
	

func startTurn():
	
	for piece in playerPieces:
		
		piece.gamePiece.AILambdaTargetSelect.call(piece.gamePiece)
		
		pass
	
	for piece in enemyPieces:
		
		piece.gamePiece.AILambdaTargetSelect.call(piece.gamePiece)
		
		pass
		
	
	pass

func sort_ascending(a : GamePieceShell, b):
	if a.gamePiece.status.getSpeed() < a.gamePiece.status.getSpeed():
		return true
	return false

func getEveryone():
	var everyone : Array = enemyPieces.duplicate()
	everyone.append_array(playerPieces)
	return everyone


