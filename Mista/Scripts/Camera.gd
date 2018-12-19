extends Camera2D

# Looks at cannon if no cannonball
# Otherwise looks at cannon

var target
var speed = .2

func _process(delta):
	var cannons = get_tree().get_nodes_in_group('cannon')
	var cannonballs = .get_tree().get_nodes_in_group('cannonball')
	if cannonballs.size() > 0:
		target = cannonballs[0]
	elif cannons.size() > 0:
		target = cannons[0]
	
	if target:
		position = position.linear_interpolate(target.position, speed)