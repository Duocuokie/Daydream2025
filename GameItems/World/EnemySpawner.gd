class_name EnemySpawner extends Node2D

@export var graphs : Array[Curve]

@onready var spawners : Array[Node2D] = [%Enemy1, %Enemy2, %Enemy3, %Enemy4] 
@onready var pools : Array[Node2D] = [%Enemies1, %Enemies2, %Enemies3, %Enemies4]

var time := 0
func _on_timer_timeout() -> void:
	for i in len(spawners):
		if floor(graphs[i].sample(time)) > pools[i].get_child_count():
			var spawner := spawners[i].get_child(0)
			spawner.spawn(spawner.global_position, pools[i])
			spawners[i].rotate(randf_range(1.0, 4.0))
	if time < 180:
		time += 1
