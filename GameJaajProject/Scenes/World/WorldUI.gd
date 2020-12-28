extends Control

onready var world = get_parent()
var paused = false

func _ready():
    pass # Replace with function body.

func _process(delta):
    if (Input.is_action_just_pressed("ui_cancel")):
        if (paused):
            paused = false
            world.resume_game()
        else:
            paused = true
            world.pause_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
