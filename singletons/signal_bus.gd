extends Node


# ---- # Battle Signals
signal battle_ready     # emitted by battle scene when it has connected its signals
signal end_turn         # called by a child of the batle scene when its turn is completed
signal selected(entity: Entity)     # called by an entity when the player selects them

# ---- # Entity Signals
signal new_player(player: Player)   # called by player in ready function
signal new_enemy(enemy: Enemy)      # called by enemy in ready function
