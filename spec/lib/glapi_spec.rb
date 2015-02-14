require 'glapi_helper'


describe 'SMS API [normal app]' do	

	context 'Complete and Correct request parameters', :focus => true do
		#it should deduct 0.50 to developer's wallet
		it 'responds with code 201' do
			expect(pushSms('ok').code).to eq('201')
		end
	end

	context 'shortcode with prefix' do
		#it should deduct 0.50 to developer's wallet
		it 'responds with code 201' do
			expect(pushSms('prefix').code).to eq('201')
		end
	end

	context 'send sms > 160 characters'do
		#it should deduct 1.00 to developer's wallet
		it 'responds with code 201' do
			expect(pushSms('sms160').code).to eq('201')
		end
	end

	context 'send sms > 320 characters' do
		#it should deduct 1.50 to developer's wallet
		it 'responds with code 201' do
			expect(pushSms('sms320').code).to eq('201')
		end
	end

	context 'Extended Suffix (7)' do
		it 'responds with code 201' do
			expect(pushSms('extended').code).to eq('201')
		end
	end	

	context 'Extended Suffix (8)' do
		it 'responds with code 201' do
			expect(err('extended_err')).to eq('Invalid shortcode')
		end
	end

	context 'Invalid access_token[normal acct]' do
		it 'Error: Failed to authenticate' do
			expect(err('invalidToken')).to eq('Invalid access_token')
		end
	end

	context 'Missing query string (access_token)' do
		it 'Error: Failed to authenticate' do
			expect(err('token')).to eq('Missing parameters: access_token')
		end
	end

	context 'Missing address parameter' do
		it 'Error: missing parameters: address' do
			expect(err('address')).to eq('Missing parameters: address')
		end
	end

	context 'Missing message parameter' do
		it 'Error: missing parameters: message' do
			expect(err('message')).to eq('Missing parameters: message')
		end
	end

	context 'Empty message parameter' do
		it 'Error: Invalid Message: EMPTY MESSAGE' do
			expect(err('nil_message')).to eq('Invalid Message: EMPTY MESSAGE')
		end
	end

end


describe 'SMS API [by app]' do

	context 'Complete and Correct request parameters (Globe)' do
		#it should deduct .50 to developer's wallet
		it 'responds with code 201' do
			expect(pushSms_bp('ok').code).to eq('201')
		end
	end

	context 'Complete and Correct request parameters (xTelco)', :focus => true do
		#it should deduct .50 to developer's wallet
		it 'responds with code 201' do
			expect(xTelco('ok').code).to eq('201')
		end
	end

	context 'send sms > 160 characters' do
		#it should deduct 1.00 to developer's wallet
		it 'responds with code 201' do
			expect(xTelco('sms160').code).to eq('201')
		end
	end

	context 'send sms > 320 characters' do
		#it should deduct 1.50 to developer's wallet
		it 'responds with code 201' do
			expect(xTelco('sms320').code).to eq('201')
		end
	end

	context 'send sms > 160 characters'do
		#it should deduct 1.00 to developer's wallet
		it 'responds with code 201' do
			expect(pushSms_bp('sms160').code).to eq('201')
		end
	end

	context 'Extended Suffix (7)' do
		it 'responds with code 201' do
			expect(pushSms_bp('extended').code).to eq('201')
		end
	end	

	context 'send sms > 320 characters' do
		#it should deduct 1.50 to developer's wallet
		it 'responds with code 201' do
			expect(pushSms_bp('sms320').code).to eq('201')
		end
	end

	context 'invalid app_id and app_secret' do
		it 'Error: Failed to authenticate' do
			expect(err_bp('invalidIdSecret')).to eq('Invalid app id')
		end
	end

	context 'Missing address parameter' do
		it 'Error: missing parameters: address' do
			expect(err_bp('address')).to eq('Missing parameters: address')
		end
	end

	context 'Missing message parameter' do
		it 'Error: missing parameters: message' do
			expect(err_bp('message')).to eq('Missing parameters: message')
		end
	end

	context 'Empty message parameter' do
		it 'Error: Invalid Message: EMPTY MESSAGE' do
			expect(err_bp('nil_message')).to eq('Invalid Message: EMPTY MESSAGE')
		end
	end

