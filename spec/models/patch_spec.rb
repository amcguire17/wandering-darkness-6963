require 'rails_helper'

RSpec.describe Patch do
  describe 'relationships' do
    it { should belong_to(:plant) }
    it { should belong_to(:plot) }
  end

  describe 'class methods' do
    describe '.find_plant_plot' do
      it 'can find the patch by plant and plot ids' do
        garden_1 = Garden.create!(name: 'Sunset Gardens', organic: false)
        plot_1 = garden_1.plots.create!(number: 15, size: 'Medium', direction: 'West')
        plant_1 = Plant.create!(name: 'carrot', description: 'keep watered and fertilized', days_to_harvest: 80)
        plant_2 = Plant.create!(name: 'strawberries', description: 'plant in matted rows', days_to_harvest: 100)
        patch_1 = Patch.create!(plot_id: plot_1.id, plant_id: plant_1.id)
        patch_2 = Patch.create!(plot_id: plot_1.id, plant_id: plant_2.id)
        expect(Patch.find_plant_plot(plot_1.id, plant_1.id)).to eq(patch_1)
      end
    end
  end
end
