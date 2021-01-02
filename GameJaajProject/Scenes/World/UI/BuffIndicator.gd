extends TextureRect

onready var time_label = $Counter/Value


var spellID = -1

func end_effect():
    queue_free()

