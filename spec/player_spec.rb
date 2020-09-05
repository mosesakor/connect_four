RSpec.describe '#Player' do
  
  context '#initialize' do
    it 'it initializes a player with a name' do
      input = { name: 'rob', disc: 'x' }
      player = Player.new(input)
      expect(player.name).to eq('rob')
    end

    it 'it initializes a player with a disc' do
      input = { name: 'rob', disc: 'x' }
      player = Player.new(input)
      expect(player.disc).to eq('x')
    end
  end
end

