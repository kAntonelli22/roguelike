extends Control


# ---- # Nodes
@onready var encounters: Node = $Encounters
@onready var result_screen: ColorRect = $ResultScreen
@onready var path_2d: Path2D = $CampaignMap/Path2D
@onready var path_follow_2d: PathFollow2D = $CampaignMap/Path2D/PathFollow2D
@onready var player: Sprite2D = $CampaignMap/Path2D/PathFollow2D/PlayerMarker
@onready var resources: Label = $TextureRect/MarginContainer/Resources

# ---- # Variables
@onready var points: Array[Vector2]
var map_encounter = preload("res://core/campaign/encounter.tscn")
var progress: int = 1

# ---- # Set Player Position
# loop through encounters, move player to them, delete encounter
func set_player_position(encounter_num: int):
   if encounter_num == encounters.get_child_count() - 1:
      Global.party.campaign_position = 0
      Global.party.campaign_progress = 0
      Global.party.progress += 1
   for i in encounter_num+1:
      var child = encounters.get_child(0)
      child.queue_free()
      encounters.remove_child(child)
   if Global.party.campaign_progress != 0:
      path_follow_2d.progress = Global.party.campaign_progress
      result_screen.show()
      get_tree().paused = true

# ---- # Ready
func _ready() -> void:
   if Global.party.icon != null: player.texture = Global.party.icon
   set_player_position(Global.party.campaign_position)

# ---- # Physics process
func _physics_process(delta):
   if result_screen.visible:
      resources.text = "Gold: " + str(Global.party.gold)
      result_screen.hide()

   path_follow_2d.progress += 100 * delta
   if encounters.get_child(0).global_position.distance_to(player.global_position) < 5:
      Global.party.campaign_progress = path_follow_2d.progress + 5
      encounters.get_child(0).load_encounter()
