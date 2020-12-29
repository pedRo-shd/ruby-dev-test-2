require 'rails_helper'

RSpec.describe Player, type: :model do
  it 'is valid with valid attributes' do
    expect(Player.new(name: 'Maddona')).to be_valid
  end

  it 'is not valid without a name' do
    player = Player.new(name: nil)
    expect(player).to_not be_valid
  end

  context 'when there is already an player queries of the albums before HABTM' do
    before do
      @player_maddona = Player.create(name: 'Maddona')
      @album_madame_x = Album.create(name: 'Madame X', player_id: @player_maddona.id)
      @album_american_life =
        Album.create(name: 'American Life', player_id: @player_maddona.id)
    end

    it 'player must have albums Madame X and American Life' do
      basic_sql =
        "SELECT DISTINCT * FROM players LEFT OUTER JOIN albums ON albums.player_id = 1"
      records_array = ActiveRecord::Base.connection.execute(basic_sql)
      expect(records_array.first["name"]).to eql(@album_madame_x.name)
      expect(records_array.last["name"]).to eql(@album_american_life.name)
    end
  end
end
