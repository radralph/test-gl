Gl-TESTER
=========
This test runs through GL's APis:<br /><br />
-SMS  <br>
-CHARGING <br>

Start Using Gl-Tester
----------

Clone repo:
```
git clone https://github.com/radralph/gl-tester.git
```
Run bundle:
```
$bundle
```

Usage
----------
Run all test:
```
$rspec spec
```
Print results:
```
$rspec spec --format documentation --out rspec.txt
```

Test scenarios with tags:<br />
<pre>
Sample Test Case:<br />

context 'invalid parameter', :focus => true do<br />
		it 'Error: Missing parameters: endUserId' do<br />
			expect('error')).to eq('error')<br />
		end<br />
	end<br />
</pre>

Execute tagged scenario:
```
$rspec spec --tag focus
```

Test it with DOGE formatter!
```
$rspec --format Dogespec::Formatter --color spec
```

Contributing
-------------
Fork it ( http://github.com/radralph/gl-tester/fork )<br>
Create your feature branch (git checkout -b my-new-feature)<br>
Commit your changes (git commit -am 'Add some feature')<br>
Push to the branch (git push origin my-new-feature)<br>