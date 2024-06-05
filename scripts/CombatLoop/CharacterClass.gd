extends Object

class_name CharacterClass

#determines what skills the character unlocks at different levels

func _init(className: String, atkUp: int = 0, spdUp: int = 0, defUp: int = 0, acrUp: int = 0, skillUnlocks: Dictionary = {}):
	ClassName = className
	ATKUP = atkUp
	SPDUP = spdUp
	DEFUP = defUp
	ACRUP = acrUp
	SkillUnlocks = skillUnlocks

var ClassName

var ATKUP = 0
var SPDUP = 0
var DEFUP = 0
var ACRUP = 0

#max level is 20 for now. relates the level to the name (a string) of the skill it unlocks
var SkillUnlocks : Dictionary = {}

func levelPieceUp(gamePiece : GamePiece):
	gamePiece.level += 1
	
	var st = gamePiece.status
	st.ATK += ATKUP
	st.DEF += DEFUP
	st.SPD += SPDUP
	st.ACR += ACRUP
	
	if SkillUnlocks.keys().has(gamePiece.level):
		if !gamePiece.hasMove(SkillUnlocks[gamePiece.level]):
			gamePiece.moves.append(SkillUnlocks[gamePiece.level])
	

