extends Node

var sequences = {
    1: [KEY_R, KEY_F, KEY_B],
    2: [KEY_B, KEY_F, KEY_B],
    3: [KEY_G, KEY_F, KEY_B]
}
var possible_sequences = []
var best_match = null
var current_pos = 0
onready var player = get_parent()
onready var _timer : Timer = $"Timer"

func _enter_tree():
    reset()

func _input(event):
    _handleEvent(event)

func _handleEvent(event):
    if event is InputEventKey and event.pressed:
        var action : String
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
        player.try_to_cast(best_match)
        reset()
    else:
        _timer.start(_timer.wait_time)
        possible_sequences = new_possible_sequences
        current_pos += 1

func reset():
    current_pos = 0
    possible_sequences = sequences.keys()
    best_match = null