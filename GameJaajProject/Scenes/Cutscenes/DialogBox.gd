extends Control

var dialog = [["Vi sitter här I venten och spelar lite dota","velho brocha"],
["I hear you man","lobinho"]]


var active_actor = "A"
var speak = 0
func _ready():
    load_dialog()

func _process(delta):
    if (Input.is_action_just_pressed("ui_accept")):
        load_dialog()

func load_dialog():
    if (speak < dialog.size()):
        $NinePatchRect/MarginContainer/Label.text = dialog[speak][0]
        if (dialog[speak][1] != active_actor):
            $NinePatchRect/NinePatchRect/SpeakerName.text = dialog[speak][1]
            active_actor = dialog[speak][1]
        $NinePatchRect/MarginContainer/Label/AnimationPlayer.play("Write")
        yield($NinePatchRect/MarginContainer/Label/AnimationPlayer, "animation_finished")
        $NinePatchRect/NinePatchRect2/TextureButton/AnimationPlayer.play("Next")
        speak += 1
    else: queue_free()
    


