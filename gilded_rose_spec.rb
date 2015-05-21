require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  let(:a_name) { 'irrelevant name' }

  context "when updating quality" do
    context "when updating normal items" do
      before(:each) do
        @items = [Item.new(a_name, 10, 20)]

        GildedRose.new(@items).update_quality
      end

      it "doesn't have a negative quality value" do
        items = [Item.new(a_name, 10, 0)]

        GildedRose.new(items).update_quality

        expect(items[0].quality).to be >= 0
      end

      it "decreases sell in" do
        expect(@items[0].sell_in).to eq(9)
      end

      it "decreases item quality" do
        expect(@items[0].quality).to eq(19)
      end

      it "never its quality is more than 50" do
        items = [Item.new(a_name, 10, 60)]

        GildedRose.new(items).update_quality

        expect(@items[0].quality).to be <= 50
      end

      context "when sell by date has passed" do
        it "quality decreases twice as fast" do
          items = [Item.new(a_name, 0, 20)]

          GildedRose.new(items).update_quality

          expect(items[0].quality).to eq(18)
        end
      end
    end
    context "special items" do
      context "when Aged Brie is updated" do
        it "increases its quality" do
          items = [Item.new("Aged Brie", 10, 20)]

          GildedRose.new(items).update_quality

          expect(items[0].quality).to eq(21)
        end
      end
      context "when Sulfuras is updated" do
        before(:each) do
          @items = [Item.new("Sulfuras, Hand of Ragnaros",10,20)]

          GildedRose.new(@items).update_quality
        end

        it "never modifies its quality" do
           expect(@items[0].quality).to eq(20)
        end

        it "never modifies its sell in" do
          expect(@items[0].sell_in).to eq(10)
        end
      end
    end
  end
end
