# Be sure to restart your server when you modify this file.

# My application specific configurations
# In form of:
# MyApp::Application.config.x.<KEY_NAME> = <VALUE_NAME>
#

# Note the alias below, bad practice but saves typing. However, lets us change
# Config to a Model or to session store.
Config = Blocmarks::Application.config.x

# General
Config.log_level = '' # :debug

# Views - General
Config.link_refresh = true

################ Reports
Config.rpt = {
  debug_footer: false
}
#------- Report Topics - index
Config.rpt[:topic_idx] = {
  include_new_topic: true,
  include_new_bookmark: true,
  include_delete:  false,
  include_edit:    false
}
#------- Report Topics - show
Config.rpt[:topic_shw] = {
  include_new_topic: true,
  include_new_bookmark: true,
  include_delete:  true,
  include_edit:    true
}
#------- Report Topics - my bookmarks
Config.rpt[:my_blocmarks] = {
  include_new_bookmark: true,
  include_delete:  true,
  include_edit:    true
}
#------- Report Topics - liked bookmarks
Config.rpt[:my_liked_blocmarks] = {
  include_new_bookmark: true,
  include_delete:  true,
  include_edit:    true
}
#------- Report Bookmarks
Config.rpt[:bmks] = {
  columns_style:            false,
  embedly_style:            true,
  embed_ray_style:          false,
  embed_side_by_side_style: false,
  carousel_style:           false
}
#
#---------------
# Report Bookmarks columns style.
Config.rpt[:bmks][:columns] = {
  bookmarks_per_row:  2,
  debug_footer:       false,
  include_likes:      true,
  include_delete:     true,
  include_edit:       true
}
Config.bmk_columns = Config.rpt[:bmks][:columns]
#
#-------------------
# Report Bookmarks embedly style.
Config.rpt[:bmks][:embedly] = {
  bookmarks_per_row:  3,
  debug_footer:       false,
  include_likes:      true,
  include_delete:     true,
  include_edit:       true
}
Config.bmk_embedly = Config.rpt[:bmks][:embedly]
#
#-------------------
# Report Bookmarks embed_ray style.
Config.rpt[:bmks][:embed_ray] = {
  bookmarks_per_row:  3,
  debug_footer:       false,
  include_likes:      true,
  include_delete:     true,
  include_edit:       true
}
Config.bmk_embed_ray = Config.rpt[:bmks][:embed_ray]
#
#-------------------
# Report Bookmarks embed_side_by_side style.
Config.rpt[:bmks][:embed_side_by_side] = {
  bookmarks_per_row:  2,
  debug_footer:       false,
  include_likes:      true,
  include_delete:     true,
  include_edit:       true
}
Config.bmk_embed_side_by_side = Config.rpt[:bmks][:embed_side_by_side]
#
#-------------------
# Report Bookmarks carousel style.
Config.rpt[:bmks][:carousel] = {
  bookmarks_per_row:  3,
  debug_footer:       false,
  include_likes:      true,
  include_delete:     true,
  include_edit:       true
}
Config.bmk_carousel = Config.rpt[:bmks][:carousel]
