extends TextureRect

onready var time_label = $Counter/Value

var cooldown
var spellID = -1


func _ready():
    time_label.hide()
    $Sweep.value = 0
    set_process(false)

func _process(delta):
    time_label.text = "%3.1f" % $Timer.time_left
    $Sweep.value = int(($Timer.time_left / cooldown) * 100)

func _on_Timer_timeout():
    $Sweep.value = 0
    time_label.hide()
    set_process(false)
    get_parent().spell_over(spellID)
    #SERA?
    queue_free()

func spell_cast(id, cd):
    spellID = id
    $Sweep.texture_progress = texture
    $Sweep.rect_size = texture.get_size()
    cooldown = cd
    $Timer.wait_time = cd
    $Timer.start()
    time_label.show()
    set_process(true)
