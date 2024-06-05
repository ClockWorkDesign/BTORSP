extends Object

class_name CharacterPreset

func _init(
	characterName: String,
	characterDescription : String,
	spritePath : String,
	characterClass : String,
	startingLevel : int,
	maxHealth: int,
	maxMana: int,
	ATK: int,
	SPD: int,
	DEF: int,
	ACR: int,
	moves: Array[String]
) -> void:
	self.characterName = characterName
	self.characterDescription = characterDescription
	self.spritePath = spritePath
	self.characterClass = characterClass
	self.startingLevel = startingLevel
	self.maxHealth = maxHealth
	self.maxMana = maxMana
	self.ATK = ATK
	self.SPD = SPD
	self.DEF = DEF
	self.ACR = ACR
	self.moves = moves

var characterName
var characterDescription
var characterClass : String


#called when the character is an enemy at the start of each turn 
var AILambdaTargetSelect : Callable = func(this : GamePiece):
	
	var shell : GamePieceShell = this.shell
	var moves = shell.moves.duplicate() #get rid of "do_nothing"
	var do_nothing = moves[0]
	moves.remove_at(0)
	moves.shuffle()
	this.shell.selectedMove = moves.front() if moves.size() > 0 else do_nothing
	
	var move : Move = shell.selectedMove
	move.onSelected.call(move)
	
	if move.targets.size() == 0:
		var targets : Array = this.getEveryone()
		if move.cannotTargetAllies():
			targets = this.getEnemies()
		if move.cannotTargetEnemies():
			targets = this.getAllies()
		
		var possibleTargets = targets.duplicate()
		
		possibleTargets.shuffle()
		while  move.targets.size() < move.maxTargets and possibleTargets.size() > 0:
			move.toggleTarget(possibleTargets.front().gamePiece)
			possibleTargets.remove_at(0)
		
	
	shell.updateTargetArrows(move.targets,move)

var spritePath

var maxHealth
var maxMana

var startingLevel

#starting
var ATK = 0
var SPD = 0
var DEF = 0
var ACR = 0

var moves : Array[String] = [] #list of strings

func applyTo(gp : GamePiece):
	var st = gp.status
	
	gp.spritePath = spritePath
	
	gp.characterClass = CharacterClassConstants.getClass(characterClass)
	
	st.ATK = ATK
	st.SPD = SPD
	st.DEF = DEF
	st.ACR = ACR
	
	st.maxHealth = maxHealth
	
	gp.moves = moves
	gp.name = characterName
	
	gp.level = 0
	while gp.level < startingLevel:
		gp.levelUp()
	
	gp.AILambdaTargetSelect = AILambdaTargetSelect
	
