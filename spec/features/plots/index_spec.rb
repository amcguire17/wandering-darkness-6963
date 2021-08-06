require 'rails_helper'

RSpec.describe 'Plots Index Page' do
  before :each do
    @garden_1 = Garden.create!(name: 'Sunset Gardens', organic: false)
    @garden_2 = Garden.create!(name: 'Sunrise Gardens', organic: true)
    @plot_1 = @garden_1.plots.create!(number: 15, size: 'Medium', direction: 'West')
    @plot_2 = @garden_1.plots.create!(number: 15, size: 'Medium', direction: 'South')
    @plot_3 = @garden_2.plots.create!(number: 30, size: 'Large', direction: 'East')
    @plant_1 = Plant.create!(name: 'carrot', description: 'keep watered and fertilized', days_to_harvest: 80)
    @plant_2 = Plant.create!(name: 'strawberries', description: 'plant in matted rows', days_to_harvest: 100)
    @plant_3 = Plant.create!(name: 'grape tomato', description: 'lots of sun', days_to_harvest: 75)
    @plant_7 = Plant.create!(name: 'grape tomato', description: 'lots of sun', days_to_harvest: 75)
    @plant_4 = Plant.create!(name: 'spinach', description: 'lots of water', days_to_harvest: 60)
    @plant_5 = Plant.create!(name: 'pumpkin', description: 'likes warm soil and space', days_to_harvest: 105)
    @plant_6 = Plant.create!(name: 'acorn squash', description: 'likes warm soil and space', days_to_harvest: 95)
    @plot_1.plants << @plant_1
    @plot_1.plants << @plant_2
    @plot_2.plants << @plant_3
    @plot_2.plants << @plant_7
    @plot_2.plants << @plant_4
    @plot_3.plants << @plant_5
    @plot_3.plants << @plant_6

    visit "/plots"
  end
  describe 'plot lists' do
    it 'lists all plots' do
      expect(page).to have_content(@plot_1.number)
      expect(page).to have_content(@plot_2.number)
      expect(page).to have_content(@plot_3.number)
    end
    it 'lists all plants in each plot' do
      within("#plot-#{@plot_1.id}") do
        expect(page).to have_content(@plant_1.name)
        expect(page).to have_content(@plant_2.name)
        expect(page).to_not have_content(@plant_3.name)
      end
      within("#plot-#{@plot_2.id}") do
        expect(page).to have_content(@plant_3.name)
        expect(page).to have_content(@plant_4.name)
        expect(page).to have_content(@plant_7.name)
        expect(page).to_not have_content(@plant_5.name)
      end
      within("#plot-#{@plot_3.id}") do
        expect(page).to have_content(@plant_5.name)
        expect(page).to have_content(@plant_6.name)
        expect(page).to_not have_content(@plant_1.name)
      end
    end
  end
  describe 'remove plants from plot' do
    it 'has a link to remove plants from plot' do
      within("#plant-#{@plant_1.id}") do
        expect(page).to have_link('Remove')
      end
      within("#plant-#{@plant_3.id}") do
        expect(page).to have_link('Remove')
      end
      within("#plant-#{@plant_5.id}") do
        expect(page).to have_link('Remove')
      end
    end
    it 'removes plant from plot when link is clicked' do
      within("#plant-#{@plant_7.id}") do
        click_link 'Remove'
        expect(current_path).to eq("/plots")
      end
      expect(page).to_not have_css("#plant-#{@plant_7.id}")
      expect(@plant_7).to be_a(Plant)
    end
  end
end
