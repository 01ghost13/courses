courses = 10.times.map { |i| Course.create!(name: "Course ##{i}") }

groups = courses.flat_map do |course|
  3.times.map do |index|
    date_start = Date.current + index.months + course.id.days

    Group.create!(
      date_start: date_start,
      date_finish: date_start + 10.days,
      course_id: course.id
    )
  end
end

groups = groups.group_by(&:course_id)

