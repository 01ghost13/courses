courses = 10.times.map { |i| Course.create!(name: "Course ##{i}") }
CAPACITY = 3
groups = courses.flat_map do |course|
  3.times.map do |index|
    date_start = Date.current + index.months + course.id.days

    Group.create!(
      date_start: date_start,
      date_finish: date_start + 10.days,
      course_id: course.id,
      max_students: CAPACITY
    )
  end
end

# make one full
last = groups.last
CAPACITY.times { |i| last.students.create(email: "student_#{i}@mail.ru") }
groups.first.students.create(email: 'one_student@email.ru')
