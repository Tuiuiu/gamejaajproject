extends Node

var sequences = {
    1: [KEY_B, KEY_N],
    2: [KEY_B, KEY_V],
    3: [KEY_V, KEY_B],
    4: [KEY_V, KEY_A],
    5: [KEY_A, KEY_C]
}
var possible_sequences = []
var best_match = null
var current_pos = 0
onready var _timer : Timer = $"Timer"

func _enter_tree():
    reset()

func reset():
    current_pos = 0
    possible_sequences = sequences.keys()
    best_match = null

func _input(event):
    _handleEvent(event)

func _handleEvent(event):
    if event is InputEventKey and event.pressed:
        var action : String
        print(possible_sequences)
        for id in possible_sequences:
            var sequence = sequences[id]
            if current_pos < sequence.size():
                if Input.is_key_pressed(sequence[current_pos]):
                    action = str(sequence[current_pos])
        if not action.empty():
            _validate_sequences(action)
        
func _validate_sequences(action):
    var new_possible_sequences : Array = []
    for id in possible_sequences:
        if str(sequences[id][current_pos]) == action:
            if sequences[id].size() > current_pos + 1:
                new_possible_sequences.append(id)
            else:
                best_match = id
                
    if new_possible_sequences.empty():
        reset()
    else:
        _timer.start(_timer.wait_time)
        possible_sequences = new_possible_sequences
        current_pos += 1

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
