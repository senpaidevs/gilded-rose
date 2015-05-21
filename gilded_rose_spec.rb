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

      context "when a Backstage pass is updated" do
        it "its quality is incremented" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)]

          GildedRose.new(items).update_quality

          expect(items[0].quality).to eq(21)
        end

        context "when concert is 10 days left or less" do
          it "its quality is incremented by 2" do
            items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 20)]

            GildedRose.new(items).update_quality

            expect(items[0].quality).to eq(22)
          end
        end

        context "when concert is 5 days left or less" do
          it "its quality is incremented by 3" do
            items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 20)]

            GildedRose.new(items).update_quality

            expect(items[0].quality).to eq(23)
          end
        end
        context "when concert date is passed" do
          it "its quality is set to zero" do
            items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 20)]

            GildedRose.new(items).update_quality

            expect(items[0].quality).to eq(0)
          end
        end


      end
    end
  end
end
