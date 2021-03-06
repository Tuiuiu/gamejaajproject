extends NinePatchRect

var interactable = false
var dialog = [[]]

var active_actor = "A"
var speech = 0

signal end_of_dialog
#func _ready():
 #   load_dialog()

func _process(_delta):
    if (Input.is_action_just_pressed("ui_accept") and interactable):
        $MarginContainer/Label.percent_visible = 0
        load_dialog()

func load_dialog():
    interactable = true
    if (speech < dialog.size()):
        $MarginContainer/Label.text = dialog[speech][0]
        if (dialog[speech][1] != active_actor):
            $NinePatchRect/SpeakerName.text = dialog[speech][1]
            active_actor = dialog[speech][1]
        $MarginContainer/Label/AnimationPlayer.play("Write")
        yield($MarginContainer/Label/AnimationPlayer, "animation_finished")
        $TextureButton/AnimationPlayer.play("Next")
        speech += 1
    else: 
        visible = false
        speech = 0
        emit_signal("end_of_dialog")
    
