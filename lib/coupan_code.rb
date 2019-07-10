require "./lib/calculation"

class CoupanCode

  include Calculation
  def initialize
    @coupans = [{"code" => "AVAIL5", "offer_percentage" => 5},{"code" => "AVAIL10", "offer_percentage" => 10},{"code" => "AVAIL7", "offer_percentage" => 7}]
  end

  def coupan_codes
  	@coupans
  end

  def validate_coupan(coupan)
  	coupan_status = false
  	get_coupan = @coupans.detect {|f| f["code"] == coupan }
  	unless get_coupan.nil?
  		coupan_status = true
  	end
  	return coupan_status
  end

  def apply_offer(selected_items, coupan)
  	get_coupan = @coupans.detect {|f| f["code"] == coupan }
  	selected_items["total"] = Calculation.grand_coupan(selected_items["total"], get_coupan["offer_percentage"])
  end

end
