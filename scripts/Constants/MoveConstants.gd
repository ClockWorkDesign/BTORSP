extends Node

const DO_NOTHING = "DO_NOTHING"

#Fighter Moves
const PUNCH = "PUNCH"
const STRENGTHEN = "STRENGTHEN"
const BLIND_RAGE = "BLIND_RAGE"
const RECKLESS_CHARGE = "RECKLESS_CHARGE"

#Ranger Moves
const SHOOT_ARROW = "SHOOT_ARROW"
const POISION_ARROW = "POISION_ARROW"
const BLOODY_ARROW = "BLOODY_ARROW"


#Healer Moves
const HEAL = "HEAL"
const WEAKEN = "WEAKEN"


# goblin moves
const STAB = "STAB"
const STAB_WEAKNESS = "STAB_WEAKNESS"



var list : Array[Move] = []

func getConstant(moveName : String) -> Move:
	var list = getList()
	
	for move in list:
		if move.moveName == moveName:
			return move.clone()
	
	return null

func getList() -> Array[Move]:
	if list.size() > 0:
		return list
	
	list.append(Move.new(
			DO_NOTHING, #name
			"Does nothing.", #Summary
			0, #maxTargets
			false, #retargetable
			false, #defaultTargetAllEnemies
			false, #defaultTargetAllAllies
			func (this : Move):
				
				pass
				, #apply lambda, what it does when it's applied. 
			#code that it runs by default when selected.
		)
	)
	
	list.append(Move.new(
			PUNCH, #name
			"Deals 4 + STRENGTH damage.", #Summary
			1, #maxTargets
			true, #retargetable
			false, #defaultTargetAllEnemies
			false, #defaultTargetAllAllies
			func (this : Move):
				this.targets[0].takeDamage(4 + this.myOwner.status.getStrength())
				pass
				, #apply lambda, what it does when it's applied. 
			#code that it runs by default when selected.
		)
	)
	
	list.append(Move.new(
			SHOOT_ARROW, #name
			"Deals 8 + ACCURACY damage.",
			1, #maxTargets
			true, #retargetable
			false, #defaultTargetAllEnemies
			false, #defaultTargetAllAllies
			func (this : Move):
				this.targets[0].takeDamage(8 + this.myOwner.status.getAccuracy())
				pass
				, #apply lambda, what it does when it's applied. 
			#code that it runs by default when selected.
		)
	)
	
	list.append(Move.new(
			STAB, #name
			"Deals 8 + STRENGTH / 2 damage.", #Summary
			1, #maxTargets
			true, #retargetable
			false, #defaultTargetAllEnemies
			false, #defaultTargetAllAllies
			func (this : Move):
				this.targets[0].takeDamage(8 + this.myOwner.status.getStrength() / 2)
				pass
				, #apply lambda, what it does when it's applied. 
			#code that it runs by default when selected.
		)
	)
	
	list.append(Move.new(
			STAB_WEAKNESS, #name
			"Deals 7 + STRENGTH / 3 damage, applies +2 Weakness", #Summary
			1, #maxTargets
			true, #retargetable
			false, #defaultTargetAllEnemies
			false, #defaultTargetAllAllies
			func (this : Move):
				this.targets[0].takeDamage(7 + this.myOwner.status.getStrength() / 3)
				this.targets[0].status.apply(StatusConstants.WEAK, 2)
				pass
				, #apply lambda, what it does when it's applied. 
			#code that it runs by default when selected.
		)
	)
	
	return list

