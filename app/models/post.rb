class Post < ApplicationRecord
  has_one_attached :post_cover
  has_one_attached :file_cover
  has_many_attached :multiple_files

  def post_cover_url
    post_cover.attached? ? Rails.application.routes.url_helpers.rails_blob_url(post_cover, only_path: true) : nil
  end

  def file_url
    file_cover.attached? ? Rails.application.routes.url_helpers.rails_blob_url(file_cover, only_path: true) : nil
  end

  def multiple_file_urls
    multiple_files.map do |file|
      Rails.application.routes.url_helpers.rails_blob_url(file, only_path: true)
    end
  end

  validates :title, presence: { message: "title cannot be blank" }
  validates :body, presence: { message: "body cannot be blank" }
  validates :post_cover, attached: true, content_type: ["image/png", "image/jpeg", "image/jpg"],
                         size: { less_than: 1.megabytes, message: "cover too large" }

  validates :file_cover, content_type: ["application/pdf", "application/docx", "application/xlsx", message: "file must pdf, docx, or xlsx"],
                         size: { less_than: 1.megabytes, message: "file too large" }

  validates :multiple_files, size: { less_than: 10.megabytes, message: "files too large" }
end
