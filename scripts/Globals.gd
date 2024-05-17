extends Node

func _ready():
	
	
	
	pass


var playerParty : Array[String] = [CharacterConstants.GEORGE,CharacterConstants.GEORGE]
func getPlayerPartyShells() -> Array[GamePieceShell]:
	
	var shells : Array[GamePieceShell] = []
	
	for name in playerParty:
		shells.append(preload("res://scenes/CombatLoop/game_piece_shell.tscn").instantiate())
		var currentShell : GamePieceShell = shells.back()
		
		var gamePiece = GamePiece.new()
		
		CharacterConstants.getPreset(name).applyTo(gamePiece)
		
		currentShell.initialize(gamePiece)
	
	return shells


