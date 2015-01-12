require 'net/http'
require 'json'
require 'open-uri'


##Init Vars
	$insuff_globe = "9062058446"
	$insuff_tm = "9368723185" 
	$address = "9175744034"
  	$message = "TEST"
##SMS Normal APP
	$uri = URI.parse("http://devapi.globelabs.com.ph/smsmessaging/v1/outbound/7117/requests")
  	$uri.query = "access_token=#{$accessToken}"
##SMS Bypassed App
  	$uriBp = URI.parse("http://devapi.globelabs.com.ph/smsmessaging/v1/outbound/3822/requests")
  	$uriBp.query = "app_secret=#{$appSecret}&app_id=#{$appId}"
##Charging Normal APP
    content = open('http://devapi.globelabs.com.ph/payments/548').read
	json = JSON.parse(content)
	$increment1 = json['result'].last['reference_code'].to_i+1
	$uric = URI.parse("http://devapi.globelabs.com.ph/payment/v1/transactions/amount/")
	$uric.query = "access_token=#{$access_token}"
##Charging Bypassed APP
    content = open('http://devapi.globelabs.com.ph/payments/251').read
	json = JSON.parse(content)
	$increment2 = json['result'].last['reference_code'].to_i+1
	$uricBp = URI.parse("http://devapi.globelabs.com.ph/payment/v1/transactions/amount/")
	$uricBp.query = "app_secret=#{$appSecret}&app_id=#{$appId}"
##xTelco
	$smart = "9213151819"
##Staging endpoiints
	#placeholder only
	$Suri = URI.parse("http://devapi.globelabs.com.ph/staging/smsmessaging/v1/outbound/3822/requests")


def pushSms(param)
	case param
	when 'ok'
		#filler
	when 'sms160'
		$message = ("A" * 160) + ("B" * 10)
	when 'sms320'
		$message = ("A" * 320) + ("B" * 10)
	when 'prefix' 
		$uri = URI.parse("http://devapi.globelabs.com.ph/smsmessaging/v1/outbound/21587117/requests")
		$uri.query = "access_token=#{$accessToken}"
	when 'extended'
		$uri = URI.parse("http://devapi.globelabs.com.ph/smsmessaging/v1/outbound/215871171234567/requests")
		$uri.query = "access_token=#{$accessToken}"
	end
	Net::HTTP.post_form($uri, {'address' => $address, 'message' => $message})
end

def pushSms_bp(param)
	case param
	when 'sms160'
		$message = ("A" * 160) + ("B" * 10)
	when 'sms320'
		$message = ("A" * 320) + ("B" * 10)
	when 'prefix' 
		$uriBp = URI.parse("http://devapi.globelabs.com.ph/smsmessaging/v1/outbound/21587117/requests")
		$uriBp.query = "app_secret=#{$appSecret}&app_id=#{$appId}"
	when 'extended'
		$uri = URI.parse("http://devapi.globelabs.com.ph/smsmessaging/v1/outbound/215871171234567/requests")
		$uriBp.query = "app_secret=#{$appSecret}&app_id=#{$appId}"
	end
	Net::HTTP.post_form($uriBp, {'address' => $address, 'message' => $message, 'passphrase' => $passphrase})	
end

def xTelco(param)
	case param
	when 'ok'
		#filler
	when 'sms160'
		$message = ("A" * 160) + ("B" * 10)
	when 'sms320'
		$message = ("A" * 320) + ("B" * 10)
	when 'prefix' 
		$uriBp = URI.parse("http://devapi.globelabs.com.ph/smsmessaging/v1/outbound/21587117/requests")
		$uriBp.query = "app_secret=#{$appSecret}&app_id=#{$appId}"
	when 'extended'
		$uri = URI.parse("http://devapi.globelabs.com.ph/smsmessaging/v1/outbound/215871171234567/requests")
		$uriBp.query = "app_secret=#{$appSecret}&app_id=#{$appId}"
	end
	Net::HTTP.post_form($uriBp, {'address' => $smart, 'message' => $message, 'passphrase' => $passphrase})
end



