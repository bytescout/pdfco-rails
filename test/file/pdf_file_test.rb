require './test/test_helper'

class PdfcoFileTest < Minitest::Test
  def test_exists
    assert Pdfco::PdfFile

  end

  def test_it_gives_back_a_single_file
    VCR.use_cassette('one_file', :match_requests_on => [:method, :uri]) do
      file = Pdfco::PdfFile.by_name('test.pdf')
      assert_equal Pdfco::PdfFile, file.class

      # Check that the fields are accessible by our model
      assert_equal file.presigned_url, "https://pdf-temp-files.s3-us-west-2.amazonaws.com/4ec6c4b287c9480998a89fc2daf2fb35/test.pdf?X-Amz-Expires=900&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIZJDPLX6D7EHVCKA/20200930/us-west-2/s3/aws4_request&X-Amz-Date=20200930T220138Z&X-Amz-SignedHeaders=host&X-Amz-Signature=2e79c3da97aa714bed4bc07ee86310b08064c637326dfbb2de25beff6e9748f4"
      assert_equal file.url, "https://pdf-temp-files.s3-us-west-2.amazonaws.com/4ec6c4b287c9480998a89fc2daf2fb35/test.pdf?X-Amz-Expires=3600&x-amz-security-token=FwoGZXIvYXdzEE8aDC3f5asphuB%2BTgwG%2FCKBAVCoP5fZ%2B0foZWFWk%2Bvuk9%2B1QVOQnImr0O%2FWwFw1LWPT2QnpqO2Fse0xywZe4uNayoEXI5cgRrikIL4fEUT%2F3tw9nRo2BDBo4SfG0IiaWBCBFWRykK9c15ybrGUL3CXtgx5aCUR%2Fc4yUdFvSs6q2Ax4fb%2FFGZWaJ7IrsclwQqh7UKCjEgNT7BTIog4CFMrnnx52nBOr7LgBYmxZ5HnB46kCvreuR6HC2Tj%2B5Im6SfLRiBw%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA4NRRSZPHEU7D7L4M/20200930/us-west-2/s3/aws4_request&X-Amz-Date=20200930T220139Z&X-Amz-SignedHeaders=host;x-amz-security-token&X-Amz-Signature=64e79618fc0e49b6ed12b9394b83b26a52a2d7f7595d316a6d007cf90e7b0959"
      assert_equal file.file_name, 'test.pdf'
    end
  end
end