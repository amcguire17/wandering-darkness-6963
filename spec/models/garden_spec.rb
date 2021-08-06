require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
  end

  describe 'instance methods' do
    describe '#plants_harvest_below_100' do
      it 'lists all plants in garden with harvest that takes less than 100 days' do
        garden_1 = Garden.create!(name: 'Sunset Gardens', organic: false)
        garden_2 = Garden.create!(name: 'Sunrise Gardens', organic: true)
        plot_1 = garden_1.plots.create!(number: 15, size: 'Medium', direction: 'West')
        plot_2 = garden_1.plots.create!(number: 15, size: 'Medium', direction: 'South')
        plot_3 = garden_2.plots.create!(number: 30, size: 'Large', direction: 'East')
        plant_1 = Plant.create!(name: 'carrot', description: 'keep watered and fertilized', days_to_harvest: 80)
        plant_2 = Plant.create!(name: 'strawberries', description: 'plant in matted rows', days_to_harvest: 100)
        plant_3 = Plant.create!(name: 'grape tomato', description: 'lots of sun', days_to_harvest: 75)
        plant_4 = Plant.create!(name: 'spinach', description: 'lots of water', days_to_harvest: 60)
        plant_5 = Plant.create!(name: 'pumpkin', description: 'likes warm soil and space', days_to_harvest: 105)
        plant_6 = Plant.create!(name: 'acorn squash', description: 'likes warm soil and space', days_to_harvest: 95)
        plot_1.plants << plant_1
        plot_1.plants << plant_2
        plot_2.plants << plant_3
        plot_2.plants << plant_4
        plot_3.plants << plant_5
        plot_3.plants << plant_6

        expect(garden_1.plants_harvest_below_100.length).to eq(3)
        expect(garden_1.plants_harvest_below_100.first.name).to eq(plant_1.name)
        expect(garden_1.plants_harvest_below_100.second.name).to eq(plant_3.name)
        expect(garden_1.plants_harvest_below_100.third.name).to eq(plant_4.name)
      end
    end
  end
end