end

describe 'CHARGING API [normal app]' do

	context 'Complete and Correct request parameters' do
		it 'responds with code 201' do
			expect(charge('ok').code).to eq('201')
		end
	end

	context 'Missing endUserId' do
		it 'Error: Missing parameters: endUserId' do
			expect(err_bp('endUserId')).to eq('Missing parameters: endUserId')
		end
	end
   
	context 'Missing amount' do
		it 'Error: Missing parameters: amount' do 
			expect(err_bp('amount')).to eq('Missing parameters: amount')
		end
	end

	context 'Missing referenceCode' do
		it 'Error: Missing parameters: referenceCode' do
			expect(err_bp('referenceCode')).to eq('Missing parameters: referenceCode')
		end
	end

	context 'Invalid reference code format' do
		it 'Error: Invalid Reference code' do
			expect(err_bp('chargingFormat')).to eq('Invalid referenceCode length')
		end
	end

	context 'Invalid reference code length' do
		it 'Error: Invalid reference code length' do
			expect(err_bp('chargingLength')).to eq('Invalid referenceCode length')
		end
	end

	context 'Invalid Rate' do
		it 'Error: App is not provisioned for this rate' do
			expect(err_bp('invalidRate')).to eq('App is not provisioned for this rate')
		end
	end

	context 'Invalid Token' do
		it 'Error: App is not provisioned for this rate' do
			expect(err_bp('chargingToken')).to eq('Invalid Token')
		end
	end

	context 'Insufficient balance [globe]' do
		it 'GHP subscriber has insufficient balance' do
			expect(err('insuff_globe')).to eq('Invalid Token')
		end
	end

	context 'Insufficient balance [tm]' do
		it 'TM subscriber has insufficient balance' do
			expect(err('insuff_tm')).to eq('Invalid Token')
		end
	end	

end

describe 'CHARGING API [by]' do

	context 'Complete and Correct request parameters' do
		it 'responds with code 201' do
			expect(charge_bp('ok').code).to eq('201')
		end
	end

	context 'Missing endUserId' do
		it 'Error: Missing parameters: endUserId' do
			expect(err_bp('endUserId')).to eq('Missing parameters: endUserId')
		end
	end
   
	context 'Missing amount' do
		it 'Error: Missing parameters: amount' do 
			expect(err_bp('amount')).to eq('Missing parameters: amount')
		end
	end

	context 'Missing referenceCode' do
		it 'Error: Missing parameters: referenceCode' do
			expect(err_bp('referenceCode')).to eq('Missing parameters: referenceCode')
		end
	end

	context 'Invalid reference code format' do
		it 'Error: Invalid Reference code' do
			expect(err_bp('chargingFormat')).to eq('Invalid referenceCode length')
		end
	end

	context 'Invalid reference code length' do
		it 'Error: Invalid reference code length' do
			expect(err_bp('chargingLength')).to eq('Invalid referenceCode length')
		end
	end

	context 'Invalid Rate' do
		it 'Error: App is not provisioned for this rate' do
			expect(err_bp('invalidRate')).to eq('App is not provisioned for this rate')
		end
	end

	context 'Insufficient balance' do
		it 'GHP subscriber has insufficient balance' do
			expect(err_bp('insuff_globe')).to eq('GHP subscriber has insufficient balance')
		end
	end

	context 'Insufficient balance [tm]' do
		it 'TM subscriber has insufficient balance' do
			expect(err_bp('insuff_tm')).to eq('TM subscriber has insufficient balance')
		end
	end	

end

