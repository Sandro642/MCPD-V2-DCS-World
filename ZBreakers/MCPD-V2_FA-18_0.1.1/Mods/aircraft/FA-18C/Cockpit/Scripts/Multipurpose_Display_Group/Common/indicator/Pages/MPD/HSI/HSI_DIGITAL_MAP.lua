dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

-- Ajout de la carte visuelle avec les couleurs basées sur le relief
AddVideoSignalRender_MPD_FullScreen({
    {"MPD_HSI_DigitalMapShow"},
    {"RemoveTextAnnotations", true} -- Supprime les annotations textuelles
})

-- Configuration des matériaux pour correspondre aux couleurs souhaitées
local reliefMaterial = CreateMaterial("RELIEF_COLOR", {0.0, 0.7, 0.3, 1.0}) -- Exemple pour vert
local waterMaterial = CreateMaterial("WATER_COLOR", {0.0, 0.3, 0.7, 1.0}) -- Exemple pour bleu
local highLandMaterial = CreateMaterial("HIGHLAND_COLOR", {0.9, 0.8, 0.3, 1.0}) -- Exemple pour jaune

-- Définition des zones avec les matériaux définis
local function AddReliefMap()
    local szRelief = 1.0
    local vertsRelief = {
        {-szRelief, szRelief},
        {szRelief, szRelief},
        {szRelief, -szRelief},
        {-szRelief, -szRelief}
    }

    local meshRelief = CreateElement "ceMeshPoly"
    meshRelief.name = "meshRelief"
    meshRelief.isdraw = true
    meshRelief.material = reliefMaterial
    meshRelief.vertices = vertsRelief
    meshRelief.indices = default_box_indices
    meshRelief.primitivetype = "triangles"
    meshRelief.screenspace = 2
    Add(meshRelief)
end

-- Suppression du texte
local function RemoveTextAnnotations()
    local elements = GetAllElements()
    for _, element in ipairs(elements) do
        if element.type == "text" then
            element.isdraw = false
        end
    end
end

-- Appel des fonctions pour appliquer les modifications
AddReliefMap()
RemoveTextAnnotations()
