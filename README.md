# PDF.co for Ruby on Rails

## Installation 

To add `pdfco` to your project, add this line to your `Gemfile`

```ruby
gem 'pdfco', git: 'https://github.com/bytescout/pdfco-gem'
```

And then rebuild gems:

```
bundle
```

Or install it from global repository yourself as:

`gem install pdfco`

## Intialization

To start using it after installation you will need to run the following and supply your x-api-key in config/initializers/pdfco.rb
    
`rails g pdfco:initialize`

Now set your API key for PDF.co in this file

```
config/initializers/pdfco.rb
```

You can get your API key at https://pdf.co

### Using PDF.co gem

You can send calls to any API methods listed at https://apidocs.pdf.co 
From pdf filler, pdf merger, pdf spliter to document extractor

You can make request to **any** PDF.co API endpoints just by replacing `/` in endpoint path to `_` (underscore)

Examples

```ruby
# To call `/pdf/find` endpoint use this method:
Pdfco::Server.pdf_find(params, request_verb)

# to call /pdf/edit/add endpoint use this method:
Pdfco::Server.pdf_edit_add(params, request_verb)

```

**Parameters**:

- **params** body parameters  
- (optional) **endpoint_url** - you can override endpoint URL you want to hit
- (optional) **request_verb** takes the HTTP method(:get, :post etc). The default **request_verb** is **:post** type.

#### Samples:

#### [POST] /pdf/find

```ruby
Pdfco::Server.pdf_find({
  "async": "false",
  "encrypt": "false",
  "url": "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-text/sample.pdf",
  "searchString": "Invoice Date \\d+/\\d+/\\d+",
  "regexSearch": "true",
  "name": "output",
   "pages": "0-",
  "inline": "true",
  "wordMatchingMode": "",
  "password": ""
})
```

**Response**:

```json
{
  "status":  200,
  "body": {
    "url":  "https://pdf-temp-files.s3.amazonaws.com/fd9d0a276a9f4b01b6d14e782d9134e7/sample.xls",
    "pageCount":  1,
    "error":  false,
    "status":  200,
    "name":  "sample.xls",
    "remainingCredits":  87223
  }
}
```

#### [POST] /pdf/split
```ruby
Pdfco::Server.pdf_split({
  "url": "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-split/sample.pdf",
  "pages": "1-2,3-",
  "name": "result.pdf"
})
```

**Response**:

```json
{
  "status":  200,
  "body":  {
    "urls":  [
      "https://pdf-temp-files.s3.amazonaws.com/c570be922fc84ea38cd994807be4f8cf/result_page1-2.pdf",
      "https://pdf-temp-files.s3.amazonaws.com/40fab6d56f494bf7b7bc0f6fbca9590a/result_page3-4.pdf"
    ],
    "pageCount":  4,
    "error":  false,
    "status":  200,
    "name":  "result.pdf",
    "remainingCredits":  87208
  }
}
```

#### [GET] /file/upload/get-presigned-url?name=test.pdf&encrypt=true

```ruby
# /file/upload/get-presigned-url
Pdfco::Server.file_upload({hyphenated_url: 'get-presigned-url', name: 'test.pdf', encrypt: true}, :get)
```

**Response** format is
```json
{
  "status":  200,
  "body":  {
    "presignedUrl":  "https://pdf-temp-files.s3-us-west-2.amazonaws.com/e42bacf585414eb8b64719311c3a0074/test.pdf?X-Amz-Expires=900&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIZJDPLX6D7EHVCKA/20201014/us-west-2/s3/aws4_request&X-Amz-Date=20201014T102215Z&X-Amz-SignedHeaders=host&X-Amz-Signature=8bf9a5acc86ed793f7868b9d219c7e833599cd34d6c37e88987ced0009069290",
    "url":  "https://pdf-temp-files.s3.amazonaws.com/e42bacf585414eb8b64719311c3a0074/test.pdf",
    "error":  false,
    "status":  200,
    "name":  "test.pdf",
    "remainingCredits":  87195
  }
}
```
#### [GET] /file/upload/url?url=#{someurl}

```ruby
Pdfco::Server.file_upload_url({url: 'https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-split/sample.pdf'}, :get)
```

**Response**:

```json
{
  "status":  200,
  "body":  {
  "url":  "https://pdf-temp-files.s3.amazonaws.com/48716cc4a6b149fcaf8e1e5f1ecd6b77/sample.pdf",
  "error":  false,
  "status":  200,
  "name":  "sample.pdf",
  "remainingCredits":  87232
  }
}
```

#### Error Response Format

**Invalid API Key** error

```ruby
<Pdfco::UnAuthorizedError: This API key was not found. Please sign up for your API key at https://app.pdf.co/>
error.status => 401
error.message => "This API key was not found. Please sign up for your API key at https://app.pdf.co/"
error.headers => {...} Headers hash
```

#### Invalid endpoint url

```
Pdfo::Server.some_wrong_url({})
```

We'll get this **response**
```ruby
<Pdfco::MethodNotFoundError: method not found. Please check API documentation at https://apidocs.pdf.co/>
error.status => 404
error.method => "method not found. Please check API documentation at https://apidocs.pdf.co/"
error.headers => {...} Headers hash
```

## Gem Development Notes

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

Create pull requests with suggested changes.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/pdfco. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Pdfco project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/pdfco/blob/master/CODE_OF_CONDUCT.md).