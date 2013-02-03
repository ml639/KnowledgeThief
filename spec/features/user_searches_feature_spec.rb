# Specification for searching feature of the website
require 'spec_helper'

feature 'User searches' do
		scenario 'and gets no results' do
			visit  '/'
			fill_in 'search_input_text', :with => 'adlskfj;alskdfjalsdkfjasdflkjdfs'
			find_by_id('search_button').click
		end

		scenario 'and gets results' do
			visit  '/'
			fill_in 'search_input_text', :with => 'harvard'
			find_by_id('search_button').click
		end

		scenario 'with sql in the query' do
			visit  '/'
			fill_in 'search_input_text', :with => 'harvard OR try'
			find_by_id('search_button').click
		end

		scenario 'while not logged in' do
			visit  '/'
			fill_in 'search_input_text', :with => 'test'
			find_by_id('search_button').click
		end

		scenario 'while logged in' do
			visit  '/'
			find_by_id('login-trigger').click
			fill_in 'user_email', :with => 'test@testing.com'
			fill_in 'user_password', :with => 'testing'
			find('input[type="submit"][name="commit"]').click
			fill_in 'search_input_text', :with => 'test'
			find_by_id('search_button').click
		end

		scenario 'and filters the results' do
			visit  '/'
			fill_in 'search_input_text', :with => 'harvard'
			find_by_id('search_button').click
			select 'Article', :from => "filter__media_type"
			find_by_id('search_button').click
		end

		scenario 'and sorts the results' do
			visit  '/'
			fill_in 'search_input_text', :with => 'harvard'
			find_by_id('search_button').click
			select 'Votes', :from => "filter__sort"
			find_by_id('search_button').click
		end	
end
