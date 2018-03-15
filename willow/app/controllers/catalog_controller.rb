class CatalogController < ApplicationController
  include Hydra::Catalog
  include Hydra::Controller::ControllerBehavior
  include Blacklight::Concerns::Commands

  # This filter applies the hydra access controls
  before_action :enforce_show_permissions, only: :show

  class << self
    def uploaded_field
      solr_name(:system_create, :stored_sortable, type: :date)
    end

    def modified_field
      solr_name(:system_modified, :stored_sortable, type: :date)
    end

    def published_field
      solr_name(:object_dates_published, :stored_sortable, type: :date)
    end
  end

  configure_blacklight do |config|
    config.view.gallery.partials = [:index_header, :index]
    config.view.masonry.partials = [:index]
    config.view.slideshow.partials = [:index]


    config.show.tile_source_field = :content_metadata_image_iiif_info_ssm
    config.show.partials.insert(1, :openseadragon)
    config.search_builder_class = Hyrax::CatalogSearchBuilder

    # Show gallery view
    config.view.gallery.partials = [:index_header, :index]
    config.view.slideshow.partials = [:index]

    ## Default parameters to send to solr for all search-like requests. See also SolrHelper#solr_search_params
    config.default_solr_params = {
      qt: 'search',
      rows: 10,
      qf: to_searchable_names_field_list(:title,
                                         :object_description,
                                         :object_keywords,
                                         :object_category)
    }

    # solr field configuration for document/show views
    config.index.title_field = solr_name(:title, :stored_searchable)
    config.index.display_type_field = solr_name(:has_model, :symbol)
    config.index.thumbnail_field = 'thumbnail_path_ss'

    # solr fields that will be treated as facets by the blacklight application
    #   The ordering of the field names is the order of the display

    add_facet_field config,
                    :human_readable_type


    # The generic_type isn't displayed on the facet list
    # It's used to give a label to the filter that comes from the user profile
    config.add_facet_field solr_name(:generic_type, :facetable), if: false

    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.add_facet_fields_to_solr_request!

    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display

    # RDSS CDM additions expanded below. For the add_index_field shortcut, the hash is added as options to the name
    # which is used as a key
    # add_labelled_index_field config, :title, itemprop: name, if: false
    # add_labelled_index_field config, :object_description, itemprop: :object_description, if: false
    # add_labelled_index_field config, :object_keywords, itemprop: :object_keywords
    # add_labelled_index_field config, :object_category, itemprop: :object_category
    # End of RDSS CDM additions

    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display
    #
    add_index_field config,
                    {title: {options: {if: false}}},
                    {object_description: {options: {itemprop: :object_description, if: false}}},
                    {object_keywords: {options: {itemprop: :object_keywords}}},
                    {object_category: {options: {itemprop: :object_category}}},
                    {object_dates: {options: {itemprop: :object_dates}}},
                    {object_people: {options: {itemprop: :object_people}}},
                    {object_person_roles: {options: {itemprop: :object_person_roles}}},
                    {object_organisation_roles: {options: {itemprop: :object_organisation_roles}}},
                    {proxy_depositor: {options: {helper_method: :link_to_profile}}},
                    {depositor: {options: {helper_method: :link_to_profile}}},
                    {object_dates_published: {type: :date, as: :stored_sortable, options: {itemprop: :object_dates_published, helper_method: :human_readable_date}}},
                    {date_uploaded: {type: :date, as: :stored_sortable, options: {itemprop: :date_published, helper_method: :human_readable_date}}},
                    {date_modified: {type: :date, as: :stored_sortable, options: {itemprop: :date_modified, helper_method: :human_readable_date}}},
                    #TODO: Check the date_created. The original didn't have type: date as an option to the solr_name
                    {date_created: {type: :date, options: {itemprop: :date_created}}},
    # dataset date fields for search
                    {date_accepted: {type: :date, options: {itemprop: :date_accepted}}},
                    {date_available: {type: :date, options: {itemprop: :date_available}}},
                    {date_copyrighted: {type: :date, options: {itemprop: :date_copyrighted}}},
                    {date_collected: {type: :date, options: {itemprop: :date_collected}}},
                    {date_issued: {type: :date, options: {itemprop: :date_issued}}},
                    {date_published: {type: :date, options: {itemprop: :date_published}}},
                    {date_submitted: {type: :date, options: {itemprop: :date_submitted}}},
                    {date_updated: {type: :date, options: {itemprop: :date_updated}}}

    # solr fields to be displayed in the show (single result) view
    #   The ordering of the field names is the order of the display
    # RDSS CDM additions:
    #
    add_show_field config,
                   :title,
                   :object_description,
                   :object_keywords,
                   :object_category,
                   {object_dates: {as: :displayable}},
                   {object_people: {as: :displayable}},
                   {object_person_roles: {as: :displayable}}

    # "fielded" search configuration. Used by pulldown among other places.
    # For supported keys in hash, see rdoc for Blacklight::SearchFields
    #
    # Search fields will inherit the :qt solr request handler from
    # config[:default_solr_parameters], OR can specify a different one
    # with a :qt key/value. Below examples inherit, except for subject
    # that specifies the same :qt as default for our own internal
    # testing purposes.
    #
    # The :key is what will be used to identify this BL search field internally,
    # as well as in URLs -- so changing it after deployment may break bookmarked
    # urls.  A display label will be automatically calculated from the :key,
    # or can be specified manually to be different.
    #
    # This one uses all the defaults set by the solr request handler. Which
    # solr request handler? The one set in config[:default_solr_parameters][:qt],
    # since we aren't specifying it otherwise.
    config.add_search_field('all_fields', label: 'All Fields') do |field|
      all_names = config.show_fields.values.map(&:field).join(" ")
      title_name = solr_name(:title, :stored_searchable)
      field.solr_parameters = {
        qf: "#{all_names} file_format_tesim all_text_timv",
        pf: title_name.to_s
      }
    end

    # Now we see how to over-ride Solr request handler defaults, in this
    # case for a BL "search field", which is really a dismax aggregate
    # of Solr search fields.
    # creator, title, description, publisher, date_created,
    # subject, language, resource_type, format, identifier, based_near,
    #
    add_search_field config,
                     :contributor,
                     :creator,
                     :creator_nested,
                     {identifier_nested: {as: :symbol}},
                     :title,
                     :description,
                     :publisher,
                     :date_created,
                     :subject,
                     :subject_nested,
                     :language,
                     :resource_type,
                     :format,
                     {identifier: {name: :id}},
                     {based_near: {name: :based_near_label}},
                     :keyword,
                     {depositor: {as: :symbol}},
                     :rights,
                     :license_nested,
                     :other_title,
                     {doi: {as: :facetable}},
                     :category,
                     :rating,
                     :rights_holder,
                     :organisation_nested


    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the SOLR field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case).
    # label is key, solr field is value
    config.add_sort_field "score desc, #{uploaded_field} desc", label: "relevance"
    config.add_sort_field "#{published_field} desc", label: "date published \u25BC"
    config.add_sort_field "#{published_field} asc", label: "date published \u25B2"
    config.add_sort_field "#{uploaded_field} desc", label: "date uploaded \u25BC"
    config.add_sort_field "#{uploaded_field} asc", label: "date uploaded \u25B2"
    config.add_sort_field "#{modified_field} desc", label: "date modified \u25BC"
    config.add_sort_field "#{modified_field} asc", label: "date modified \u25B2"

    # If there are more than this many search results, no spelling ("did you
    # mean") suggestion is offered.
    config.spell_max = 5
  end

  # disable the bookmark control from displaying in gallery view
  # Hyrax doesn't show any of the default controls on the list view, so
  # this method is not called in that context.
  def render_bookmarks_control?
    false
  end
end
