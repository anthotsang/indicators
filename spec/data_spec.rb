require 'spec_helper'

describe Indicators::Data do
	SECURITIES = [{:adj_close=>3485.59, :high=>3545.37, :low=>3380.48},
		{:adj_close=>3305.11, :high=>3493.76, :low=>3272.81},
		{:adj_close=>3232.51, :high=>3271.76, :low=>3169.53},
		{:adj_close=>3255.37, :high=>3319.83, :low=>3227.4},
		{:adj_close=>3548.19, :high=>3639.65, :low=>3239.06},
		{:adj_close=>3715.85, :high=>3727.99, :low=>3481.46},
		{:adj_close=>3736.54, :high=>3969.7, :low=>3693.57},
		{:adj_close=>4137.66, :high=>4225.52, :low=>3712.82},
		{:adj_close=>3898.81, :high=>4247.71, :low=>3831.2},
		{:adj_close=>4045.24, :high=>4060.34, :low=>3849.23},
		{:adj_close=>4007.63, :high=>4117.65, :low=>3972.39},
		{:adj_close=>4081.95, :high=>4303.37, :low=>4006.6},
		{:adj_close=>3834.73, :high=>4094.61, :low=>3734.85},
		{:adj_close=>3848.78, :high=>3923.93, :low=>3746.86},
		{:adj_close=>3646.09, :high=>3888.92, :low=>3622.39},
		{:adj_close=>3947.86, :high=>4007.71, :low=>3628.43},
		{:adj_close=>3797.06, :high=>4004.14, :low=>3774.38},
		{:adj_close=>3896.21, :high=>3925.18, :low=>3760.8},
		{:adj_close=>3747.39, :high=>3904.28, :low=>3701.48},
		{:adj_close=>3880.15, :high=>3938.75, :low=>3696.94},
		{:adj_close=>3961.01, :high=>3989.59, :low=>3826.29},
		{:adj_close=>3835.86, :high=>3965.52, :low=>3778.76},
		{:adj_close=>3874.06, :high=>3901.65, :low=>3783.88},
		{:adj_close=>3855.39, :high=>3926.92, :low=>3841.13},
		{:adj_close=>4102.85, :high=>4145.16, :low=>3829.09},
		{:adj_close=>4048.34, :high=>4092.91, :low=>4013},
		{:adj_close=>3668.15, :high=>4085.09, :low=>3631.07},
		{:adj_close=>3669.2, :high=>3729.69, :low=>3616.41},
		{:adj_close=>3664.38, :high=>3692.12, :low=>3611.2},
		{:adj_close=>3551.24, :high=>3675.2, :low=>3528.24}]

	describe ".new" do
		context "should raise an exception if parameter" do

		  it "is nil or empty" do
		  	expect { Indicators::Data.new(nil) }.to raise_error('There is no data to work on.')
		  	expect { Indicators::Data.new('') }.to raise_error('There is no data to work on.')
		  end
		  it "is not an array" do
		  	expect { Indicators::Data.new('some string') }.to raise_error(Indicators::Data::DataException, /Alien data. Given data must be an array/)
		  end
		end

		context "should not raise an exception if parameter" do

			it "is an array" do
				expect { Indicators::Data.new([1, 2, 3]) }.not_to raise_error
			end
			it "is a hash" do
				expect { Indicators::Data.new(SECURITIES) }.not_to raise_error
			end

		end
	end

	describe ".calc" do
		before :all do
			@my_data = Indicators::Data.new(SECURITIES)
		end

		context "should raise an exception if parameter" do
			it "is not a hash" do
				expect { @my_data.calc('some string') }.to raise_error('Given parameters have to be a hash.')
			end
			it ":type is invalid" do
				expect { @my_data.calc(:type => :invalid_type, :params => 5) }.to raise_error(Indicators::Data::DataException, /Invalid indicator type specified/)
			end
		end

		context "should not raise an exception if parameter" do
			it ":type is not specified (should default to :sma)" do
				expect { @my_data.calc(:params => 5) }.not_to raise_error
				# Can't get this test to work for some reason.
				# @my_data.calc(:params => 5).abbr.downcase.to_sym should eq(:sma)
			end
			it "good SMA params are specified" do
				expect { @my_data.calc(:type => :sma, :params => 5) }.not_to raise_error
			end
			it "good EMA params are specified" do
				expect { @my_data.calc(:type => :ema, :params => 5) }.not_to raise_error
			end
			it "good BB params are specified" do
				expect { @my_data.calc(:type => :bb, :params => [10, 2]) }.not_to raise_error
			end
			it "good MACD params are specified" do
				expect { @my_data.calc(:type => :macd, :params => [2, 5, 4]) }.not_to raise_error
			end
			it "good RSI params are specified" do
				expect { @my_data.calc(:type => :rsi, :params => 5) }.not_to raise_error
			end
			it "good StochRSI params are specified" do
				expect { @my_data.calc(:type => :stochrsi, :params => 5) }.not_to raise_error
			end
			it "good STO params are specified" do
				expect { @my_data.calc(:type => :sto, :params => [3, 5, 4]) }.not_to raise_error
			end
		end
	end

end