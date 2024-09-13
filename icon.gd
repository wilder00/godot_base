extends Sprite3D

var coin: int = 5
var coin_name: String = "robot"
var heart:float = 3.5
const SPEED:=2
var x = coin + SPEED
var is_good: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print('Start Game')
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	const SPEED_ROTATION:=45
	const RADIANT_ANGLE = deg_to_rad(SPEED_ROTATION)
	# self.rotate_y(RADIANT_ANGLE * delta)
	if is_good:
		print('is good')
	else :
		print('is bad')

	if Input.is_action_pressed("ui_left"):
		rotate_y(RADIANT_ANGLE * delta)

	if Input.is_action_pressed("ui_right"):
		rotate_y(-RADIANT_ANGLE * delta)
	