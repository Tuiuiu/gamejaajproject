extends AudioStreamPlayer

onready var songs = [
    preload("res://Assets/SFX/hit.ogg"),
    preload("res://Assets/SFX/success.ogg"),
    preload("res://Assets/SFX/fail.ogg")
]

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func sequence_pressed(action):
    var play = true
    match action:
        "KEY_MISSED":
            stream = songs[2]
        _:
            stream = songs[0]
    
    if (play):
        play()

func failed_cast():
    stream = songs[2]
    play()
    
func success_cast():
    stream = songs[1]
    play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
