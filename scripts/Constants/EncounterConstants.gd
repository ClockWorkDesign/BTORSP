extends Node

const GEORGE_AMBUSH = "GEORGE_AMBUSH"

var list : Array[Encounter] = []

func getConstant(constantName : String) -> Encounter:
	var list = getList()
	
	for constant in list:
		if constant.encounterName == constantName:
			return constant
	
	return null

func getList() -> Array[Encounter]:
	if list.size() > 0:
		return list
	
	var cc = CharacterConstants
	
	list.append(Encounter.new(
		GEORGE_AMBUSH,
		[cc.GEORGE]
		)
	)
	
	
	
	return list
