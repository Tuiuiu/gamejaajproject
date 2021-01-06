extends NinePatchRect


var dialog = [[]]


var active_actor = "A"
var speech = 0
#func _ready():
 #   load_dialog()

func _process(delta):
    if (Input.is_action_just_pressed("ui_accept")):
        $MarginContainer/Label.percent_visible = 0
        load_dialog()

func load_dialog():
    if (speech < dialog.size()):
        $MarginContainer/Label.text = dialog[speech][0]
        if (dialog[speech][1] != active_actor):
            $NinePatchRect/SpeakerName.text = dialog[speech][1]
            active_actor = dialog[speech][1]
        $MarginContainer/Label/AnimationPlayer.play("Write")
        yield($MarginContainer/Label/AnimationPlayer, "animation_finished")
        $TextureButton/AnimationPlayer.play("Next")
        speech += 1
    else: queue_free()
