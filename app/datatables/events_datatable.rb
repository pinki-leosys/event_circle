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
        h(event.event_start_date.strftime("%b %d,%Y")),
        h(event.event_start_date.strftime("%I:%M%p")),
        h(event.registered_users.count),
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
    events= get_events
    events = events.page(page).per_page(per_page)
    @count=events.count
      if params[:sSearch].present?
        events = events.where("title like :search or venue like :search", search: "%#{params[:sSearch]}%")
      end   
      events
  end

  def get_events
    if params[:action] == "events_attended"
      events = @user.registered_events.where("event_start_date < ? AND event_end_date < ?", Time.zone.now,Time.zone.now).order("#{sort_column} #{sort_direction}")
    elsif params[:action] == "current_events"
      events = Event.where("event_start_date <= ? AND event_end_date > ? AND published = ?", Time.zone.now,Time.zone.now, true)
    elsif  params[:action] == "events_registered"
      events = @user.registered_events.where("event_start_date > ?", Time.zone.now).order("#{sort_column} #{sort_direction}")
    elsif params[:action] == "events_hosted"
      events = @user.events.where("event_end_date < ? AND event_start_date < ? AND published = ?", Time.zone.now,Time.zone.now, true)
    elsif  params[:action] == "upcoming_events"
        events = @user.events.where("event_start_date > ? AND published = ?", Time.zone.now,true).order("#{sort_column} #{sort_direction}")
    elsif  params[:action] == "saved_events"
      events = @user.events.where(published: false)
    elsif  params[:action] == "host_current_events"
        events = @user.events.where("event_start_date <= ? AND event_end_date > ? AND published = ?",  Time.zone.now,Time.zone.now,true).order("#{sort_column} #{sort_direction}")
    else
      #params[:action] == "current_host_events"
    end
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

