extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect
var duration : float = 1.0
var wait_time : float  = 0.5

func fade_in():
	color_rect.color.a = 0
	var tween = get_tree().create_tween()
	#object, path/address of property that is animated, final value to animate to,
	# duration of the animation/ duration of this change
	tween.tween_property(color_rect, "color:a", 1, duration)
	# a timer so that the animation is finished playing before the next level loads
	await get_tree().create_timer(duration + wait_time).timeout
	
func fade_out():
	color_rect.color.a = 1
	await get_tree().create_timer(wait_time).timeout
	var tween = get_tree().create_tween()
	#object, path/address of property that is animated, final value to animate to,
	# duration of the animation/ duration of this change
	tween.tween_property(color_rect, "color:a", 0, duration)
	await get_tree().create_timer(duration).timeout
	
