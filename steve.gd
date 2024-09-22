extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 12
const ROTATION_DEGREE = 90

var xform: Transform3D

func _physics_process(delta: float) -> void:

	# rotate the camera left / right
	if Input.is_action_pressed("cam_left"):
		$Camera_Controller.rotate_y(deg_to_rad(ROTATION_DEGREE*delta))

	if Input.is_action_pressed("cam_right"):
		$Camera_Controller.rotate_y(deg_to_rad(-ROTATION_DEGREE * delta))

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	# New Vector3 direction, taking into account the user arrow inputs and the camera rotation
	var direction : Vector3 = ($Camera_Controller.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	# Rotate the character mesh so oriented towards the direction moving in relation to the camera
	if input_dir != Vector2.ZERO:
		$MeshInstance3D.rotation_degrees.y = $Camera_Controller.rotation_degrees.y - rad_to_deg(input_dir.angle()) - 90

	# rotate the character to align with the floor
	if is_on_floor() and input_dir != Vector2.ZERO:
		align_with_floor($RayCast3D.get_collision_normal())
		global_transform =global_transform.interpolate_with(xform, 0.3)
	else:
		align_with_floor(Vector3.UP)
		global_transform =global_transform.interpolate_with(xform, 0.3)


	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

	#Make Camera Controller Match the position of myself
	$Camera_Controller.position = lerp($Camera_Controller.position, position, 0.1)


func align_with_floor(floor_normal: Vector3) -> void:
	xform = global_transform
	xform.basis.y = floor_normal
	xform.basis.x = -xform.basis.z.cross(floor_normal)
	xform.basis = xform.basis.orthonormalized()


func _on_fall_zone_body_entered(body: Node3D) -> void:
	print(body)
	get_tree().change_scene_to_file("res://level_1.tscn")
