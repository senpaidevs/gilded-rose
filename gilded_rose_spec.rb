require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  let(:a_name) { 'irrelevant name' }

  context "when updating quality" do
    context "when updating normal items" do
      it "decreases sell in" do
        items = [Item.new(a_name, 10, 20)]

        GildedRose.new(items).update_quality()

        expect(items[0].sell_in).to eq(9)
      end
    end
  end

end
