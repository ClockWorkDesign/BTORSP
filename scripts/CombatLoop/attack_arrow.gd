extends Node2D



func setTarget(targetPosition : Vector2,move : Move):
	
	%Label.text = move.moveName
	
	var differenceVector = targetPosition - global_position
	
	%arrowShaft.size.x = differenceVector.length() - 30
	
	look_at(targetPosition)
	
	%tip.global_position = targetPosition + -differenceVector.normalized()
	%tip.look_at(targetPosition)
	
	
	modulate = string_to_color(move.moveName)
	

func string_to_color(input_string: String) -> Color:
	
	var hash: int = 0
	for i in range(input_string.length()):
		var char_code: int = ord(input_string.substr(i, 1))
		
		hash = (hash * 31 + char_code) & 0xFFFFFFFF
	
	# Ensure the hash is within the range of a 6-digit hex color
	hash = hash & 0xFFFFFF
	
	# Convert the hash to a 6-digit hexadecimal string
	var color_hex = ""
	var hex_chars = "0123456789ABCDEF"
	for j in range(6):
		var hex_digit = (hash >> (4 * (5 - j))) & 0xF
		color_hex += hex_chars[hex_digit]
	
	# Create a Color object from the hex code
	var color = Color(color_hex,1.0)
	
	return color

# Utility function to get the ASCII value of a character
func ord(char: String) -> int:
	return char.to_utf8_buffer()[0]
