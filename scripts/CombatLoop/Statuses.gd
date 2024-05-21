extends Object

class_name Status

#by default, statusEffects decrease by 1 each turn


var myOwner : GamePiece

var ATK = 0
var attackModifiers = []

var SPD = 0
var speedModifiers = []

var DEF = 0
var defenceModifiers = []

var ACR = 0
var accuracyModifiers = []



var MaxMana = 0
var maxHealth = 1
var HP = 0
var MANA = 0

var statusEffects : Array = []

func apply(effect : String,amount : int):
	getEffect(effect).amount += amount
	pass

func has(effect : String):
	return getEffect(effect).amount > 0

func amount(effect : String):
	return getEffect(effect).amount

func getEffect(effect : String) -> StatusEffect:
	for status in statusEffects:
		if status.statusName == effect:
			return status
	
	return null

func initialize():
	
	HP = maxHealth
	MANA = MaxMana
	
	var sc = StatusConstants
	
	statusEffects.append(StatusEffect.new(
			sc.NULL,
			"Does nothing, but why?",
			func(statusEffects : Status): #what it will do when it is created.
				pass,
			func(statusEffects : Status,amount : int): #what it will do at the end of the turn.
				pass,
		)
	)
	
	statusEffects.append(StatusEffect.new(
		sc.STRONG,
		"Increases strength by X.",
		func(statusEffects : Status): #what it will do when it is created.
			attackModifiers.append(
				func (status,traitAmount): 
					return traitAmount/2.0 if status.has(sc.STRONG) else traitAmount
			)
			pass,
		func(statusEffects : Status,amount : int):
			pass,
		)
	)
	
	
	
	statusEffects.append(StatusEffect.new(
		sc.POISION,
		"Deals X damage each turn, ignoring DEF.",
		func(statusEffects : Status): #what it will do when it is created.
			pass,
		func(status : Status,amount : int): #what it will do at the end of the turn.
			status.takeDamageIgnoreDefence(amount)
			pass,
		)
	)
	
	statusEffects.append(StatusEffect.new(
			sc.WEAK,
			"Halves strength.",
			func(statusEffects : Status): #what it will do when it is created.
				attackModifiers.append(
					func (status,traitAmount): 
						return traitAmount/2.0 if status.has(sc.WEAK) else traitAmount
				)
				pass,
			func(statusEffects : Status,amount : int):
				pass,
		)
	)
	
	#
	#statusEffects.append(StatusEffect.new(
			#PARALIZED,
			#"Prevents attacks."
		#),
	#
	#statusEffects.append(StatusEffect.new(
			#HEALING,
			#"Heals X points each turn.",
			#func(statusEffects : Status): #what it will do when it is created.
				#pass,
			#func(statusEffects : Status,amount : int): #what it will do at the end of the turn.
				#statusEffects.heal(amount)
				#pass,
		#),
	#
	#statusEffects.append(StatusEffect.new(
			#ENRAGED,
			#"Triples strength when you are at 20% health or less.",
			#func(statusEffects : Status): #what it will do when it is created.
				#attackModifiers.append(
					#func (status,traitAmount): 
						#return traitAmount * 3.0 if status.has(ENRAGED) and float(HP)/float(maxHealth) < 0.2 else traitAmount
				#)
				#pass,
			#func(statusEffects : Status,amount : int):
				#pass,
		#),
	#
	#statusEffects.append(StatusEffect.new(
			#BOMBED,
			#"Deals 9999 damage to the inflicted when it runs out. Deals 30 damage to all of the inflicted's enemies.",
			#func(statusEffects : Status): #what it will do when it is created.
				#pass,
			#func(statusEffects : Status,amount : int): #what it will do at the end of the turn.
				#
				##if we're about to run out
				#if amount == 1:
					#statusEffects.takeDamageIgnoreDefence(999)
					#
					#for enemy in statusEffects.myOwner.getEnemies():
						#enemy.takeDamage(30)
					#
				#pass,
		#),
	#
	#statusEffects.append(StatusEffect.new(
			#SLOW,
			#"Halves speed.",
			#func(statusEffects : Status): #what it will do when it is created.
				#speedModifiers.append(
					#func (status,traitAmount): 
						#return int(traitAmount/2.0) if status.has(SLOW) else traitAmount
				#)
				#pass,
			#func(statusEffects : Status,amount : int):
				#pass,
		#),
	#
	#statusEffects.append(StatusEffect.new(
			#DRUNK,
			#"Halves speed, doubles strength, halves defence, and deals X sqaured damage.",
			#func(statusEffects : Status): #what it will do when it is created.
				#speedModifiers.append(
					#func (status,traitAmount): 
						#return int(traitAmount/2.0) if status.has(DRUNK) else traitAmount
				#)
				#
				#defenceModifiers.append(
					#func (status,traitAmount): 
						#return int(traitAmount/2.0) if status.has(DRUNK) else traitAmount
				#)
				#
				#attackModifiers.append(
					#func (status,traitAmount): 
						#return int(traitAmount * 2.0) if status.has(DRUNK) else traitAmount
				#)
				#pass,
			#func(statusEffects : Status,amount : int):
				#takeDamage(amount)
				#pass,
		#),
	#
	#statusEffects.append(StatusEffect.new(
			#CURSE_OF_KNOWLEDGE,
			#"Deals X percent of your max health each turn.",
			#func(statusEffects : Status): #what it will do when it is created.
				#pass,
			#func(statusEffects : Status,amount : int): #what it will do at the end of the turn.
				#
				#statusEffects.takeDamageIgnoreDefence(amount/100.0 * maxHealth)
				#pass,
		#),
	#
	#statusEffects.append(StatusEffect.new(
			#DEFENDED,
			#"Increases defence by X.",
			#func(statusEffects : Status): #what it will do when it is created.
				#defenceModifiers.append(
					#func (status,traitAmount): 
						#return traitAmount + statusDict[DEFENDED]
				#)
				#pass,
			#func(statusEffects : Status,amount : int):
				#pass,
		#),
	#
	#
	
	for statusEffect : StatusEffect in statusEffects:
		statusEffect.initLambda.call(self)
	


func applyEffects():
	
	for statusEffect : StatusEffect in statusEffects:
		statusEffect.effect.call(self,amount(statusEffect.statusName))
	
	for status : StatusEffect in statusEffects:
		status.decrement()

#strength is ADDED to physical attacks
func getStrength():
	var value = ATK
	for modifier in attackModifiers:
		value = modifier.call(self,value)
	return value

func getDefense():
	var value = DEF
	for modifier in defenceModifiers:
		value = modifier.call(self,value)
	return value

func getSpeed():
	var value = SPD
	for modifier in speedModifiers:
		value = modifier.call(self,value)
	return value

func getAccuracy():
	var value = ACR
	for modifier in accuracyModifiers:
		value = modifier.call(self,value)
	return value

func takeDamage(amount : int):
	if amount <= 0:
		return
	
	var damage = amount - getDefense()
	
	HP -= max(damage,1)
	pass

func heal(amount : int):
	HP += amount

func takeDamageIgnoreDefence(amount : int):
	
	HP -= amount
	pass

