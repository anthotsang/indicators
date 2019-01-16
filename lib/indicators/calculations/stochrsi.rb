module Indicators
  #
  # Stochastic Relative Strength Index
  class StochRsi

    # StochRSI = (RSI - Lowest Low RSI) / (Highest High RSI - Lowest Low RSI)
    #               100
    # RSI = 100 - --------
    #              1 + RS
    # RS = Average Gain / Average Loss
    # First Average Gain = Sum of Gains over the past 14 periods / 14
    # First Average Loss = Sum of Losses over the past 14 periods / 14
    # Average Gain = [(previous Average Gain) x 13 + current Gain] / 14.
    # Average Loss = [(previous Average Loss) x 13 + current Loss] / 14.
    def self.calculate data, parameters
      periods = parameters
      output = Array.new
      base_rsi = Indicators::Rsi.calculate(data, parameters)

      base_rsi.each_with_index do |rsi, index|
        if index >= periods * 2 - 1
          lastest_rsi_period = base_rsi.slice(index - periods + 1, periods)
          lowest_low = lastest_rsi_period.min
          highest_high = lastest_rsi_period.max
          output[index] = (rsi - lowest_low) / (highest_high - lowest_low)
        else
          output[index] = nil
        end
      end

      return output

    end
  end
end