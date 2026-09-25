extends Node3D

@onready var multi_mesh_instance_3d: MultiMeshInstance3D = $"../MultiMeshInstance3D"
var mesh_count = 500

const PINETREE_1_UNTITLED_007 = preload("uid://g3j3q4ghl31g")

func _ready() -> void:
	var multimesh = MultiMesh.new()
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	#probably how many onjects/meshes i want 
	multimesh.instance_count = mesh_count

	multimesh.mesh = PINETREE_1_UNTITLED_007


	for i in range(mesh_count):
		var trans_3d = Transform3D()
		var x = randf_range(-100,100)
		var z = randf_range(-100,100)
		
		# adds a raycasat 3d to each mesh 
		var quary = PhysicsRayQueryParameters3D.create(
			Vector3(x,1000,z),Vector3(x,-1000,z)
		)
		var result := get_world_3d().direct_space_state.intersect_ray(quary)
		# if the raycast is collidint move the mesh on top of that collider
		if result:
			trans_3d.origin  = Vector3(x, result.position.y, z)
		else:
			trans_3d.origin  = Vector3(x, 0, z)
		
		multimesh.set_instance_transform(i,trans_3d)
	multi_mesh_instance_3d.multimesh = multimesh
