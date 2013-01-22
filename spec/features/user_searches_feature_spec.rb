# Specification for searching feature of the website
require 'spec_helper'

feature 'User searches' do
		scenario 'and gets no results' do
			visit  '/'
			fill_in 'search_input_text', :with => 'test'
			find_by_id('search_button').click
		end

		scenario 'and gets results' do
	
		end

		scenario 'with a malformed query' do

		end

		scenario 'with sql in the query' do

		end

		scenario 'while not logged in' do

		end

		scenario 'while logged in' do

		end

		scenario 'and filters the results' do

		end

		scenario 'and sorts the results' do

		end	
end

