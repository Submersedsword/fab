-- Mod: fab

-- Register the "fab" node
minetest.register_node("fab:fab", {
    description = "A white box with a light blue crafting grid on each face and when right-clicked opens up a crafting grid with a 4x4 crafting grid",
    tiles = {
        "fab_fab.png", -- top
        "fab_fab.png", -- bottom
        "fab_fab.png", -- right
        "fab_fab.png", -- left
        "fab_fab.png", -- back
        "fab_fab.png"  -- front
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- Open a 4x4 crafting grid when the node is right-clicked
        local player_name = clicker:get_player_name()
        local formspec = "size[12,8]" ..
            "list[current_player;main;0,5;9,2;]" ..
            "list[current_player;craft;1,0;4,4;]" ..
            "list[current_player;craftpreview;7,1;1,1;]" ..
            "listring[current_player;main]" ..
            "listring[current_player;craft]"
        minetest.show_formspec(player_name, "fab:fab_form", formspec)
    end,
    inventory_image = "fab_fab.png",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky=3},
    drop = "fab:fab",
    sounds = default.node_sound_stone_defaults(),
})

-- Register a craft recipe for "fab"
minetest.register_craft({
    output = "fab:fab",
    type = "shaped",
    recipe = {
        {"default:diamond", "default:steel_ingot", "default:diamond"},
        {"default:steel_ingot", "default:mese_crystal", "default:steel_ingot"},
        {"default:diamond", "default:steel_ingot", "default:diamond"},
    }
})

-- Handle the crafting process
minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname == "fab:fab_form" then
        local player_name = player:get_player_name()
        local inv = player:get_inventory()
        local craft_inv = inv:get_list("craft")
        local output = minetest.get_craft_result({method = "normal", width = 4, items = craft_inv})
        if output.item then
            inv:add_item("craftpreview", output.item)
        end
    end
end)
	minetest.register_on_joinplayer(function(
	player)
		local inv = player:get_inventory()
		inv:set_size("craft", 16)
		inv:set_width("craft", 4)
	end)