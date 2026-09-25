extends Node3D

@onready var multi_mesh_instance_3d: MultiMeshInstance3D = $"../MultiMeshInstance3D"
@onready var multi_mesh_instance_3d_2: MultiMeshInstance3D = $"../MultiMeshInstance3D2"

var mesh_count = 5000
@onready var cube: MeshInstance3D = $"../cube"
@onready var cube_2: MeshInstance3D = $"../cube2"


func generate_multimesh():
	var local_mesh_count = 50000
	var multimesh = MultiMesh.new()
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	
	#probably how many onjects/meshes i want 
	multimesh.instance_count = local_mesh_count

	multimesh.mesh = cube_2.mesh


	for i in range(local_mesh_count):
		var trans_3d = Transform3D()
		var x = randf_range(0,16)
		var y = randf_range(0,100)
		var z = randf_range(0,16)
		trans_3d.origin  = Vector3(x, y, z)
		

		multimesh.set_instance_transform(i,trans_3d)
	return multimesh

func _ready() -> void:
	var multimesh = MultiMesh.new()
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	
	#probably how many onjects/meshes i want 
	multimesh.instance_count = mesh_count

	multimesh.mesh = cube.mesh


	for i in range(mesh_count):
		var trans_3d = Transform3D()
		var x = randf_range(0,16)
		var y = randf_range(0,16)
		var z = randf_range(0,16)
		trans_3d.origin  = Vector3(x, y, z)
		
		
		
		# adds a raycasat 3d to each mesh 
		#var quary = PhysicsRayQueryParameters3D.create(
			#Vector3(x,1000,z),Vector3(x,-1000,z)
		#)
		#var result := get_world_3d().direct_space_state.intersect_ray(quary)
		## if the raycast is collidint move the mesh on top of that collider
		#if result:
			#trans_3d.origin  = Vector3(x, result.position.y, z)
		#else:
			#trans_3d.origin  = Vector3(x, 0, z)
		
		multimesh.set_instance_transform(i,trans_3d)
	multi_mesh_instance_3d.multimesh = multimesh
	#multi_mesh_instance_3d_2.multimesh = generate_multimesh()
