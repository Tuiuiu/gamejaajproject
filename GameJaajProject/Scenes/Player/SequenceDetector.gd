extends Node

var sequences = {
    0: [KEY_R, KEY_F, KEY_B],
    1: [KEY_B, KEY_F, KEY_B],
    2: [KEY_G, KEY_F, KEY_B],
    3: [KEY_F, KEY_L],
    4: [KEY_R, KEY_H],
    5: [KEY_B, KEY_H],
    6: [KEY_G, KEY_H],
    7: [KEY_H, KEY_E, KEY_A, KEY_L],
    8: [KEY_T, KEY_O, KEY_L, KEY_L]
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
            # Key pressed is part of a sequence
            player.sequence_pressed(action)
            _validate_sequences(action)
        else:
            # Key pressed is not part of a sequence
            player.sequence_pressed("KEY_MISSED")
        
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

func add_sequence(id, sequence):
    sequences[id] = sequence
