extends Node2D

# Cannon swivels and shoots a cannonball
# Also can relocate to a new position once the ball lands
# The body element is the entire cannon and is the element that rotates
# The rotation of the cannon sets the *rough* direction the cannon will fire in

var swivel_speed = 0.01 * 60
var angle_min = -PI / 4
var angle_max = PI / 4
var angle = 0
var has_fired = false

func _process(delta):
	# Get input for swiveling
	var pi = Input.is_action_pressed("cannon_swivel_pos")
	var ni = Input.is_action_pressed("cannon_swivel_neg")
	var i = sign(float(pi) - float(ni))
	if abs(i) > 0:
		swivel(delta * i)
	
	# Get Input and then fire if approp (only once)
	var doFire = Input.is_action_just_pressed("cannon_fire")
	if doFire and not has_fired:
		fire()
		has_fired = true

# Equips cannon to fire again
func reload():
	has_fired = false

# Create a cannonball and some fx and stuff
func fire():
	pass

# Relocate moves the cannon to a specific position
# Will eventually play an animation as well
func relocate(target_position):
	position = target_position

# Swivel takes input from -1 to 1
func swivel(amount):
	# Adjust aiming angle
	angle += amount * swivel_speed
	if angle < angle_min + 0.05:
		angle = lerp(angle, angle_min + 0.1, .1)
	if angle > angle_max - 0.05:
		angle = lerp(angle, angle_max - 0.1, .1)
	angle = clamp(angle, angle_min, angle_max)
	get_node('Body').rotation = rotation + angle