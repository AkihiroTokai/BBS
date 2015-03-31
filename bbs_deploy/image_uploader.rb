def image_upload img
  
  contents = Contribution.last
  
  s3 = AWS::S3.new(
 :access_key_id => 'AKIAIQOXPM3PYHVP6QOQ',
 :secret_access_key => '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',
 :region => 'ap-northeast-1')
  bucket = s3.buckets['litmycollection'] 
  
  image = img
  
  fileName = File.extname(image[:filename])
  filePath = 'images/uploads/' + Time.now.to_i.to_s + fileName
  o = bucket.objects[filePath]
  o.write(image[:tempfile].read)
  o.acl = :public_read

  url_hash = o.public_url
  public_url = 'https://' + url_hash.host + url_hash.path
  
  contents.update_attribute(:img, public_url)
end

def image_upload_local img
  if img
    contents = Contribution.last
    id = contents.id
    logger.info img
    ext = img[:filename].split(".")[1]
    imgName = "#{id}-bbs.#{ext}"
    img_path = "/images/bbs/#{imgName}"
    contents.update_attribute(:img, img_path)

    save_path = "./public/images/bbs/#{imgName}"

    File.open(save_path, 'wb') do |f|
        p img[:tempfile]
        f.write img[:tempfile].read
        logger.info "アップロード成功"
    end
  else
      logger.info "アップロード失敗"
  end
end
  