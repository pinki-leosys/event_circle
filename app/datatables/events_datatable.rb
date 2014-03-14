class EventsDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view
  @count = 1 
  def initialize(view, user)
    @view = view
    @user = user
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: get_count,
      iTotalDisplayRecords: events.total_entries,
      aaData: data
    }
  end

private

  def data
    events.map do |event|
      [
        h(event.title),
        h(event.venue),
        h(event.event_start_date),
        h(event.event_end_date),
        link_to("SHOW", event)
      ]
    end
  end
  def get_count
    if params[:action] == "events_attended"
      return @user.registered_events.count
    else
      Event.where(published: true).count
    end
  end

  def events
    @events ||= fetch_events
  end

  def fetch_events
    if params[:action] == "events_attended"
      events = @user.registered_events.order("#{sort_column} #{sort_direction}")
      @count=events.count
      events = events.page(page).per_page(per_page)
      if params[:sSearch].present?
        events = events.where("title like :search or venue like :search", search: "%#{params[:sSearch]}%")
      end
    else
      events = Event.where(published: true).order("#{sort_column} #{sort_direction}")
      events = events.page(page).per_page(per_page)
      if params[:sSearch].present?
        events = events.where("title like :search or venue like :search", search: "%#{params[:sSearch]}%")
        @count=events.count
      end
    end
      events
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[event_start_date published_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end

