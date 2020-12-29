require 'rails_helper'

RSpec.describe Album, type: :model do
  let(:player_maddona) { Player.create(name: 'Maddona') }

  it 'is valid with valid attributes' do
    expect(Album.new(name: 'Madame X', player: player_maddona)).to be_valid
  end

  it 'is not valid without a name' do
    album = Album.new(name: nil, player: player_maddona)
    expect(album).to_not be_valid
  end

  context 'when there is already an album queries of the player id' do
    before do
      @album_american_life =
        Album.create(name: 'American Life', player: player_maddona)
    end

    it 'return album by player id' do
      album_query = Album.where(player_id: player_maddona.id).last
      expect(album_query.name).to eql(@album_american_life.name)
      expect(album_query.player_id).to eql(player_maddona.id)
    end
  end

  context 'when the album is of two players' do
    let(:album_madame_x) { Album.create(name: 'Madame X') }
    let(:player_shakira) { Player.create(name: 'Shakira') }

    it 'have created a relationship with Maddona and Shakira' do
      album_madame_x.players << player_maddona
      album_madame_x.players << player_shakira


      expect(album_madame_x.players[0]).to eql(player_maddona)
      expect(album_madame_x.players[1]).to eql(player_shakira)
    end
  end
end
