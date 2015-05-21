require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  let(:a_name) { 'irrelevant name' }

  context "when updating quality" do
    context "when updating normal items" do
      before(:each) do
        @items = [Item.new(a_name, 10, 20)]

        GildedRose.new(@items).update_quality()
      end

      it "decreases sell in" do
        expect(@items[0].sell_in).to eq(9)
      end

      it "decreases item quality" do
        expect(@items[0].quality).to eq(19)
      end

      context "when sell by date has passed" do
        it "quality decreases twice as fast" do
          items = [Item.new(a_name, 0, 20)]

          GildedRose.new(items).update_quality()

          expect(items[0].quality).to eq(18)
        end
      end

    end
  end
end
