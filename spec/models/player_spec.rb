require 'rails_helper'

RSpec.describe Player, type: :model do
  it 'is valid with valid attributes' do
    expect(Player.new(name: 'Maddona')).to be_valid
  end

  it 'is not valid without a name' do
    player = Player.new(name: nil)
    expect(player).to_not be_valid
  end

  context 'when the player is of two albums' do
    before do
      @player_maddona = Player.create(name: 'Maddona')
      @album_madame_x = Album.create(name: 'Madame X', player: @player_maddona)
      @album_american_life =
        Album.create(name: 'American Life', player: @player_maddona)
    end

    it 'have albums Madame X and American Life' do
      expect(@player_maddona.albums.first).to eql(@album_madame_x)
      expect(@player_maddona.albums.last).to eql(@album_american_life)
    end
  end
end
