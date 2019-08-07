require "refile/s3"

if Rails.env.production? 
	aws = {
	  access_key_id: ENV["AWS_KEY"],
	  secret_access_key: ENV["AWS_SECRET_KEY"],
	  region: ENV["AWS_REGION"],
	  bucket: ENV["AWS_PROD_BUCKET"],
	}
else
		aws = {
	  access_key_id: ENV["AWS_KEY"],
	  secret_access_key: ENV["AWS_SECRET_KEY"],
	  region: ENV["AWS_REGION"],
	  bucket: ENV["AWS_DEV_BUCKET"],
	}
end

Refile.cache = Refile::S3.new(prefix: "cache", **aws)
Refile.store = Refile::S3.new(prefix: "store", **aws)