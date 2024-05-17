extends Node2D

func setTarget(targetPosition : Vector2,move : Move):
	
	%Label.text = move.moveName
	
	var differenceVector = targetPosition - global_position
	
	%arrowShaft.size.x = differenceVector.length() - 30
	
	look_at(targetPosition)
	
	%tip.global_position = targetPosition + -differenceVector.normalized()
	%tip.look_at(targetPosition)
	

