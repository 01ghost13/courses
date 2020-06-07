class CoursesIndex
  PAGE_LIMIT = 5

  attr_reader :query

  def initialize
    @query = Group
      .includes(:course, :students)
      .bookable
      .from(soonest_with_places, :groups)
  end

  def ransack_query(query)
    @ransack_query ||= @query.ransack(query)
  end

  def paged(page)
    q =
      if @ransack_query.present?
        @ransack_query.result
      else
        @query
      end

    @result ||= q.page(page).per(PAGE_LIMIT)
  end

  private

    def soonest_with_places
      sub_group = Group
        .select("distinct on(sub_group.course_id) sub_group.*")
        .order("sub_group.course_id, sub_group.date_start")
      sub_group.from(has_places, :sub_group)
    end


    def has_places
      grouped = Group.select('groups.*, count(students.id) as students_count').left_outer_joins(:students).group('groups.id')
      Group.select('not_full.*').from(grouped, :not_full).where('not_full.students_count < not_full.max_students')
    end
end