def err(param)
	case param
	when 'invalidToken'
		uri = $uri ; uri.query = "access_token=A11Y0uRb@$3RBe1onG2Us"
		response = Net::HTTP.post_form(uri, {'address' => $address, 'message' => $message})
	when 'token'
		uri = $uri ; uri.query = ""
		response = Net::HTTP.post_form(uri, {'address' => $address, 'message' => $message})	
	when 'address'
		uri = URI.parse("http://devapi.globelabs.com.ph/smsmessaging/v1/outbound/7117/requests") ; uri.query = "access_token=#{$accessToken}"
		response = Net::HTTP.post_form(uri, {'message' => $message})	
	when 'message'
		uri = $uri ; uri.query = "access_token=#{$accessToken}"
		response = Net::HTTP.post_form($uri, {'address' => $address}) 
	when 'invalidSub'
		response = Net::HTTP.post_form($uri, {'address' => 9062058446, 'message' => $message})
	when 'nil_message'
		response = Net::HTTP.post_form($uri, {'address' => $address, 'message' => ''})
	when 'extended_err'
		uri = URI.parse("http://devapi.globelabs.com.ph/smsmessaging/v1/outbound/711712345678/requests")
		uri.query = $uri.query
		response = Net::HTTP.post_form(uri, {'address' => $address, 'message' => $message})
	
	###new tests
	when 'chargingLength'
		response = Net::HTTP.post_form($uric, {'description' => 'desc', 'amount' => "0.00", 'endUserId', => $address,'referenceCode' => 3822100000000001,
	      'transactionOperationStatus' => 'charged'})
	when 'invalidRate'
		response = Net::HTTP.post_form($uric, {'description' => 'desc', 'amount' => "0.50", 'endUserId', => $address,'referenceCode' => 3822100000000001,
	      'transactionOperationStatus' => 'charged'})
	when 'chargingToken'
		response = Net::HTTP.post_form($uric, {'description' => 'desc', 'amount' => "0.50", 'endUserId', => $address,'referenceCode' => 3822100000000001,
	      'transactionOperationStatus' => 'charged'})
	when 'insuff_globe'
		response = Net::HTTP.post_form($uric, {'description' => 'desc', 'amount' => "0.50", 'endUserId', => $insuff_globe,'referenceCode' => 3822100000000001,
	      'transactionOperationStatus' => 'charged'})
	when 'insuff_tm'
		response = Net::HTTP.post_form($uric, {'description' => 'desc', 'amount' => "0.50", 'endUserId', => $insuff_tm, 'referenceCode' => 3822100000000001,
	      'transactionOperationStatus' => 'charged'})
	end
	parseBody(response) 
end

def err_bp(param)
	case param
	when 'invalidIdSecret'
		uri = $uri ; uri.query = "app_id=A11Y0uRb@$3&app_secret=RBe1onG2Us"
		response = Net::HTTP.post_form(uri, {'address' => $address, 'message' => $message, 'passphrase' => $passphrase})
	when 'idSecret'
		uri = $uri ; uri.query = ""
		response = Net::HTTP.post_form(uri, {'address' => $address, 'message' => $message, 'passphrase' => $passphrase})	
	when 'address'
		response = Net::HTTP.post_form($uri, {'message' => $message, 'passphrase' => $passphrase})	
	when 'message'
		response = Net::HTTP.post_form($uri, {'address' => $address, 'passphrase' => $passphrase}) 
	when 'nil_message'
		uri = $uriBp ; uri.query = $uriBp.query
		response = Net::HTTP.post_form(uri, {'address' => $address, 'message' => '', 'passphrase' => $passphrase}) 
	when 'extended_err'
		uri = URI.parse("http://devapi.globelabs.com.ph/smsmessaging/v1/outbound/711712345678/requests")
		uri.query = $uri.query
		response = Net::HTTP.post_form(uri, {'address' => $address, 'message' => $message, 'passphrase' => $passphrase})
	when 'endUserId'
		response = Net::HTTP.post_form($uric, {'description' => 'desc', 'amount' => "0.00", 'referenceCode' => $increment,
		      'transactionOperationStatus' => 'charged', 'passphrase' => ''})
	when 'endUserId'
		response = Net::HTTP.post_form($uricBp, {'description' => 'desc', 'amount' => "0.00", 'referenceCode' => $increment,
		      'transactionOperationStatus' => 'charged', 'passphrase' => ''})
	when 'amount'
		response = Net::HTTP.post_form($uricBp, {'description' => 'desc', 'endUserId' => $address, 'referenceCode' => $increment,
		      'transactionOperationStatus' => 'charged', 'passphrase' => ''})
	when 'amount'
		response = Net::HTTP.post_form($uric, {'description' => 'desc', 'endUserId' => $address, 'referenceCode' => $increment,
		      'transactionOperationStatus' => 'charged', 'passphrase' => ''})
	when 'referenceCode'
		response = Net::HTTP.post_form($uric, {'description' => 'desc', 'endUserId' => $address, 
			'amount' => "0.00", 'transactionOperationStatus' => 'charged', 'passphrase' => ''})
	when 'referenceCode'
		response = Net::HTTP.post_form($uricBp, {'description' => 'desc', 'endUserId' => $address, 
			'amount' => "0.00", 'transactionOperationStatus' => 'charged', 'passphrase' => ''})
	when 'invalidRate'
		response = Net::HTTP.post_form($uric, {'description' => 'desc', 'endUserId' => $address, 'referenceCode' => $increment,
			'amount' => "0.50", 'transactionOperationStatus' => 'charged', 'passphrase' => ''})
	when 'invalidRate'
		response = Net::HTTP.post_form($uricBp, {'description' => 'desc', 'endUserId' => $address, 'referenceCode' => $increment,
			'amount' => "0.50", 'transactionOperationStatus' => 'charged', 'passphrase' => ''})
	when 'chargingLength'
		response = Net::HTTP.post_form($uric, {'description' => 'desc', 'endUserId' => $address, 'referenceCode' => $increment,
			'amount' => "0.00", 'transactionOperationStatus' => 'charged', 'passphrase' => ''})
	when 'chargingLength'
		response = Net::HTTP.post_form($uricBp, {'description' => 'desc', 'endUserId' => $address, 'referenceCode' => $increment,
			'amount' => "0.00", 'transactionOperationStatus' => 'charged', 'passphrase' => ''})
	when 'chargingFormat'
		response = Net::HTTP.post_form($uric, {'description' => 'desc', 'endUserId' => $address, 'referenceCode' => $increment,
			'amount' => "0.00", 'transactionOperationStatus' => 'charged', 'passphrase' => ''})
	when 'chargingFormat'
		response = Net::HTTP.post_form($uricBp, {'description' => 'desc', 'endUserId' => $address, 'referenceCode' => $increment,
			'amount' => "0.00", 'transactionOperationStatus' => 'charged', 'passphrase' => ''})
	when 'insuff_globe'
		response = Net::HTTP.post_form($uric, {'description' => 'desc', 'endUserId' => $insuff_globe, 'referenceCode' => $increment,
			'amount' => "0.00", 'transactionOperationStatus' => 'charged', 'passphrase' => ''})
	when 'insuff_globe'
		response = Net::HTTP.post_form($uricBp, {'description' => 'desc', 'endUserId' => $insuff_globe, 'referenceCode' => $increment,
			'amount' => "0.00", 'transactionOperationStatus' => 'charged', 'passphrase' => ''})
	when 'insuff_tm'
		response = Net::HTTP.post_form($uric, {'description' => 'desc', 'endUserId' => $insuff_tm, 'referenceCode' => $increment,
			'amount' => "0.00", 'transactionOperationStatus' => 'charged', 'passphrase' => ''})
	end
	when 'insuff_tm'
		response = Net::HTTP.post_form($uricBp, {'description' => 'desc', 'endUserId' => $insuff_tm, 'referenceCode' => $increment,
			'amount' => "0.00", 'transactionOperationStatus' => 'charged', 'passphrase' => ''})
	end
	parseBody(response) 
