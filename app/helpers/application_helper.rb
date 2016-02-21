
#
# Methods in this file are normally only available to views.
#
module ApplicationHelper
  #
  #===========================
  #         for VIEWS
  #===========================

  #====================== Report configurations ======
  #

  # Example1: <%= render
  #    partial: 'index_page_header',
  #    locals: { props: properties(title: 'All Blocmarks', topics: @topics) } %>
  # Becomes:  locals: { props: {
  #                       title: 'All Blocmarks', topics: @topics,
  #                       rpt: Config.rpt[:topics_index]
  #                     }
  #                   }
  # Useage for above example in the partial to be rendered:
  #           if rpt_topic(props)[:include_new_topic]
  # Example2: <%= render partial: '/bookmarks/styles/columns/columns_bmk',
  #                      locals: { props: props }
  #          %>
  def properties(locals_hash = nil, rpt_tag = nil, controller_action = nil)
    if locals_hash.nil?
      ret = { rpt_tag: rpt_tag, rpt: rpt_config(rpt_tag, controller_action) }
    else
      ret = locals_hash
      ret[:rpt_tag] = rpt_tag
      ret[:rpt] = rpt_config(rpt_tag, controller_action)
    end
    ret
  end

  # Example1: props = rpt_config   or props = properites()
  #  Returns: (if on the topics index page):
  #           Config.rpt[:topics_index][:reports][:topics_index]
  # Example2: props = rpt_config('my_blocmarks')
  #  Returns: Config.rpt[:users_show][:reports][:my_blocmarks]
  #  To Use:  if rpt_topic(props)[:include_new_topic]
  #            or
  #          if rpt_config('my_blocmarks')[:topic][:include_new_bookmark]
  #
  def rpt_config(rpt_tag = nil, controller_action = nil)
    rpt_sym = "#{params[:controller]}_#{params[:action]}"
              .to_sym unless controller_action
    rpt_sym = controller_action.to_sym if controller_action
    ret = Config.rpt[rpt_sym][:reports][rpt_tag.nil? ? rpt_sym : rpt_tag.to_sym]
    ret
  end

  #====================== Topic configuration ======
  #
  # Example1: Assume we already have inherited properties.
  #  Returns: (if on the topics index page):
  #           Config.rpt[:topics_index][:reports][:topics_index][:topic]
  #  To Use: if rpt_topic(props)[:include_new_topic]
  def rpt_topic(props_hash = nil)
    ret = (props_hash.nil? ? rpt_config(nil) : props_hash)[:rpt][:topic]
    # require 'pry'
    # binding.pry
    ret
  end

  #====================== Bookmark configuration ======
  #
  # Example1: Assume we already have inherited properties.
  #  Returns: (if on the topics index page):
  #           Config.rpt[:topics_index][:reports][:topics_index][:bookmark]
  #  To Use: if rpt_bmk(props)[:include_likes]
  def rpt_bmk(props_hash = nil)
    # require 'pry'
    # binding.pry
    ret = (props_hash.nil? ? rpt_config(nil) : props_hash)[:rpt][:bookmark]
    # require 'pry'
    # binding.pry
    ret
  end

  # col = 0, 1, 2  index % 3 = column position
  #  column =
  #    props[:item_num] % rpt_bmk(props)[:bookmarks_per_row]
  # Calc current values for rpt_bmk(props)[:first_column?], etc.
  # if rpt_bmk(props):[first_column?] %>
  # if rpt_bmk(props):[last_column?] || rpt_bmk(props):[last_item?]
  # We can't be sure which level of report properties we are called with.
  #   props could be with locals from a loop including item_num, etc. as in:
  #
  #   Or just a straight call to render a single bookmark without details.
  def rpt_bmk_calc_helpers(props)
    rpt_bmk_calc_column_info_missing_items(props)

    props[:column_pos] = props[:bookmarks_index] % props[:bookmarks_per_row]
    props[:first_column?] = props[:column_pos] == 0
    props[:last_column?] = props[:column_pos] == (props[:bookmarks_per_row] - 1)
    props[:first_item?] = props[:bookmarks_index] == 0
    props[:last_item?] = props[:bookmarks_index] == (props[:num_bookmarks] - 1)
  end

  # Add in useful fields.
  def rpt_bmk_calc_column_info_missing_items(props)
    # We can't be sure which level of report properties we are called with.
    bmk_props = rpt_bmk(props)
    rpt_bmk_calc_bookmarks_index(props, bmk_props)
    rpt_bmk_calc_bookmarks_per_row(props, bmk_props)
    rpt_bmk_calc_num_bookmarks(props, bmk_props)
  end

  def rpt_bmk_calc_bookmarks_index(props, _bmk_props)
    props[:bookmarks_index] = props[:item_num] if props.key?(:item_num)
    props[:bookmarks_index] = 0 unless props.key?(:item_num)
  end

  def rpt_bmk_calc_bookmarks_per_row(props, bmk_props)
    props[:bookmarks_per_row] =
      bmk_props[:bookmarks_per_row] unless props.key?(:bookmarks_per_row)
    props[:bookmarks_per_row] =
      1 unless props.key?(:bookmarks_per_row)
  end

  def rpt_bmk_calc_num_bookmarks(props, _bmk_props)
    props[:num_bookmarks] = props[:num_items] if props.key?(:num_items)
    props[:num_bookmarks] = 1 unless props.key?(:num_items)
  end

  # Just a convention method to make sure we access props data consistently.
  # Most of the useful info has already been stored in props and is not
  # accesible via rpt_bmk(props) method, which can be confusing.
  # if rpt_bmk_helpers(props)[:first_column?]
  def rpt_bmk_helpers(props)
    props
  end

  #====================== Bookmark Partials configuration ======
  #
  # Example1: Assume we already have inherited properties.
  #  Returns: (if Bookmark style is :embed_ray):
  #           Config.rpt[:bmks][:embed_ray]
  #  To Use: if rpt_bmk_part(props)[:debug_footer]
  def rpt_bmk_part(props_hash = nil)
    ret = nil if props_hash.nil?
    ret = Config.rpt[:bmks][rpt_bmk(props_hash)[:style]] unless props_hash.nil?
    ret
  end

  #====================== Embedly ====================
  # per: https://github.com/embedly/embedly-ruby
  # per: http://stackoverflow.com/questions/28622912/using-embedly-with-rails
  #
  (BLOCMARKS_SYSTEM_ERROR = 'Blockmarks system error'.freeze).freeze
  (PAGE_NOT_FOUND          = 'Page not found'.freeze).freeze
  (INVALID_URL             = 'Invalid url'.freeze).freeze
  (URL_NOT_AUTHORIZED      = 'Url not authorized'.freeze).freeze
  # response.type = 'error'
  ERROR_TITLE =
    { 400 => INVALID_URL,
      401 => URL_NOT_AUTHORIZED,
      404 => PAGE_NOT_FOUND
    }
  ERROR_TITLE.default = BLOCMARKS_SYSTEM_ERROR
  ERROR_TITLE.freeze
  #
  # Inputs: url
  # Outputs: html to be inserted into an erb page to display as an Embedly card.
  def get_embed_card_preview_html(url)
    response = embedly_connect2_and_issue_request('oembed', url)
    html = make_preview_card_html(response, url) unless response.type == 'error'
    html = make_error_card_html(response, url)   if response.type == 'error'

    # Return hash of request and response.
    { request: { url: url }, response: { api_response: response, html: html } }
  end

  # Returns: Embedly::API object after api request to Embedly server.
  def embedly_connect2_and_issue_request(func, url)
    api = connect_to_embedly
    issue_embedly_api_request(api, func, url)
  end

  (EMBEDLY_API_KEY = 'ce6f3f7334e04de7a57e9cccf11abd5a'.freeze).freeze
  def connect_to_embedly
    Embedly::API.new(key: EMBEDLY_API_KEY)
  end

  # per:
  # Embedly api.oembed parameters of interest:
  #   url:	String
  #      The URL is to retrieve embedding information. This URL must be escaped
  #      to ensure that Embedly retrieves the correct link.
  #   maxwidth:	Integer
  #      This is the maximum width of the embed in pixels. maxwidth is used
  #      for scaling down embeds so they fit into a certain width. If the
  #      container for an embed is 500px you should pass maxwidth=500 in
  #      the query parameters.
  #   maxheight:	Integer
  #      This is the maximum height of the embed in pixels. Functions the same
  #      as maxwidth, but for the height of the embed instead. It's noteworthy
  #      that maxwidth is preferred over maxheight.
  #   width:	Integer
  #      Will scale embeds type rich and video to the exact width that a
  #      developer specifies in pixels. Embeds smaller than this width will be
  #      scaled up and embeds larger than this width will be scaled down.
  #      Note that using this may cause distortion when scaling up embeds.
  #   autoplay:	Boolean
  #      This will tell the video/rich media to automatically play when the
  #      media is loaded. Accepted values: (true, false) Default: false
  #   words:	String
  #      The words parameter works by trying to split the description at the
  #      closest sentence to that word count
  #   chars:	String
  #      chars is much simpler than words. Embedly will blindly truncate a
  #      description to the number of characters you specify adding ... at the
  #      end when needed.
  #   title:	String
  #       With title Embedly will set the title response attribute to the
  #      open_graph, meta, or twitter title if available in the page.
  #      Accepted values: (og, twitter, meta)
  #   description:	String
  #      With description Embedly will set the description response attribute
  #      to the open_graph, meta, or twitter description if available in the
  #      page. Accepted values: (og, twitter, meta)
  #
  # Response = array of Embedly::EmbedlyObject objects.
  # obj.first ala ActiveRecord is first array item.
  #  EmbedlyObject.type is response type:
  #    type = "error"
  #    type = "link" means url is link to something, i.e. website.
  #                  no embed html provided.
  def issue_embedly_api_request(embedly_api, func, url)
    case func
    when 'oembed'
      obj = embedly_api.oembed url:            url,
                               width:          330,
                               title:       'meta',
                               description: 'meta',
                               words:        '30'
    end
    obj.first
  end

  def make_preview_card_html(api_response, request_url)
    card_html = make_card_for_embedly(api_response.type, api_response,
                                      request_url)
    # Return html ready for .erb insertion as html. Urldecode it. If
    # .html_safe is not used, the .erb helper '<%= html %>' will just insert
    # text, i.e. 'lt&;a href=\"....'
    card_html.html_safe
  end

  #
  def make_card_for_embedly(type, api_response, request_url,
                            title_override = nil)
    case type
    when 'error'
      make_error_card_for_embedly(api_response, request_url, title_override)
    when 'link'
      make_link_card_for_embedly(api_response, request_url)
    when 'photo'
      make_photo_card_for_embedly(api_response, request_url)
    when 'video'
      make_video_card_for_embedly(api_response, request_url)
    when 'rich'
      make_rich_content_card_for_embedly(api_response, request_url)
    end
  end

  (PLATFORM_JS = %(<script async src=\"//cdn.embedly.com/widgets/platform.js\"
  charset=\"UTF-8\"></script>).freeze).freeze
  # platform.js options? or api?
  #   in <blockquote
  #----------- type = PHOTO ----------------------------------------------------
  # Puppy Photo with no info to exract. But does have provide url and name.
  # platform.js appears to pull in the favicon from the provider url.
  # a) Raw embedly api response:
  #  <Embedly::EmbedlyObject provider_url="http://g-ecx.images-amazon.com",
  #  height=305, width=593, version="1.0", url="..amazon.com/images/._CB3.jpg+",
  #  provider_name="Images-amazon", type="photo">
  #  b) Embedly Card Generator tool embed html:
  #     If clicked:     Other links:   Share icons:
  #  <a class="embedly-card"
  #     href="..amazon.com/images/._CB3.jpg"
  #     >Card
  #  </a>
  # When generator options used:
  # <blockquote class="embedly-card"
  #             data-card-key="ce6f3f7334e04de7a57e9cccf11abd5a"
  #             data-card-width="320"
  #             data-card-align="left">
  # <h4>
  #   <a href="http://g-ecx.images-amazon.com/images/G/01/img15/pet-products/small-tiles/23695_pets_vertical_store_dogs_small_tile_8._CB312176604_.jpg"
  #   ></a>
  # </h4>
  # <p></p></blockquote>
  # <script async src="//cdn.embedly.com/widgets/platform.js" charset="UTF-8"></script>
  # minimal link format.
  # card_html = %(
  # <a class=\"embedly-card\"
  #   href=\"#{api_response.url}\">Card</a>
  # ) << PLATFORM_JS
  # card_html
  def make_photo_card_for_embedly(api_response, _request_url)
    card_html = %(
    <blockquote class=\"embedly-card\"
                data-card-key=\"ce6f3f7334e04de7a57e9cccf11abd5a\"
                data-card-width=\"320\"
                data-card-align=\"left\">
      <h4>
        <a href=\"#{api_response.url}\"
        >#{api_response.title || api_response.provider_name || api_response.provider_url}
      </a>
      </h4>
      <p>#{api_response.description || ''}
      </p>
    </blockquote>
    ) << PLATFORM_JS
    card_html
  end

  def make_video_card_for_embedly(api_response, _request_url)
    # Embedly returns the card html ready for us. Vid player is included.
    api_response.html
  end

  #---------------- type = LINK ------------------------------------------------
  #           .title       = Page title scrapped from site/url.
  #           .description = Para about this site from site/url.
  # Web page landing page with extracted title and description.
  # a) Raw embedly api response:
  #  <Embedly::EmbedlyObject
  #  provider_url="http://hiptrac.com",
  #  description="HipTrac provides natural pain relief for hip osteoarthritis
  #               and is designed for independent patient use in clinic or at
  #               home. It delivers the same long axis hip traction that a
  #               physical therapist, chiropractor or physician would do
  #               manually. It decompresses the hip joint and stretches the
  #               surrounding tissues.",
  #  title="HipTrac traction relieves hip pain & increases mobility",
  #  mean_alpha=251.036,
  #  thumbnail_width=300,
  #  url="http://hiptrac.com/",
  #  thumbnail_url="http://hiptrac.com/wp-content/uploads/Home-Page-HipTrac.png",
  #  version="1.0",
  #  provider_name="HipTrac",
  #  type="link",
  #  thumbnail_height=250
  #  >]
  def make_link_card_for_embedly(api_response, _request_url)
    card_html = %(
    <blockquote class=\"embedly-card\"
                data-card-key=\"ce6f3f7334e04de7a57e9cccf11abd5a\"
                data-card-width=\"320\"
                data-card-align=\"left\">
      <h4>
        <a href=\"#{api_response.url}\"
        >#{api_response.title || api_response.provider_name || api_response.provider_url}
      </a>
      </h4>
      <p>#{api_response.description || ''}
      </p>
    </blockquote>
    ) << PLATFORM_JS
    card_html
  end

  def make_rich_content_card_for_embedly(api_response, request_url)
    require 'pry'
    binding.pry
    "<h2>Api.response.type = #{api_response.type}</h2>"
  end

  def make_error_card_for_embedly(api_response, _request_url, title)
    "<h2>#{title}</h2><p>Api.response.type = #{api_response.type}</p>"
  end

  # response.type = 'error'
  # To do: Create or use html error image.
  def make_error_card_html(api_response, request_url)
    title = %(#{api_response.error_code}: \
      #{ERROR_TITLE[api_response.error_code]}  #{request_url})
    card_html = make_card_for_embedly(api_response.type, api_response,
                                      request_url, title)
    # Return html ready for .erb insertion as html. Urldecode it. If
    # .html_safe is not used, the .erb helper '<%= html %>' will just insert
    # text, i.e. 'lt&;a href=\"....'
    card_html.html_safe
  end
end
