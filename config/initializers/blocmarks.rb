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
Config.rpt[:topics_index] = {
  reports: {
    topics_index: {
      topic: {
        include_new_topic:     true,
        include_new_bookmark:  true,
        include_delete:        false,
        include_edit:          false
      },
      bookmark: {
        # columns embedly embed_ray embed_side_by_side carousel
        style:              :columns,
        bookmarks_per_row:  3,
        include_likes:      true,
        include_delete:     true,
        include_edit:       true
      }
    }
  }
}
#------- Report Topics - show
Config.rpt[:topics_show] = {
  reports: {
    topics_show: {
      topic: {
        include_new_topic:     false,
        include_new_bookmark:  true,
        include_delete:        true,
        include_edit:          true
      },
      bookmark: {
        # columns embedly embed_ray embed_side_by_side carousel
        style:              :carousel,
        bookmarks_per_row:  3,
        include_likes:      true,
        include_delete:     true,
        include_edit:       true
      }
    }
  }
}
#------- Report Topics - new
Config.rpt[:topics_new] = {
  reports: {
    topics_new: {
      topic: {
      }
    }
  }
}
#------- Report Topics - edit
Config.rpt[:topics_edit] = {
  reports: {
    topics_edit: {
      topic: {
        include_delete:        true
      }
    }
  }
}
#------- Report Topics - User profile
Config.rpt[:users_show] = {
  reports: {
    my_blocmarks: {
      topic: {
        include_new_topic:     false,
        include_new_bookmark:  true,
        include_delete:        true,
        include_edit:          true
      },
      bookmark: {
        style:              :carousel,
        bookmarks_per_row:  3,
        include_likes:      false,
        include_delete:     true,
        include_edit:       true
      }
    },
    my_liked_blocmarks: {
      topic: {
        include_new_topic:     false,
        include_new_bookmark:  false,
        include_delete:        false,
        include_edit:          false
      },
      bookmark: {
        style:              :carousel,
        bookmarks_per_row:  3,
        include_likes:      true,
        include_delete:     false,
        include_edit:       false
      }
    }
  }
}
#------- Report Bookmarks - new
Config.rpt[:bookmarks_new] = {
  reports: {
    bookmarks_new: {
      bookmark: {
      }
    }
  }
}
#------- Report Bookmarks - edit
Config.rpt[:bookmarks_edit] = {
  reports: {
    bookmarks_edit: {
      bookmark: {
        include_delete:        true
      }
    }
  }
}
#------- Bookmarks partial
Config.rpt[:bmks] = {
}
#
#---------------
# Bookmarks partial: columns style.
Config.rpt[:bmks][:columns] = {
  debug_footer:       false
}
Config.bmk_columns = Config.rpt[:bmks][:columns]
#
#-------------------
# Bookmarks partial:  embedly style.
Config.rpt[:bmks][:embedly] = {
  debug_footer:       false
}
Config.bmk_embedly = Config.rpt[:bmks][:embedly]
#
#-------------------
# Report Bookmarks embed_ray style.
Config.rpt[:bmks][:embed_ray] = {
  debug_footer:       false
}
Config.bmk_embed_ray = Config.rpt[:bmks][:embed_ray]
#
#-------------------
# Bookmarks partial:  embed_side_by_side style.
Config.rpt[:bmks][:embed_side_by_side] = {
  debug_footer:       false
}
Config.bmk_embed_side_by_side = Config.rpt[:bmks][:embed_side_by_side]
#
#-------------------
# Bookmarks partial:  carousel style.
Config.rpt[:bmks][:carousel] = {
  debug_footer:       false
}
Config.bmk_carousel = Config.rpt[:bmks][:carousel]
