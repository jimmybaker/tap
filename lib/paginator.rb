# frozen_string_literal: true

class Paginator
  attr_reader :item_count, :page_count, :page, :per_page, :records

  def initialize(finder, page: 1, per: 10)
    @item_count = finder.count
    @page = page
    @per_page = per
    @page_count = item_count / per_page

    offset = (page - 1) * per
    @records = finder.limit(per).offset(offset)
  end
end