end

def charge(param)
	case param
	when 'ok'
		#filler 
	end
	Net::HTTP.post_form($uric, {'description' => 'desc',
		    'endUserId' => $address, 'amount' => "0.00", 'referenceCode' => $increment1,
		      'transactionOperationStatus' => 'charged'})
end

def charge_bp(param)
	case param
	when 'ok'
		#filler 
	end	
	Net::HTTP.post_form($uricBp, {'description' => 'desc',
		    'endUserId' => $address, 'amount' => "0.00", 'referenceCode' => $increment2,
		      'transactionOperationStatus' => 'charged', 'passphrase' => $passphrase})
end

def parseBody(response)
	JSON.parse(response.body)['error']
end

# LOOK SON!!! AN AMATEUR!!!!!!
# ─────────────────────────▄▀▄
# ─────────────────────────█─█
# ─────────────────────────█─█
# ─────────────────────────█─█
# ─────────────────────────█─█
# ─────────────────────────█─█
# ─────────────────────────█─▀█▀█▄
# ─────────────────────────█──█──█
# ─────────────────────────█▄▄█──▀█
# ────────────────────────▄█──▄█▄─▀█
# ────────────────────────█─▄█─█─█─█
# ────────────────────────█──█─█─█─█
# ────────────────────────█──█─█─█─█
# ────▄█▄──▄█▄────────────█──▀▀█─█─█
# ──▄█████████────────────▀█───█─█▄▀
# ─▄███████████────────────██──▀▀─█
# ▄█████████████────────────█─────█
# ██████████───▀▀█▄─────────▀█────█
# ████████───▀▀▀──█──────────█────█
# ██████───────██─▀█─────────█────█
# ████──▄──────────▀█────────█────█
# ███──█──────▀▀█───▀█───────█────█
# ███─▀─██──────█────▀█──────█────█
# ███─────────────────▀█─────█────█
# ███──────────────────█─────█────█
# ███─────────────▄▀───█─────█────█
# ████─────────▄▄██────█▄────█────█
# ████────────██████────█────█────█
# █████────█──███████▀──█───▄█▄▄▄▄█
# ██▀▀██────▀─██▄──▄█───█───█─────█
# ██▄──────────██████───█───█─────█
# ─██▄────────────▄▄────█───█─────█
# ─███████─────────────▄█───█─────█
# ──██████─────────────█───█▀─────█
# ──▄███████▄─────────▄█──█▀──────█
# ─▄█─────▄▀▀▀█───────█───█───────█
# ▄█────────█──█────▄███▀▀▀▀──────█
# █──▄▀▀────────█──▄▀──█──────────█
# █────█─────────█─────█──────────█
# █────────▀█────█─────█─────────██
# █───────────────█──▄█▀─────────█
# █──────────██───█▀▀▀───────────█
# █───────────────█──────────────█
# █▄─────────────██──────────────█
# ─█▄────────────█───────────────█
# ──██▄────────▄███▀▀▀▀▀▄────────█
# ─█▀─▀█▄────────▀█──────▀▄──────█
# ─█────▀▀▀▀▄─────█────────▀─────█
# ─█─────────▀▄──▀───────────────█