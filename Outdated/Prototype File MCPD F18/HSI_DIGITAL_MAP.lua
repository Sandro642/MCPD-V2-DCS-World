dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

-- Ajout de la carte numérique avec rendu plein écran
AddVideoSignalRender_MPD_FullScreen({{"MPD_HSI_DigitalMapShow"}})

-- Ajout d'un filtre coloré pour la carte numérique
local verts = {
    {-1, 1},  -- Coin haut gauche
    {1, 1},   -- Coin haut droit
    {1, -1},  -- Coin bas droit
    {-1, -1}  -- Coin bas gauche
}

-- Définir une superposition de filtre de couleur
local colorOverlay = CreateElement "ceMeshPoly"
colorOverlay.name = "ColorOverlay"
colorOverlay.vertices = verts
colorOverlay.indices = default_box_indices
colorOverlay.material = MakeMaterial(nil, {0.0, 0.5, 1.0, 0.25}) -- Bleu clair translucide (couche principale)
colorOverlay.h_clip_relation = h_clip_relations.REWRITE_LEVEL
colorOverlay.level = DEFAULT_LEVEL + 1 -- Priorité d'affichage au-dessus de la carte
Add(colorOverlay)

-- Ajouter une deuxième couche pour des nuances jaunes (zones plus lumineuses)
local yellowOverlay = CreateElement "ceMeshPoly"
yellowOverlay.name = "YellowOverlay"
yellowOverlay.vertices = verts
yellowOverlay.indices = default_box_indices
yellowOverlay.material = MakeMaterial(nil, {1.0, 1.0, 0.0, 0.15}) -- Jaune translucide
yellowOverlay.h_clip_relation = h_clip_relations.REWRITE_LEVEL
yellowOverlay.level = DEFAULT_LEVEL + 2 -- Priorité légèrement supérieure
Add(yellowOverlay)

-- Ajouter une troisième couche pour des nuances vertes (zones mixtes)
local greenOverlay = CreateElement "ceMeshPoly"
greenOverlay.name = "GreenOverlay"
greenOverlay.vertices = verts
greenOverlay.indices = default_box_indices
greenOverlay.material = MakeMaterial(nil, {0.0, 1.0, 0.0, 0.20}) -- Vert translucide
greenOverlay.h_clip_relation = h_clip_relations.REWRITE_LEVEL
greenOverlay.level = DEFAULT_LEVEL + 3 -- Priorité la plus élevée
Add(greenOverlay)
