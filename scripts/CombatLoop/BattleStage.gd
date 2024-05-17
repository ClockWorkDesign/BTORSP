extends Node

class_name Stage

#the player's gamepieces
var playerPieces

#the enemy's pieces
var enemyPieces

@export var encounterName : String = ""

var encounter : Encounter

func _ready():
	
	BattleStageGlobals.movesDisplay = %MovesDisplay
	
	encounter = EncounterConstants.getConstant(encounterName) 
	
	var i = -1
	for shell in encounter.getShells():
		i += 1
		%characters.add_child(shell)
		shell.global_position = %EnemyPositions.get_child(i).global_position
	
	i = -1
	for shell in Globals.getPlayerPartyShells():
		i += 1
		%characters.add_child(shell)
		shell.global_position = %PlayerPositions.get_child(i).global_position
		
		BattleStageGlobals.selectedPlayerPiece = shell
		
	
	
