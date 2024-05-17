extends Object

class_name Move

var myOwner : GamePiece
var shell : GamePieceShell

func _init(name: String, summary : String, maxTargets: int, retargetable: bool, defaultTargetAllEnemies: bool, defaultTargetAllAllies: bool, apply: Callable, onSelected: Callable = onSelected) -> void:
	moveName = name
	self.summary = summary
	self.maxTargets = maxTargets
	self.retargetable = retargetable
	self.defaultTargetAllEnemies = defaultTargetAllEnemies
	self.defaultTargetAllAllies = defaultTargetAllAllies
	self.apply = apply
	self.onSelected = onSelected
	

func cannotTargetAllies() -> Move:
	canTargetAllies = false
	return self
func cannotTargetEnemies() -> Move:
	canTargetEnemies = false
	return self

func setManaCost(amount: int) -> Move:
	manaCost = amount
	return self

func setCanBeSelected(canBeSelectedLambda : Callable) -> Move:
	canBeSelected = canBeSelectedLambda
	return self

var moveName = ""
var summary = ""

#only affect UI
var maxTargets = 1
var canTargetAllies = true
var canTargetEnemies = true
var retargetable = true

var defaultTargetAllEnemies = false
var defaultTargetAllAllies = false

var manaCost = 0

var targets : Array[GamePiece] = []

var canBeSelected : Callable = func(this : Move):
	if this.myOwner.status.MANA >= manaCost:
		return true
	
	return false

#called when the player selects this move
var onSelected : Callable = func(this : Move):
	
	this.targets.clear()
	
	if defaultTargetAllEnemies:
		for target in this.myOwner.getEnemies():
			this.targets.append(target)
	if defaultTargetAllAllies:
		for target in this.myOwner.getAllies():
			this.targets.append(target)
	pass

#what the move does when applied
var apply : Callable = func(this : Move):
	
	pass

func toggleTarget(gamePiece : GamePiece):
	
	if targets.has(gamePiece):
		targets.remove_at(targets.find(gamePiece))
	else:
		targets.append(gamePiece)
	
	pass


