extends Node2D

var path
var environment_resources = []
# Called when the node enters the scene tree for the first time.
func _ready():
    randomize()
    path = $PathToFollow
    environment_resources.append(load("res://Scenes/World/Foreground/Torch.tscn"))
    $Timer.wait_time = 2.0
    $Timer.start()

func spawn_object(index):
    var clone = environment_resources[index].instance()
    path.add_child(clone)

func _on_Timer_timeout():
    spawn_object(0)
    $Timer.wait_time = (randi()%4 + 10)
    $Timer.start()

func stop_motion():
    $Timer.paused = true
    for torch in $PathToFollow.get_children():
        torch.stop_motion()
    
func resume_motion():
    $Timer.paused = false
    for torch in $PathToFollow.get_children():
        torch.resume_motion()
