module Indicators
  #
  # Commodity Channel Index
  class Cci
    # Based on https://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:commodity_channel_index_cci
    # CCI = (Typical Price  -  20-period SMA of TP) / (.015 x Mean Deviation)

    # Typical Price (TP) = (High + Low + Close)/3

    # Constant = .015

    # There are four steps to calculating the Mean Deviation:
    # First, subtract the most recent 20-period average of the typical price from each period's typical price.
    # Second, take the absolute values of these numbers.
    # Third, sum the absolute values.
    # Fourth, divide by the total number of periods (20).
    def self.calculate data, parameters
      periods = parameters
      output = Array.new
      adj_closes = Indicators::Helper.validate_data(data, :adj_close, periods)
      highs = Indicators::Helper.validate_data(data, :high, periods)
      lows = Indicators::Helper.validate_data(data, :low, periods)

      tps = [adj_closes, highs, lows].transpose.map { |close, high, low| (close + high + low) / 3.0 }
      tps.each_with_index do |tp, index|
        if index+1 >= periods
          current_period = tps[(index-periods+1)..index]
          sma = current_period.mean
          mean_deviation = current_period.mean_deviation

          output[index] = (tp - sma) / (0.015 * mean_deviation)
        else
          output[index] = nil
        end
      end

      return output
    end
  end
end