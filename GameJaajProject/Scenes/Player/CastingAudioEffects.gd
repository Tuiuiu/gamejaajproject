extends AudioStreamPlayer

onready var songs = [
    preload("res://Assets/Sounds/i.wav"),
    preload("res://Assets/Sounds/ri.wav"),
    preload("res://Assets/Sounds/jo.wav"),
    preload("res://Assets/Sounds/q.wav")
]

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func sequence_pressed(action):
    var play = true
    match action:
        # R
        "82":
            stream = songs[0]
        # F
        "70":
            stream = songs[1]
        # B
        "66":
            stream = songs[2]
        "KEY_MISSED":
            stream = songs[3]
        _:
            play = false
    
    if (play):
        play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
