extends Area3D

const ROT_SPEED:= 2.0 # numbers of degrees to coin rotates every frame

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	delta = delta
	self.rotate_y(deg_to_rad(ROT_SPEED))

# this is a signal
func _on_body_entered(body:Node3D) -> void:
	body = body
	queue_free()
