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

var spritePath

var maxHealth
var maxMana

var startingLevel

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
	st.maxHealth = maxHealth
	
	gp.moves = moves
	gp.name = characterName
	
	gp.level = 0
	while gp.level < startingLevel:
		gp.levelUp()
	
	
