extends AnimatedSprite

export (bool) var idle = true
var count = 0
var raised = false
onready var original_pos = global_position
onready var player = get_tree().get_root().get_node("Main/Player")
onready var tween = $Tween
onready var anim = $AnimationPlayer

func _process(delta):
	count += delta * 4
	if idle:
		idle()

func idle():
	global_position.x = get_parent().get_node("Body").global_position.x / 2  + (-100) + (cos(count) * 2)

func raise_hand():
	global_position.y -= 25
	animation = "attack"
	playing = false
	#get_node("Right/Laser").enabled(true)
	
func lower_hand():
	global_position.y += 25
	animation = "default"
	playing = true
	
func raised_player_align():
	frame = 1
	tween.interpolate_property(self, "global_position:x",
		global_position.x, player.global_position.x, 0.5,
		Tween.TRANS_BACK, Tween.EASE_OUT)
	tween.start()
	
func raise_origin_align():
	frame = 0
	tween.interpolate_property(self, "global_position:x",
		global_position.x, original_pos.x, 0.5,
		Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.start()
	
func raised_fire_laser():
	frame = 0
	$Laser.enabled(true)
	tween.interpolate_property(self, "global_position:y",
		global_position.y, global_position.y - 10, 0.1,
		Tween.TRANS_BACK, tween.EASE_OUT)
	tween.start()
		
func raised_disable_laser():
	frame = 1
	$Laser.enabled(false)
	tween.interpolate_property(self, "global_position:y",
		global_position.y, global_position.y + 10, 0.25,
		Tween.TRANS_BACK, tween.EASE_IN_OUT)
	tween.start()
	
