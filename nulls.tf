resource "null_resource" "get_curl_google"{
    provisioner "local-exec" {
        command = "curl http://google.com"
    }
}

resource "aws_eip" "null_test" {
    domain = "vpc"
    depends_on = [null_resource.get_curl_google]
}