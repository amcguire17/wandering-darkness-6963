require 'rails_helper'

RSpec.describe 'Garden Show Page' do
  before :each do
    @garden = Garden.create!(name: 'Sunset Gardens', organic: false)
    @plot_1 = @garden.plots.create!(number: 15, size: 'Medium', direction: 'West')
    @plot_2 = @garden.plots.create!(number: 15, size: 'Medium', direction: 'South')
    @plant_1 = Plant.create!(name: 'carrot', description: 'keep watered and fertilized', days_to_harvest: 80)
    @plant_2 = Plant.create!(name: 'strawberries', description: 'plant in matted rows', days_to_harvest: 100)
    @plant_3 = Plant.create!(name: 'grape tomato', description: 'lots of sun', days_to_harvest: 75)
    @plant_7 = Plant.create!(name: 'grape tomato', description: 'lots of sun', days_to_harvest: 75)
    @plant_4 = Plant.create!(name: 'spinach', description: 'lots of water', days_to_harvest: 60)
    @plot_1.plants << @plant_1
    @plot_1.plants << @plant_2
    @plot_2.plants << @plant_3
    @plot_2.plants << @plant_7
    @plot_2.plants << @plant_4

    visit "/gardens/#{@garden.id}"
  end
  it 'lists all plants in garden plots that take less than 100 days to harvest' do
    save_and_open_page
    expect(page).to have_content(@plant_1.name)
    expect(page).to have_content(@plant_3.name)
    expect(page).to have_content(@plant_4.name)
    expect(page).to_not have_content(@plant_2.name)
  end
  it 'plants are ordered by count' do
    expect(@plant_3.name).to appear_before(@plant_1.name)
    expect(@plant_1.name).to appear_before(@plant_4.name)
  end
end
