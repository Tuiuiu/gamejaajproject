extends Node2D
func _ready():
    $CanvasLayer/DialogBox.dialog = [["Oh, a costumer! Welcome to my shop, feel free to browse.","???"],
    ["What!? Who goes there!? (I can't see him).","protagonist"],
    ["*sight* Above the crates, the furry little thing...Woof","???"],
    ["Heavens, a talking wolf! I've never seen that kind of sorcery before!", "Lumorith"],
    ["It is a remarkable spell, indeed. However, I'm not the one responsible for it, as you may presume.","Wolf"],
    ["This...curse was cast upon me a long time ago, when I came here to stop the summoning of a great evil.","Wolf"],
    ["Wait, that would make you Eleanor, the...'Wolf' of the North...","Lumorith"],
    ["There is some irony to the title now, aye? *Sight*","Wolf"],
    ["Kinda.","Lumorith"],
    ["But let us leave my failures to another time. Now, how can I help you, wizard?","Wolf"],
    ["I'm in need of items with particularly 'unique' features. Is there something like that in your stock?",
    "Lumorith"],
    ["Just look around, friend! Magical items, as unique as a talking wolf!","Wolf"]]
    $CanvasLayer/DialogBox.load_dialog()
