-- Is used for digital map render
function AddVideoSignalRender_MPD_FullScreen(controllers)
    local sz = HalfUnitsPerSide -- Taille de rendu par défaut pour le MPCD
    local verts = {
        {-sz,  sz},  -- Coin haut gauche
        { sz,  sz},  -- Coin haut droit
        { sz, -sz},  -- Coin bas droit
        {-sz, -sz}   -- Coin bas gauche
    }

    -- Élément de base pour la carte numérique
    local videoSignal_MPD = CreateElement "ceTexPoly"
    local material = "render_target_" .. string.format("%d", GetRenderTarget() + 1)

    setSymbolCommonProperties(videoSignal_MPD, "videoSignal_MPD", nil, nil, controllers, material)

    -- Propriétés principales
    videoSignal_MPD.vertices = verts
    videoSignal_MPD.indices = default_box_indices
    videoSignal_MPD.tex_params = {0.5, 0.5, 1 / UnitsPerSide, 1 / UnitsPerSide}
    videoSignal_MPD.additive_alpha = true -- Permet d'ajouter des couleurs
    videoSignal_MPD.input_space_SRGB = false -- Désactive le rendu strict SRGB

    Add(videoSignal_MPD)

    -- Couche principale : filtre bleu
    local blueFilter = CreateElement "ceMeshPoly"
    blueFilter.name = "BlueFilter"
    blueFilter.vertices = verts
    blueFilter.indices = default_box_indices
    blueFilter.material = MakeMaterial(nil, {0.0, 0.5, 1.0, 0.25}) -- Bleu clair translucide
    blueFilter.h_clip_relation = h_clip_relations.REWRITE_LEVEL
    blueFilter.level = DEFAULT_LEVEL + 1
    Add(blueFilter)

    -- Couche supplémentaire : filtre jaune
    local yellowFilter = CreateElement "ceMeshPoly"
    yellowFilter.name = "YellowFilter"
    yellowFilter.vertices = verts
    yellowFilter.indices = default_box_indices
    yellowFilter.material = MakeMaterial(nil, {1.0, 1.0, 0.0, 0.15}) -- Jaune translucide
    yellowFilter.h_clip_relation = h_clip_relations.REWRITE_LEVEL
    yellowFilter.level = DEFAULT_LEVEL + 2
    Add(yellowFilter)

    -- Couche supplémentaire : filtre vert
    local greenFilter = CreateElement "ceMeshPoly"
    greenFilter.name = "GreenFilter"
    greenFilter.vertices = verts
    greenFilter.indices = default_box_indices
    greenFilter.material = MakeMaterial(nil, {0.0, 1.0, 0.0, 0.20}) -- Vert translucide
    greenFilter.h_clip_relation = h_clip_relations.REWRITE_LEVEL
    greenFilter.level = DEFAULT_LEVEL + 3
    Add(greenFilter)
end