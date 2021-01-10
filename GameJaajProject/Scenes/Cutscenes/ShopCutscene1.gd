extends Node2D
func _ready():
    $CanvasLayer/DialogBox.dialog = [["Oh, a costumer! Welcome to my shop, feel free to browse.","???"],
    ["What!? Who goes there!? (I can't see him).","Lumorith"],
    ["*sigh* Above the crates, the furry little thing...Woof","???"],
    ["Heavens, a talking wolf! I've never seen that kind of sorcery before!", "Lumorith"],
    ["It is a remarkable spell, indeed. However, I'm not the one responsible for it, as you may presume.","Wolf"],
    ["This...curse was cast upon me a long time ago, when I came here to stop the summoning of a great evil.","Wolf"],
    ["Wait, that would make you Eleanor, the...'Wolf' of the North...","Lumorith"],
    ["There is some irony to the title now, aye? *Sight*","Wolf"],
    ["Kinda.","Lumorith"],
    ["But let us leave my failures to another time. Now, how can I help you, wizard?","Wolf"],
    ["I'm in need of items with particularly 'unique' features. Is there something like that in your stock?",
    "Lumorith"],
    ["Just look around, friend! Magical items, as unique as a talking wolf!","Wolf"],
    ["These scrolls. They seem to contain a magic unkown to me...", "Lumorith"],
    ["Those are useless to me in my current condition. Feel free to transcribe them to your grimoire if you want to.", "Wolf"],
    ["T-thank you Mrs.Eleanor, you have my eternal gratitude!","Lumorith"],
    ["Lumorith learned two new spells!",""],
    ["Press BFB for Black Fireball and GFB for Green Fireball when facing monsters", ""],
    ["*Woof* (Remember to check your grimoire later to learn about your new spells) *woof*", "Wolf"]]
    $CanvasLayer/DialogBox.load_dialog()
    yield($CanvasLayer/DialogBox, "end_of_dialog")
    Global.goto_scene("res://Scenes/World/World.tscn")
