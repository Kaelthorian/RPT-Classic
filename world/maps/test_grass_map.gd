extends Node2D

const MAP_SIZE := Vector2i(50, 50)
const TILE_SIZE := Vector2i(32, 32)
const GRASS_TEXTURE_PATH := "res://assets/tiles/grass_tile.svg"

@onready var ground: TileMapLayer = $Ground
@onready var player: CharacterBody2D = $TestPlayer
@onready var tile_count_label: Label = %TileCountLabel
@onready var position_label: Label = %PositionLabel


func _ready() -> void:
	var map_error := _build_grass_map()
	if map_error != OK:
		push_error("Test grass map could not be built (error %d)." % map_error)
		return
	var used_cell_count := ground.get_used_cells().size()
	if used_cell_count != MAP_SIZE.x * MAP_SIZE.y:
		push_error("Test map expected 2500 tiles but built %d." % used_cell_count)
		return

	GameState.current_map_id = &"test_grass_50x50"
	GameState.current_player = player
	GameState.session_status = GameState.SessionStatus.RUNNING
	tile_count_label.text = "Map: %d × %d grass tiles (%d total)" % [MAP_SIZE.x, MAP_SIZE.y, used_cell_count]
	print("RPT test map ready; size=50x50 tiles=%d player_position=%s" % [used_cell_count, player.position])


func _process(_delta: float) -> void:
	var tile_position := Vector2i(floori(player.position.x / TILE_SIZE.x), floori(player.position.y / TILE_SIZE.y))
	position_label.text = "Player tile: %d, %d" % [tile_position.x, tile_position.y]


func _build_grass_map() -> Error:
	var grass_texture := load(GRASS_TEXTURE_PATH) as Texture2D
	if grass_texture == null:
		return ERR_CANT_OPEN

	var tile_set := TileSet.new()
	tile_set.tile_size = TILE_SIZE
	var atlas_source := TileSetAtlasSource.new()
	atlas_source.texture = grass_texture
	atlas_source.texture_region_size = TILE_SIZE
	atlas_source.create_tile(Vector2i.ZERO)
	var source_id := tile_set.add_source(atlas_source)
	ground.tile_set = tile_set

	for y in range(MAP_SIZE.y):
		for x in range(MAP_SIZE.x):
			ground.set_cell(Vector2i(x, y), source_id, Vector2i.ZERO)
	return OK
