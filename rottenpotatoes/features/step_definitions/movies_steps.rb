
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    step %{I #{uncheck.nil? ? '' : 'un'}check "ratings_#{rating}"}
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  Movie.all.each do |movie|
    step %{I should see "#{movie.title}"}
  end
end

#added
When /I go to the edit page for "(.*)"/ do |title|
  movie = Movie.find_by(title: title)
  visit edit_movie_path(movie)
end

When /I fill in "(.*)" with "(.*)"/ do |field, value|
  fill_in(field, with: value)
end

When /I press "(.*)"/ do |button_name|
  click_button(button_name)
end

Then /the director of "(.*)" should be "(.*)"/ do |title, director|
  movie = Movie.find_by(title: title)
  expect(movie.director).to eq(director)
end

Given /I am on the details page for "(.*)"/ do |title|
  movie = Movie.find_by(title: title)
  visit movie_path(movie)
end

When /I follow "(.*)"/ do |link|
  click_link(link)
end

Then /I should be on the Similar Movies page for "(.*)"/ do |title|
  movie = Movie.find_by(title: title)
  expect(page).to have_content("Other Movies by #{movie.director}")
end



Then /I should see "(.*)"/ do |content|
  expect(page).to have_content(content)
end


Then /I should not see the "(.*)" link/ do |link_text|
  expect(page).not_to have_link(link_text)
end




Then /I should be on the home page/ do
  expect(current_path).to eq(movies_path)
end

Then /I should not see "(.*)"/ do |content|
  expect(page).not_to have_content(content)
end

Then /I should see "(.*)" has no director info/ do |title|
  expect(page).to have_content("'#{title}' has no director info")
end


