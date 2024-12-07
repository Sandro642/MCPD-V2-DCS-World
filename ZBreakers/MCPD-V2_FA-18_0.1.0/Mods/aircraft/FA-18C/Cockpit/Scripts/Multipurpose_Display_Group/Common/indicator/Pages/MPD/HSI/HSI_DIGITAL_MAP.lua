dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

-- Activer l'affichage de la carte HSI
AddVideoSignalRender_MPD_FullScreen({{"MPD_HSI_DigitalMapShow"}})

-- Définir la taille de l'écran
local sz = HalfUnitsPerSide

-- Créer un rectangle pour la carte
local verts = {{-sz,  sz},
               { sz,  sz},
               { sz, -sz},
               {-sz, -sz}}

-- Créer un élément pour afficher le signal vidéo
local videoSignal_MPD = CreateElement "ceTexPoly"
local parent = nil

-- Définir la texture de rendu
local material = "render_target_"..string.format("%d", GetRenderTarget() + 1)

-- Appliquer des propriétés de symboles communs
setSymbolCommonProperties(videoSignal_MPD, "videoSignal_MPD", nil, parent, {{"MPD_HSI_DigitalMapShow"}}, material)

-- Définir les coordonnées de la texture et l'ajout du rendu
videoSignal_MPD.vertices = verts
videoSignal_MPD.indices = default_box_indices
videoSignal_MPD.tex_params = {0.5, 0.5, 1 / UnitsPerSide, 1 / UnitsPerSide}

-- Activer l'alpha additive et les filtres de couleurs (pour obtenir un effet similaire à celui que vous souhaitez)
videoSignal_MPD.additive_alpha = true
videoSignal_MPD.input_space_SRGB = true
videoSignal_MPD.material = "render_target_filtered"

-- Ajouter l'élément à l'écran
Add(videoSignal_MPD)