describe 'LBS' do

	context 'Successful LBS request' do
		it "Returns the subscriber's coordinate" do
			expect(lbs('ok')).to #eq(long and lat not empty)
		end
	end

	context 'Invalid access_token' do
		it 'invalid access_token' do
			expect(err_lbs('')).to #400 series
		end
	end

	context 'Invalid accuracy' do
		it 'invalid acuracy' do
			expect(err_lbs('')).to #400 series
		end
	end

	context 'missing address parameter' do
		it 'missing address parameter' do
			expect(err_lbs('')).to #400 series
		end
	end

	context 'missing access_token' do
		it 'missing access_token' do
			expect(err_lbs('')).to #400 series
		end
	end

	context 'cellphone turned off' do
		it 'reuturn coordinates with a value of zero' do
			expect(err_lbs('')).to #400 series
		end
	end

end

describe 'RAVEN [Subscriber Data Query]' do

	context 'Successful query of current load' do
		it 'Successful query of current load' do
			expect(raven('')).to #400 series
		end
	end

	context 'Successful query of subscribed mobile promo' do
		it 'Successful query of subscribed mobile promo' do
			expect(raven('')).to #400 series
		end
	end

	context 'Query is invalid' do
		it 'It should only be bal or mobile_internet_promo' do
			expect(raven('')).to #400 series
		end
	end

	context 'Missing address' do
		it 'missing address parameter' do
			expect(err_raven('')).to #400 series
		end
	end

	context 'Missing access_token' do
		it 'missing access_token' do
			expect(err_raven('')).to #400 series
		end
	end

	context 'Invalid access_token' do
		it 'invalid access_token' do
			expect(err_raven('')).to #400 series
		end
	end

end


describe 'INVITE API' do

	##Invite api. pending



end




# ░░░░░░░░░▄░░░░░░░░░░░░░░▄░░░░
# ░WOW░░░░▌▒█░░░SUCH░░░░▄▀▒▌░░░
# ░░░░░░░░▌▒▒█░░TEST░░▄▀▒▒▒▐░░░
# ░░░░░░░▐▄▀▒▒▀▀▀▀▄▄▄▀▒▒▒▒▒▐░░░
# ░░░░░▄▄▀▒░▒▒▒▒▒▒▒▒▒█▒▒▄█▒▐░░░
# ░░░▄▀▒▒▒░░░▒▒▒░░░▒▒▒▀██▀▒▌░░░ 
# ░░▐▒▒▒▄▄▒▒▒▒░░░▒▒▒▒▒▒▒▀▄▒▒▌░░
# ░░▌░░▌█▀▒▒▒▒▒▄▀█▄▒▒▒▒▒▒▒█▒▐░░
# ░▐░░░▒▒▒▒▒▒▒▒▌██▀▒▒░░░▒▒▒▀▄▌░
# ░▌░▒▄██▄▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▌░
# ▀▒▀▐▄█▄█▌▄░▀▒▒░░░░░░░░░░▒▒▒▐░
# ▐▒▒▐▀▐▀▒░▄▄▒▄▒▒▒▒▒▒░▒░▒░▒▒▒▒▌
# ▐▒▒▒▀▀▄▄▒▒▒▄▒▒▒▒▒▒▒▒░▒░▒░▒▒▐░
# ░▌▒▒▒▒▒▒▀▀▀▒▒▒▒▒▒░▒░▒░▒░▒▒▒▌░
# ░▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒░▒▒▄▒▒▐░░
# ░░▀▄▒▒▒▒▒▒▒▒▒▒▒░▒░▒░▒▄▒▒▒▒▌░░
# ░░░░▀▄▒▒▒▒▒▒▒▒▒▒▄▄▄▀▒▒▒▒▄▀░░░
# ░░░░░░▀▄▄▄▄▄▄▀▀▀▒▒▒▒▒▄▄▀░░░░░
# ░░RSPEC░░▒▒▒▒▒▒▒▒▒▒▀▀░░░░░░░░
