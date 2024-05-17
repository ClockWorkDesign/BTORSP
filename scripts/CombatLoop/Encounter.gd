extends Object

class_name Encounter


# Constructor
func _init(encounterName: String, enemyNames: Array[String]):
	self.encounterName = encounterName
	self.enemyNames = enemyNames

#Used for defining encounters and where they may happen.

var encounterName : String
var enemyNames : Array[String]

func getShells() -> Array[GamePieceShell]:
	
	var shells : Array[GamePieceShell] = []
	
	for enemyName in enemyNames:
		shells.append(preload("res://scenes/CombatLoop/game_piece_shell.tscn").instantiate())
		var currentShell : GamePieceShell = shells.back()
		
		var gamePiece = GamePiece.new()
		
		CharacterConstants.getPreset(enemyName).applyTo(gamePiece)
		
		currentShell.initialize(gamePiece)
		
	
	return shells

