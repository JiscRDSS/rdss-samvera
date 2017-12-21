class CatalogController < ApplicationController
  include Hydra::Catalog
  include Hydra::Controller::ControllerBehavior

  # This filter applies the hydra access controls
  before_action :enforce_show_permissions, only: :show

  def self.uploaded_field
    solr_name('system_create', :stored_sortable, type: :date)
  end

  def self.modified_field
    solr_name('system_modified', :stored_sortable, type: :date)
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
      qt: "search",
      rows: 10,
      qf: "title_tesim description_tesim creator_tesim keyword_tesim"
    }

    # solr field configuration for document/show views
    config.index.title_field = solr_name("title", :stored_searchable)
    config.index.display_type_field = solr_name("has_model", :symbol)
    config.index.thumbnail_field = 'thumbnail_path_ss'

    # solr fields that will be treated as facets by the blacklight application
    #   The ordering of the field names is the order of the display
    config.add_facet_field solr_name("human_readable_type", :facetable), label: I18n.t('willow.fields.human_readable_type'), limit: 5
    config.add_facet_field solr_name("resource_type", :facetable), label: I18n.t('willow.fields.resource_type'), limit: 5
    config.add_facet_field solr_name("creator", :facetable), label: I18n.t('willow.fields.creator'), limit: 5
    config.add_facet_field solr_name("creator_nested", :facetable), label: I18n.t('willow.fields.creator_nested'), limit: 5
    config.add_facet_field solr_name("contributor", :facetable), label: I18n.t('willow.fields.contributor'), limit: 5
    config.add_facet_field solr_name("keyword", :facetable), label: I18n.t('willow.fields.keyword'), limit: 5
    config.add_facet_field solr_name("subject", :facetable), label: I18n.t('willow.fields.subject'), limit: 5
    config.add_facet_field solr_name("subject_nested", :facetable), label: I18n.t('willow.fields.subject_nested'), limit: 5
    config.add_facet_field solr_name("language", :facetable), label: I18n.t('willow.fields.language'), limit: 5
    config.add_facet_field solr_name("based_near_label", :facetable), label: I18n.t('willow.fields.based_near_label'), limit: 5
    config.add_facet_field solr_name("publisher", :facetable), label: I18n.t('willow.fields.publisher'), limit: 5
    config.add_facet_field solr_name("funder", :facetable), label: I18n.t('willow.fields.funder'), limit: 5
    config.add_facet_field solr_name("tagged_version", :facetable), label: I18n.t('willow.fields.tagged_version'), limit: 5
    config.add_facet_field solr_name("file_format", :facetable), label: I18n.t('willow.fields.file_format'), limit: 5
    config.add_facet_field solr_name('member_of_collections', :symbol), limit: 5, label: I18n.t('willow.fields.member_of_collections')
    config.add_facet_field solr_name('rating', :facetable), limit: 5, label: I18n.t('willow.fields.rating')
    config.add_facet_field solr_name('category', :facetable), limit: 5, label: I18n.t('willow.fields.category')
    config.add_facet_field solr_name('rights_holder', :facetable), limit: 5, label: I18n.t('willow.fields.rights_holder')
    config.add_facet_field solr_name("organisation_nested", :facetable), label: I18n.t('willow.fields.organisation_nested'), limit: 5

    # The generic_type isn't displayed on the facet list
    # It's used to give a label to the filter that comes from the user profile
    config.add_facet_field solr_name("generic_type", :facetable), if: false

    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.add_facet_fields_to_solr_request!

    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display
    # RDSS CDM additions:
    config.add_index_field solr_name("title", :stored_searchable), label: I18n.t('willow.fields.title'), itemprop: 'name', if: false
    config.add_index_field solr_name("object_description", :stored_searchable), label: I18n.t('willow.fields.object_description'), itemprop: 'object_description', if: false
    config.add_index_field solr_name("object_keywords", :stored_searchable), label: I18n.t('willow.fields.object_keywords'), itemprop: 'object_keywords' #link_to_search: solr_name("object_keywords", :facetable)
    config.add_index_field solr_name("object_category", :stored_searchable), label: I18n.t('willow.fields.object_category'), itemprop: 'object_category' #link_to_search: solr_name("object_category", :facetable)
    
    # End of RDSS CDM additions

    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display
    config.add_index_field solr_name("description", :stored_searchable), label: I18n.t('willow.fields.description'), itemprop: 'description', helper_method: :iconify_auto_link
    config.add_index_field solr_name("keyword", :stored_searchable), label: I18n.t('willow.fields.keyword'), itemprop: 'keywords', link_to_search: solr_name("keyword", :facetable)
    config.add_index_field solr_name("subject", :stored_searchable), label: I18n.t('willow.fields.subject'), itemprop: 'about', link_to_search: solr_name("subject", :facetable)
    config.add_index_field solr_name("subject_nested", :stored_searchable), label: I18n.t('willow.fields.subject_nested'), itemprop: 'about', link_to_search: solr_name("subject_nested", :facetable)
    config.add_index_field solr_name("creator", :stored_searchable), label: I18n.t('willow.fields.creator'), itemprop: 'creator', link_to_search: solr_name("creator", :facetable)
    config.add_index_field solr_name("creator_nested", :stored_searchable), label: I18n.t('willow.fields.creator_nested'), itemprop: 'creator', link_to_search: solr_name("creator_nested", :facetable)
    config.add_index_field solr_name("contributor", :stored_searchable), label: I18n.t('willow.fields.contributor'), itemprop: 'contributor', link_to_search: solr_name("contributor", :facetable)
    config.add_index_field solr_name("proxy_depositor", :symbol), label: I18n.t('willow.fields.proxy_depositor'), helper_method: :link_to_profile
    config.add_index_field solr_name("depositor"), label: I18n.t('willow.fields.depositor'), helper_method: :link_to_profile
    config.add_index_field solr_name("publisher", :stored_searchable), label: I18n.t('willow.fields.publisher'), itemprop: 'publisher', link_to_search: solr_name("publisher", :facetable)
    config.add_index_field solr_name("based_near_label", :stored_searchable), label: I18n.t('willow.fields.based_near'), itemprop: 'contentLocation', link_to_search: solr_name("based_near_label", :facetable)
    config.add_index_field solr_name("language", :stored_searchable), label: I18n.t('willow.fields.language'), itemprop: 'inLanguage', link_to_search: solr_name("language", :facetable)
    config.add_index_field solr_name("date_uploaded", :stored_sortable, type: :date), label: I18n.t('willow.fields.date_uploaded'), itemprop: 'datePublished', helper_method: :human_readable_date
    config.add_index_field solr_name("date_modified", :stored_sortable, type: :date), label: I18n.t('willow.fields.date_modified'), itemprop: 'dateModified', helper_method: :human_readable_date
    config.add_index_field solr_name("date_created", :stored_searchable), label: I18n.t('willow.fields.date_created'), itemprop: 'dateCreated'
    # dataset date fields for search
    config.add_index_field solr_name("date_accepted", :stored_sortable, type: :date), label: I18n.t('willow.fields.date_accepted'), itemprop: 'dateAccepted'
    config.add_index_field solr_name("date_available", :stored_sortable, type: :date), label: I18n.t('willow.fields.date_available'), itemprop: 'dateAvailable'
    config.add_index_field solr_name("date_copyrighted", :stored_sortable, type: :date), label: I18n.t('willow.fields.date_copyrighted'), itemprop: 'dateCopyrighted'
    config.add_index_field solr_name("date_collected", :stored_sortable, type: :date), label: I18n.t('willow.fields.date_collected'), itemprop: 'dateCollected'
    config.add_index_field solr_name("date_issued", :stored_sortable, type: :date), label: I18n.t('willow.fields.date_issued'), itemprop: 'dateIssued'
    config.add_index_field solr_name("date_published", :stored_sortable, type: :date), label: I18n.t('willow.fields.date_published'), itemprop: 'datePublished'
    config.add_index_field solr_name("date_submitted", :stored_sortable, type: :date), label: I18n.t('willow.fields.date_submitted'), itemprop: 'dateSubmitted'
    config.add_index_field solr_name("date_updated", :stored_sortable, type: :date), label: I18n.t('willow.fields.date_updated'), itemprop: 'dateUpdated'
    config.add_index_field solr_name("rights", :stored_searchable), label: I18n.t('willow.fields.rights'), helper_method: :license_links
    config.add_index_field solr_name("license_nested", :stored_searchable), label: I18n.t('willow.fields.license_nested'), helper_method: :license_links
    config.add_index_field solr_name("resource_type", :stored_searchable), label: I18n.t('willow.fields.resource_type'), link_to_search: solr_name("resource_type", :facetable)
    config.add_index_field solr_name("file_format", :stored_searchable), label: I18n.t('willow.fields.file_format'), link_to_search: solr_name("file_format", :facetable)
    config.add_index_field solr_name("identifier", :stored_searchable), label: I18n.t('willow.fields.identifier'), helper_method: :index_field_link, field_name: 'identifier'
    config.add_index_field solr_name("embargo_release_date", :stored_sortable, type: :date), label: I18n.t('willow.fields.embargo_release_date'), helper_method: :human_readable_date
    config.add_index_field solr_name("lease_expiration_date", :stored_sortable, type: :date), label: I18n.t('willow.fields.lease_expiration_date'), helper_method: :human_readable_date
    # dataset fields for search
    config.add_index_field solr_name("doi", :stored_searchable), label: I18n.t('willow.fields.doi')
    config.add_index_field solr_name("other_title", :stored_searchable), label: I18n.t('willow.fields.other_title')
    config.add_index_field solr_name("funder", :stored_searchable), label: I18n.t('willow.fields.funder')
    config.add_index_field solr_name("identifier_nested", :symbol), label: I18n.t('willow.fields.identifier_nested')
    config.add_index_field solr_name("category", :stored_searchable), label: I18n.t('willow.fields.category')
    config.add_index_field solr_name("rating", :stored_searchable), label: I18n.t('willow.fields.rating')
    config.add_index_field solr_name("rights_holder", :stored_searchable), label: I18n.t('willow.fields.rights_holder')
    config.add_index_field solr_name("organisation_nested", :stored_searchable), label: I18n.t('willow.fields.organisation_nested'), itemprop: 'organisation', link_to_search: solr_name("organisation_nested", :facetable)
    config.add_index_field solr_name("preservation_nested", :stored_searchable), label: I18n.t('willow.fields.preservation_nested'), itemprop: 'preservation'
    # solr fields to be displayed in the show (single result) view
    #   The ordering of the field names is the order of the display
    # RDSS CDM additions:
    config.add_show_field solr_name("title", :stored_searchable), label: I18n.t('willow.fields.title')
    config.add_show_field solr_name("object_description", :stored_searchable), label: I18n.t('willow.fields.object_description')
    config.add_show_field solr_name("object_keywords", :stored_searchable), label: I18n.t('willow.fields.object_keywords')
    config.add_show_field solr_name("object_category", :stored_searchable), label: I18n.t('willow.fields.object_category')    
    # End of RDSS CDM additions

    config.add_show_field solr_name("description", :stored_searchable), label: I18n.t('willow.fields.description')
    config.add_show_field solr_name("keyword", :stored_searchable), label: I18n.t('willow.fields.keyword')
    config.add_show_field solr_name("subject", :stored_searchable), label: I18n.t('willow.fields.subject')
    config.add_show_field solr_name("subject_nested", :displayable), label: I18n.t('willow.fields.subject_nested')
    config.add_show_field solr_name("creator", :stored_searchable), label: I18n.t('willow.fields.creator')
    config.add_show_field solr_name("creator_nested", :displayable), label: I18n.t('willow.fields.creator_nested')
    config.add_show_field solr_name("contributor", :stored_searchable), label: I18n.t('willow.fields.contributor')
    config.add_show_field solr_name("publisher", :stored_searchable), label: I18n.t('willow.fields.publisher')
    config.add_show_field solr_name("based_near_label", :stored_searchable), label: I18n.t('willow.fields.based_near_label')
    config.add_show_field solr_name("language", :stored_searchable), label: I18n.t('willow.fields.language')
    config.add_show_field solr_name("date_uploaded", :stored_searchable), label: I18n.t('willow.fields.date_uploaded')
    config.add_show_field solr_name("date_modified", :stored_searchable), label: I18n.t('willow.fields.date_modified')
    config.add_show_field solr_name("date_created", :stored_searchable), label: I18n.t('willow.fields.date_created')
    config.add_show_field solr_name("rights", :stored_searchable), label: I18n.t('willow.fields.rights')
    config.add_show_field solr_name("license_nested", :displayable), label: I18n.t('willow.fields.license_nested')
    config.add_show_field solr_name("resource_type", :stored_searchable), label: I18n.t('willow.fields.resource_type')
    config.add_show_field solr_name("format", :stored_searchable), label: I18n.t('willow.fields.format')
    config.add_show_field solr_name("identifier", :symbol), label: I18n.t('willow.fields.identifier')
    #Dataset show fields
    config.add_show_field solr_name("doi", :stored_searchable), label: I18n.t('willow.fields.doi')
    config.add_show_field solr_name("other_title", :displayable), label: I18n.t('willow.fields.other_title')
    config.add_show_field solr_name("date", :displayable), label: I18n.t('willow.fields.date')
    config.add_show_field solr_name("relation", :displayable), label: I18n.t('willow.fields.relation')
    config.add_show_field solr_name("admin_metadata", :displayable), label: I18n.t('willow.fields.admin_metadata')
    #Article show fields
    config.add_show_field solr_name("coverage", :stored_searchable), label: I18n.t('willow.fields.coverage')
    config.add_show_field solr_name("apc", :stored_searchable), label: I18n.t('willow.fields.apc')
    config.add_show_field solr_name("tagged_version", :stored_searchable), label: I18n.t('willow.fields.tagged_version')
    config.add_show_field solr_name("project_nested", :displayable), label: I18n.t('willow.fields.project_nested')
    config.add_show_field solr_name("identifier_nested", :displayable), label: I18n.t('willow.fields.identifier_nested')
    config.add_show_field solr_name("category", :stored_searchable), label: I18n.t('willow.fields.category')
    config.add_show_field solr_name("rating", :stored_searchable), label: I18n.t('willow.fields.rating')
    config.add_show_field solr_name("rights_holder", :stored_searchable), label: I18n.t('willow.fields.rights_holder')
    config.add_show_field solr_name("organisation_nested", :displayable), label: I18n.t('willow.fields.organisation_nested')
    config.add_show_field solr_name("preservation_nested", :displayable), label: I18n.t('willow.fields.preservation_nested')

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
      title_name = solr_name("title", :stored_searchable)
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
    config.add_search_field('contributor') do |field|
      # solr_parameters hash are sent to Solr as ordinary url query params.

      # :solr_local_parameters will be sent using Solr LocalParams
      # syntax, as eg {! qf=$title_qf }. This is neccesary to use
      # Solr parameter de-referencing like $title_qf.
      # See: http://wiki.apache.org/solr/LocalParams
      solr_name = solr_name("contributor", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('creator') do |field|
      solr_name = solr_name("creator", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('creator_nested') do |field|
      solr_name = solr_name("creator_nested", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('identifier_nested') do |field|
      solr_name = solr_name("identifier_nested", :symbol)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('title') do |field|
      solr_name = solr_name("title", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('description') do |field|
      field.label = "Abstract or Summary"
      solr_name = solr_name("description", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('publisher') do |field|
      solr_name = solr_name("publisher", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('date_created') do |field|
      solr_name = solr_name("created", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('subject') do |field|
      solr_name = solr_name("subject", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('subject_nested') do |field|
      solr_name = solr_name("subject_nested", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('language') do |field|
      solr_name = solr_name("language", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('resource_type') do |field|
      solr_name = solr_name("resource_type", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('format') do |field|
      solr_name = solr_name("format", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('identifier') do |field|
      solr_name = solr_name("id", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('based_near') do |field|
      field.label = "Location"
      solr_name = solr_name("based_near_label", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('keyword') do |field|
      solr_name = solr_name("keyword", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('depositor') do |field|
      solr_name = solr_name("depositor", :symbol)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('rights') do |field|
      solr_name = solr_name("rights", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('license_nested') do |field|
      solr_name = solr_name("license_nested", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('other_title') do |field|
      solr_name = solr_name("other_title", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('doi') do |field|
      solr_name = solr_name("doi", :facetable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('category') do |field|
      solr_name = solr_name("category", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('rating') do |field|
      solr_name = solr_name("rating", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('rights_holder') do |field|
      solr_name = solr_name("rating", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('organisation_nested') do |field|
      solr_name = solr_name("organisation_nested", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the SOLR field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case).
    # label is key, solr field is value
    config.add_sort_field "score desc, #{uploaded_field} desc", label: "relevance"
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
