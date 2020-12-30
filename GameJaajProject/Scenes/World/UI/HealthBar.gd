extends HBoxContainer


onready var world = get_parent()
onready var maximum
onready var current_health
onready var hp_bar = get_node("TextureProgress")

func initialize(current_hp, max_hp):
    current_health = current_hp
    maximum = max_hp
    hp_bar.set_max(max_hp)
    hp_bar.value = current_hp
    update_count_text(current_hp)

func _on_UI_health_updated(new_health):
    animate_value(current_health, new_health)
    update_count_text(new_health)
    current_health = new_health

func animate_value(start, end):
    $Tween.interpolate_property($TextureProgress, "value", start, end, 0.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
    $Tween.interpolate_method(self, "update_count_text", start, end, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
    $Tween.start()
    if end < start:
        $AnimationPlayer.play("shake")

func update_count_text(value):
    $Count/Counter.text = str(round(value)) + '/' + str(maximum)



