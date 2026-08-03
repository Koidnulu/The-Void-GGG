extends HBoxContainer

var hearts_list : Array[TextureRect]
var health = 3
signal player_died

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# this is just putting all of the heart textures in the array by grabbing
	# the parent node and finding its children
	for child in $".".get_children():
		hearts_list.append(child);
	for heart in hearts_list:
		var sprite = heart.get_node_or_null("AnimatedSprite2D") as AnimatedSprite2D
		if sprite:
			sprite.play("default")


func damage_taken():
	if health > 0:
		health -= 1;
	for i in range (hearts_list.size()):
		# so one less heart than health
		hearts_list[i].visible = i < health
	if health <= 0:	
		player_died.emit()
