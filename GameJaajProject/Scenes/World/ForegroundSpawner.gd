extends Node2D

var environment_resources = []
# Called when the node enters the scene tree for the first time.
func _ready():
    randomize()
    environment_resources.append(load("res://Scenes/World/Foreground/Torch.tscn"))
    $Timer.wait_time = 2.0
    $Timer.start()

func spawn_object(index):
    var clone = environment_resources[index].instance()
    add_child(clone)


func _on_Timer_timeout():
    spawn_object(0)
    $Timer.wait_time = (randi()%4 + 10)
    $Timer.start()
